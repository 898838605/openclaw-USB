@echo off
setlocal EnableDelayedExpansion
chcp 936 >nul
title OpenClaw-USB 维护工具

:: ==============================================
:: 脚本说明
:: 维护 + 高级功能菜单（对应选项 0~12）
:: 路径完全基于之前提问的结构：
::   %~dp0openclaw-USB\node          <-- 本地 Node.js
::   %~dp0openclaw-USB\openclaw     <-- 项目目录（含 node_modules）
::   %~dp0openclaw-USB\data         <-- 数据根目录
::       ├── .openclaw\             <-- 状态/配置文件
::       ├── logs\                  <-- 日志
::       ├── backups\               <-- 备份
::       └── memory\                <-- 记忆数据
:: ==============================================

:: ==============================================
:: 路径配置
:: %~dp0 = 脚本自身所在目录（含末尾反斜杠）
:: ==============================================
set "SCRIPT_DIR=%~dp0"
set "NODE_DIR=%SCRIPT_DIR%openclaw-USB\node"
set "APP_DIR=%SCRIPT_DIR%openclaw-USB\openclaw"
set "DATA_DIR=%SCRIPT_DIR%openclaw-USB\data"
set "STATE_DIR=%DATA_DIR%\.openclaw"
set "LOG_DIR=%DATA_DIR%\logs"
set "BACKUP_DIR=%DATA_DIR%\backups"
set "MEMORY_DIR=%DATA_DIR%\memory"
set "OPENCLAW_HOME=%DATA_DIR%"          
set "OPENCLAW_STATE_DIR=%STATE_DIR%"    

:: ==============================================
:: 环境变量（仅当前窗口有效）
:: ==============================================
set "PATH=%NODE_DIR%;%PATH%"
set "NODE_PATH=%APP_DIR%\node_modules"
set "OPENCLAW_HOME=%DATA_DIR%"
set "OPENCLAW_STATE_DIR=%STATE_DIR%"
set "OPENCLAW_CONFIG_PATH=%STATE_DIR%\openclaw.json"

:: ==============================================
:: 预检：Node.js 和 openclaw 必须存在
:: ==============================================
if not exist "%NODE_DIR%\node.exe" (
    echo [错误] 找不到 Node.js: %NODE_DIR%\node.exe
    pause
    exit /b 1
)
if not exist "%APP_DIR%\node_modules\openclaw" (
    echo [错误] 未安装 openclaw，请先运行安装脚本
    pause
    exit /b 1
)

:: ==============================================
:: 自动创建数据子目录（首次运行时）
:: ==============================================
if not exist "%STATE_DIR%" mkdir "%STATE_DIR%"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
if not exist "%MEMORY_DIR%" mkdir "%MEMORY_DIR%"

:: ==============================================
:: 主菜单循环
:: ==============================================
:menu
cls
echo.
echo   ========================================
echo     OpenClaw-USB 维护工具
echo   ========================================
echo.
if exist "%NODE_DIR%\node.exe" (
    for /f "tokens=*" %%v in ('"%NODE_DIR%\node.exe" --version') do echo   Node: %%v
)
if exist "%STATE_DIR%\openclaw.json" (echo   配置: 已存在) else (echo   配置: 未设置)
echo.
echo   -- 维护 --
echo   [1] 诊断修复
echo   [2] 备份配置
echo   [3] 恢复备份
echo   [4] 系统信息
echo.
echo   -- 高级 --
echo   [5]  清理残留进程
echo   [6]  查看日志
echo   [7]  恢复出厂设置
echo   [8]  卸载
echo   [9]  检查更新
echo   [10] 磁盘清理
echo   [11] 插件管理
echo   [12] 清理缓存垃圾
echo.
echo   [0]  返回/退出
echo.
set /p choice="  请选择 [0-12]: "

if "!choice!"=="1" goto :doctor
if "!choice!"=="2" goto :backup
if "!choice!"=="3" goto :restore
if "!choice!"=="4" goto :sysinfo
if "!choice!"=="5" goto :killproc
if "!choice!"=="6" goto :viewlogs
if "!choice!"=="7" goto :factoryreset
if "!choice!"=="8" goto :uninstall
if "!choice!"=="9" goto :checkupdate
if "!choice!"=="10" goto :diskcleanup
if "!choice!"=="11" goto :plugins
if "!choice!"=="12" goto :clearcache
if "!choice!"=="0" exit /b 0

echo   无效选项
pause
goto :menu

:: ==============================================
:: [1] 诊断修复
:: 调用 openclaw 内置诊断工具，自动检测并修复问题
:: ==============================================
:doctor
echo.
echo   === 诊断修复 ===
echo.
cd /d "%APP_DIR%"
call npx openclaw doctor --repair
if errorlevel 1 (
    echo.
    echo [提示] 自动修复失败，尝试基础诊断...
    call npx openclaw doctor
)
pause
goto :menu

:: ==============================================
:: [2] 备份配置
:: 备份 openclaw.json 配置文件和 memory 记忆数据
:: 自动生成带时间戳的备份文件夹
:: ==============================================
:backup
echo.
echo   === 备份配置 ===
echo.
set "TS=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
set "TS=!TS: =0!"
set "BK=%BACKUP_DIR%\backup_!TS!"
mkdir "!BK!" 2>nul

set "BK_COUNT=0"
if exist "%STATE_DIR%\openclaw.json" (
    copy "%STATE_DIR%\openclaw.json" "!BK!\" >nul
    echo   [√] openclaw.json
    set /a BK_COUNT+=1
)
if exist "%MEMORY_DIR%" (
    xcopy /s /q "%MEMORY_DIR%" "!BK!\memory\" >nul 2>nul
    if exist "!BK!\memory" (
        echo   [√] memory/
        set /a BK_COUNT+=1
    )
)

echo.
if !BK_COUNT!==0 (
    echo   没有可备份的数据
    rmdir "!BK!" 2>nul
) else (
    echo   备份完成: !BK!
)
pause
goto :menu

:: ==============================================
:: [3] 恢复备份
:: 列出所有备份，按编号选择恢复
:: ==============================================
:restore
echo.
echo   === 恢复备份 ===
echo.
set "BK_NUM=0"
for /d %%d in ("%BACKUP_DIR%\*") do (
    set /a BK_NUM+=1
    echo   [!BK_NUM!] %%~nxd
    set "BK_PATH_!BK_NUM!=%%d"
)

if !BK_NUM!==0 (
    echo   没有找到备份
    pause
    goto :menu
)

echo.
set /p rnum="  输入编号恢复 (直接回车取消): "
if "!rnum!"=="" goto :menu

set "RESTORE_PATH=!BK_PATH_%rnum%!"
if "!RESTORE_PATH!"=="" (
    echo   无效编号
    pause
    goto :menu
)

if exist "!RESTORE_PATH!\openclaw.json" (
    copy "!RESTORE_PATH!\openclaw.json" "%STATE_DIR%\" >nul
    echo   [√] 配置已恢复
)
if exist "!RESTORE_PATH!\memory" (
    xcopy /s /q "!RESTORE_PATH!\memory" "%MEMORY_DIR%\" >nul 2>nul
    echo   [√] 记忆数据已恢复
)
echo.
echo   恢复完成
pause
goto :menu

:: ==============================================
:: [4] 系统信息
:: 显示系统版本、Node 版本、路径、占用空间等
:: ==============================================
:sysinfo
echo.
echo   === 系统信息 ===
echo.
echo   系统:    Windows
for /f "tokens=2 delims==" %%v in ('wmic os get Version /format:list 2^>nul ^| findstr "="') do echo   版本:    %%v
for /f "tokens=2 delims==" %%v in ('wmic os get OSArchitecture /format:list 2^>nul ^| findstr "="') do echo   架构:    %%v
echo.
echo   脚本目录: %SCRIPT_DIR%
echo   Node目录: %NODE_DIR%
echo   项目目录: %APP_DIR%
echo   数据目录: %DATA_DIR%
echo   状态目录: %STATE_DIR%
echo.
echo   Node版本:
"%NODE_DIR%\node.exe" --version
echo.
if exist "%APP_DIR%\node_modules\openclaw\package.json" (
    for /f "tokens=2 delims=:" %%v in ('findstr /c:"\"version\"" "%APP_DIR%\node_modules\openclaw\package.json"') do (
        set "VER=%%v"
        set "VER=!VER:~2,-2!"
        echo   OpenClaw: !VER!
    )
)
echo.
echo   占用空间:
for /f "tokens=*" %%s in ('powershell -command "(Get-ChildItem '%SCRIPT_DIR%' -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB" 2^>nul') do echo   总计:    %%s MB
pause
goto :menu

:: ==============================================
:: [5] 清理残留进程
:: 强制结束所有 node.exe 进程（openclaw 运行时残留）
:: ==============================================
:killproc
echo.
echo   === 清理残留进程 ===
echo.
echo   正在扫描 node.exe 进程...
set "FOUND=0"
for /f "skip=3 tokens=2" %%p in ('tasklist /fi "imagename eq node.exe" /fo table 2^>nul') do (
    set "FOUND=1"
    echo   发现 PID: %%p
)

if "!FOUND!"=="0" (
    echo   没有发现残留进程
    pause
    goto :menu
)

echo.
set /p killconfirm="  是否结束这些进程? (y/N): "
if /i not "!killconfirm!"=="y" (
    echo   已取消
    pause
    goto :menu
)

taskkill /F /IM node.exe >nul 2>&1
echo   已清理
pause
goto :menu

:: ==============================================
:: [6] 查看日志
:: 查看 %LOG_DIR% 下的日志文件，支持查看全部或单条
:: ==============================================
:viewlogs
echo.
echo   === 查看日志 ===
echo.
if not exist "%LOG_DIR%" (
    echo   日志目录不存在
    pause
    goto :menu
)

set "LOG_NUM=0"
for %%f in ("%LOG_DIR%\*.log") do (
    set /a LOG_NUM+=1
    echo   [!LOG_NUM!] %%~nxf
    set "LOG_FILE_!LOG_NUM!=%%f"
)

if !LOG_NUM!==0 (
    echo   没有日志文件
    pause
    goto :menu
)

echo.
set /p lnum="  输入编号查看 (a=全部, 回车取消): "
if "!lnum!"=="" goto :menu
if "!lnum!"=="a" (
    for %%f in ("%LOG_DIR%\*.log") do (
        echo.
        echo   ===== %%~nxf =====
        type "%%f"
    )
) else (
    set "SEL=!LOG_FILE_%lnum%!"
    if "!SEL!"=="" (
        echo   无效编号
    ) else (
        echo.
        type "!SEL!"
    )
)
pause
goto :menu

:: ==============================================
:: [7] 恢复出厂设置
:: 备份当前数据后，删除配置和记忆，生成默认配置
:: ==============================================
:factoryreset
echo.
echo   === 恢复出厂设置 ===
echo.
echo   警告: 此操作将删除所有配置和记忆数据！
echo.
echo   操作内容:
echo     1. 自动备份当前数据
echo     2. 删除配置文件
echo     3. 清空记忆数据
echo     4. 生成默认配置
echo.
echo   输入 RESET 确认:
set /p resetconfirm="  > "
if not "!resetconfirm!"=="RESET" (
    echo   已取消
    pause
    goto :menu
)

echo.
echo   [1/4] 正在备份...
set "TS=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%"
set "TS=!TS: =0!"
set "BK=%BACKUP_DIR%\pre-reset_!TS!"
mkdir "!BK!" 2>nul
if exist "%STATE_DIR%\openclaw.json" copy "%STATE_DIR%\openclaw.json" "!BK!\" >nul 2>nul
if exist "%MEMORY_DIR%" xcopy /s /q "%MEMORY_DIR%" "!BK!\memory\" >nul 2>nul
echo   备份保存: !BK!

echo   [2/4] 删除配置...
del "%STATE_DIR%\openclaw.json" 2>nul

echo   [3/4] 清空记忆...
rmdir /s /q "%MEMORY_DIR%" 2>nul
mkdir "%MEMORY_DIR%" 2>nul

echo   [4/4] 生成默认配置...
(echo {"gateway":{"mode":"local","auth":{"token":"openclaw"}}})>"%STATE_DIR%\openclaw.json"

echo.
echo   恢复出厂完成！请重新运行设置向导配置。
pause
goto :menu

:: ==============================================
:: [8] 卸载
:: 便携版无需卸载程序，直接提示删除文件夹
:: ==============================================
:uninstall
echo.
echo   === 卸载 ===
echo.
echo   当前为便携版，无需卸载程序。
echo   直接删除以下文件夹即可完全移除:
echo   %SCRIPT_DIR%
echo.
echo   数据目录:
echo   %DATA_DIR%
echo.
echo   是否打开文件夹? (y/N)
set /p openfolder="  > "
if /i "!openfolder!"=="y" explorer "%SCRIPT_DIR%"
pause
goto :menu

:: ==============================================
:: [9] 检查更新
:: 读取当前版本，查询 npmmirror 最新版，可选升级
:: ==============================================
:checkupdate
echo.
echo   === 检查更新 ===
echo.
cd /d "%APP_DIR%"

:: 获取当前版本
set "CUR_VER=unknown"
if exist "node_modules\openclaw\package.json" (
    for /f "tokens=2 delims=:" %%v in ('findstr /c:"\"version\"" "node_modules\openclaw\package.json"') do (
        set "CUR_VER=%%v"
        set "CUR_VER=!CUR_VER:~2,-2!"
    )
)
echo   当前版本: %CUR_VER%

echo   正在查询最新版本...
for /f "tokens=*" %%v in ('"%NODE_DIR%\node.exe" -e "const https=require('https');https.get('https://registry.npmmirror.com/openclaw/latest',r=>{let d='';r.on('data',c=>d+=c);r.on('end',()=>{try{console.log(JSON.parse(d).version)}catch(e){console.log('error')}})})" 2^>nul') do set "LATEST_VER=%%v"

if "!LATEST_VER!"=="" (
    echo   查询失败，请检查网络
    pause
    goto :menu
)
if "!LATEST_VER!"=="error" (
    echo   查询失败，请检查网络
    pause
    goto :menu
)

echo   最新版本: !LATEST_VER!
echo.

if "!CUR_VER!"=="!LATEST_VER!" (
    echo   已是最新版本
    pause
    goto :menu
)

set /p doupdate="  是否更新? (y/N): "
if /i not "!doupdate!"=="y" (
    echo   已取消
    pause
    goto :menu
)

echo.
echo   正在更新...
call npm install openclaw@latest --registry=https://registry.npmmirror.com
echo.
echo   更新完成
pause
goto :menu

:: ==============================================
:: [10] 磁盘清理
:: 显示各目录大小，清理旧备份、旧日志、npm 缓存
:: ==============================================
:diskcleanup
echo.
echo   === 磁盘清理 ===
echo.

:: 显示大小
echo   目录占用:
if exist "%APP_DIR%\node_modules" (
    for /f "tokens=*" %%s in ('powershell -command "(Get-ChildItem '%APP_DIR%\node_modules' -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB" 2^>nul') do echo     node_modules: %%s MB
)
if exist "%BACKUP_DIR%" (
    for /f "tokens=*" %%s in ('powershell -command "(Get-ChildItem '%BACKUP_DIR%' -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1KB" 2^>nul') do echo     backups:      %%s KB
)
if exist "%LOG_DIR%" (
    for /f "tokens=*" %%s in ('powershell -command "(Get-ChildItem '%LOG_DIR%' -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1KB" 2^>nul') do echo     logs:         %%s KB
)
echo.

:: 清理旧备份（保留最新 3 个）
set "BK_COUNT=0"
for /d %%d in ("%BACKUP_DIR%\*") do set /a BK_COUNT+=1
if !BK_COUNT! gtr 3 (
    set /a OLD_COUNT=BK_COUNT-3
    echo   发现 !BK_COUNT! 个备份，保留最新 3 个
    set /p delbk="  是否清理旧备份? (y/N): "
    if /i "!delbk!"=="y" (
        set "DEL_NUM=0"
        for /f "tokens=*" %%d in ('powershell -command "Get-ChildItem '%BACKUP_DIR%' -Directory | Sort-Object LastWriteTime | Select-Object -First !OLD_COUNT! | ForEach-Object { $_.FullName }"') do (
            rmdir /s /q "%%d" 2>nul
            set /a DEL_NUM+=1
        )
        echo   已清理 !DEL_NUM! 个旧备份
    )
) else (
    echo   备份: !BK_COUNT! 个（无需清理）
)

:: 清理旧日志（7 天前）
set "OLD_LOGS=0"
for /f "tokens=*" %%n in ('powershell -command "(Get-ChildItem '%LOG_DIR%' -Filter '*.log' -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }).Count" 2^>nul') do set OLD_LOGS=%%n
if !OLD_LOGS! gtr 0 (
    echo   发现 !OLD_LOGS! 个 7 天前的日志
    set /p dellog="  是否清理? (y/N): "
    if /i "!dellog!"=="y" (
        powershell -command "Get-ChildItem '%LOG_DIR%' -Filter '*.log' | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force" 2>nul
        echo   旧日志已清理
    )
) else (
    echo   日志: 无需清理
)

:: 清理 npm 缓存
echo.
set /p delcache="  是否清理 npm 缓存? (y/N): "
if /i "!delcache!"=="y" (
    call npm cache clean --force 2>nul
    echo   npm 缓存已清理
)

echo.
echo   清理完成
pause
goto :menu

:: ==============================================
:: [11] 插件管理
:: 列出、安装、移除 openclaw 插件
:: ==============================================
:plugins
echo.
echo   === 插件管理 ===
echo.
echo   [a] 列出已安装插件
echo   [b] 安装插件
echo   [c] 移除插件
echo.
set /p plgchoice="  选择 (a-c, 回车取消): "
cd /d "%APP_DIR%"

if "!plgchoice!"=="a" (
    echo.
    call npx openclaw plugins list 2>nul || echo   暂无法列出，请检查 openclaw 版本
)
if "!plgchoice!"=="b" (
    echo.
    echo   常用插件示例:
    echo     @icesword760/openclaw-wechat  (微信)
    echo.
    set /p plgname="  输入插件名 (回车取消): "
    if not "!plgname!"=="" (
        echo   正在安装 !plgname! ...
        call npx openclaw plugins install "!plgname!" 2>nul || call npm install "!plgname!" --save
        echo   完成
    )
)
if "!plgchoice!"=="c" (
    echo.
    set /p plgname="  输入要移除的插件名 (回车取消): "
    if not "!plgname!"=="" (
        echo   正在移除 !plgname! ...
        call npx openclaw plugins remove "!plgname!" 2>nul || call npm uninstall "!plgname!"
        echo   完成
    )
)
pause
goto :menu

:: ==============================================
:: [12] 清理缓存垃圾
:: 清理 npm 缓存、openclaw 运行时缓存、临时文件等
:: ==============================================
:clearcache
echo.
echo   === 清理缓存垃圾 ===
echo.
echo   即将清理以下缓存（不影响配置和记忆）:
echo     1. npm 全局缓存
echo     2. openclaw 插件运行时缓存 (plugin-runtime-deps)
echo     3. node_modules 构建缓存 (.cache)
echo     4. Windows 临时目录中的 npm 残留
echo     5. openclaw 日志缓存
echo.

set /p clearconfirm="  确认清理? (y/N): "
if /i not "!clearconfirm!"=="y" (
    echo   已取消
    pause
    goto :menu
)

echo.
set "CLEARED=0"

:: 1. 清理 npm 缓存
echo   [1/5] 清理 npm 缓存...
call npm cache clean --force >nul 2>&1
if !errorlevel!==0 (
    echo         [√] 完成
    set /a CLEARED+=1
) else (
    echo         [-] 无缓存或清理失败
)

:: 2. 清理 openclaw 插件运行时缓存
echo   [2/5] 清理插件运行时缓存...
if exist "%STATE_DIR%\plugin-runtime-deps" (
    rmdir /s /q "%STATE_DIR%\plugin-runtime-deps" 2>nul
    if not exist "%STATE_DIR%\plugin-runtime-deps" (
        echo         [√] 已删除 plugin-runtime-deps
        set /a CLEARED+=1
    ) else (
        echo         [-] 删除失败（可能正在使用）
    )
) else (
    echo         [-] 目录不存在
)

:: 3. 清理 node_modules 构建缓存
echo   [3/5] 清理 node_modules 构建缓存...
if exist "%APP_DIR%\node_modules\.cache" (
    rmdir /s /q "%APP_DIR%\node_modules\.cache" 2>nul
    if not exist "%APP_DIR%\node_modules\.cache" (
        echo         [√] 已删除 .cache
        set /a CLEARED+=1
    ) else (
        echo         [-] 删除失败
    )
) else (
    echo         [-] 目录不存在
)

:: 4. 清理 Windows 临时目录中的 npm 残留
echo   [4/5] 清理系统临时文件...
set "TEMP_CLEANED=0"
for /d %%d in ("%TEMP%\npm-*") do (
    rmdir /s /q "%%d" 2>nul
    if not exist "%%d" set /a TEMP_CLEANED+=1
)
if !TEMP_CLEANED! gtr 0 (
    echo         [√] 已清理 !TEMP_CLEANED! 个临时目录
    set /a CLEARED+=1
) else (
    echo         [-] 无残留临时文件
)

:: 5. 清理 openclaw 旧日志（保留最近 3 天）
echo   [5/5] 清理过期日志缓存...
set "OLD_LOGS=0"
for /f "tokens=*" %%n in ('powershell -command "(Get-ChildItem '%LOG_DIR%' -Filter '*.log' -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-3) }).Count" 2^>nul') do set OLD_LOGS=%%n
if !OLD_LOGS! gtr 0 (
    powershell -command "Get-ChildItem '%LOG_DIR%' -Filter '*.log' | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-3) } | Remove-Item -Force" 2>nul
    echo         [√] 已清理 !OLD_LOGS! 个过期日志
    set /a CLEARED+=1
) else (
    echo         [-] 无过期日志
)

echo.
echo ==============================================
if !CLEARED! gtr 0 (
    echo   清理完成！共完成 !CLEARED! 项清理
) else (
    echo   没有需要清理的缓存垃圾
)
echo ==============================================
pause
goto :menu