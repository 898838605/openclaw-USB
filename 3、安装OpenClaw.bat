@echo off
chcp 936 >nul
title OpenClaw 安装脚本
setlocal enabledelayedexpansion

:: ==============================================
:: 脚本说明
:: 本脚本用于在本地 Node.js 环境下安装/更新 openclaw
:: 不修改系统环境变量，仅临时修改当前会话的 PATH
:: ==============================================

:: ==============================================
:: 【核心修正】%~dp0 与 %CD% 的区别
:: %CD%    = 当前工作目录（你打开 cmd 时所在的目录）
:: %~dp0   = 脚本自身所在的目录（含末尾反斜杠）
:: 如果你从其他目录运行此脚本，%CD% 会指向错误位置
:: 因此必须使用 %~dp0 才能保证路径正确
:: ==============================================
set "SCRIPT_DIR=%~dp0"

:: ==============================================
:: 本地 Node.js 路径配置
:: 脚本假设目录结构如下：
::   脚本.bat
::   └── openclaw-USB\
::       ├── node\          <-- 本地 Node.js
::       │   └── node.exe
::       └── openclaw\      <-- 项目目录
:: ==============================================
set "NODE_PATH=%SCRIPT_DIR%openclaw-USB\node"
set "APP_PATH=%SCRIPT_DIR%openclaw-USB\openclaw"
set "DATA_DIR=%SCRIPT_DIR%openclaw-USB\data"
set "OPENCLAW_HOME=%DATA_DIR%"          
set "OPENCLAW_STATE_DIR=%STATE_DIR%"     

:: ==============================================
:: 步骤一：环境预检
:: 检查本地 Node.js 是否存在，避免后续命令报错
:: ==============================================
if not exist "%NODE_PATH%\node.exe" (
    echo [错误] 未找到本地 Node.js: %NODE_PATH%\node.exe
    echo 请确认目录结构正确：
    echo   %SCRIPT_DIR%openclaw-USB\node\node.exe
    pause
    exit /b 1
)

:: 检查项目目录是否存在
if not exist "%APP_PATH%" (
    echo [错误] 未找到程序目录: %APP_PATH%
    echo 请确认目录结构正确：
    echo   %SCRIPT_DIR%openclaw-USB\openclaw\
    pause
    exit /b 1
)

:: ==============================================
:: 步骤二：添加本地 Node.js 到 PATH（仅当前会话）
:: 注意：set 命令不加 /m 参数，不会写入注册表
:: 关闭 cmd 窗口后自动失效，安全无副作用
:: ==============================================
set "PATH=%NODE_PATH%;%PATH%"

:: 验证 node 是否可用
node --version >nul 2>&1
if errorlevel 1 (
    echo [错误] node 命令无法执行，PATH 配置可能有问题
    pause
    exit /b 1
)

:: ==============================================
:: 步骤三：主菜单 — 选择操作模式
:: ==============================================
echo.
echo ==============================================
echo  请选择操作模式（输入数字后回车）：
echo ==============================================
echo   1. 全新安装
echo      （首次安装或正常重装，不清理缓存）
echo.
echo   2. 清除缓存后重新安装
echo      （推荐：之前安装报错退出时使用）
echo      将执行：npm cache clean --force
echo      然后重新执行 npm init + npm install
echo.
echo   3. 更新 openclaw
echo      （已安装过，升级到最新版本）
echo      将执行：npm install openclaw@latest
echo.
echo   0. 退出脚本
echo ==============================================
echo.
set /p INSTALL_MODE="请输入选项 [0-3，默认 1]: "

:: 如果用户直接回车，默认全新安装
if "!INSTALL_MODE!"=="" set "INSTALL_MODE=1"

:: ==============================================
:: 处理用户选择
:: ==============================================
if "!INSTALL_MODE!"=="0" (
    echo [提示] 已取消，按任意键退出...
    pause >nul
    exit /b 0
) else if "!INSTALL_MODE!"=="1" (
    echo [提示] 已选择：全新安装
) else if "!INSTALL_MODE!"=="2" (
    echo [提示] 已选择：清除缓存后重新安装
    echo.
    echo ==============================================
    echo  正在强制清除 npm 缓存...
    echo  这会删除本地 npm 缓存目录中的所有数据
    echo  不会影响已安装的全局包，仅清除下载缓存
    echo ==============================================
    echo.
    call npm cache clean --force
    if errorlevel 1 (
        echo [警告] 缓存清除命令返回错误，但通常不影响继续安装
        echo 如果后续仍报错，请手动删除缓存目录后重试
        echo.
        pause
    ) else (
        echo [成功] npm 缓存已清除
        echo.
    )
) else if "!INSTALL_MODE!"=="3" (
    echo [提示] 已选择：更新 openclaw
    goto :update_openclaw
) else (
    echo [警告] 输入无效，默认使用：全新安装
    set "INSTALL_MODE=1"
)

:: ==============================================
:: 步骤四：让用户选择 npm 镜像源
:: 国内网络建议选 1~4，海外或网络良好可选 0
:: ==============================================
echo.
echo ==============================================
echo  请选择 npm 镜像源（输入数字后回车）：
echo ==============================================
echo   0. 官方源     https://registry.npmjs.org/
echo   1. 阿里云     https://registry.npmmirror.com
echo   2. 腾讯云     https://mirrors.cloud.tencent.com/npm/
echo   3. 华为云     https://repo.huaweicloud.com/repository/npm/
echo   4. 中科大     https://mirrors.ustc.edu.cn/npm/
echo   5. 清华大学   https://mirrors.tuna.tsinghua.edu.cn/npm/
echo ==============================================
echo.
set /p CHOICE="请输入选项 [0-5，默认 1]: "

:: 如果用户直接回车，默认使用阿里云
if "!CHOICE!"=="" set "CHOICE=1"

:: 根据选择设置 registry 地址
if "!CHOICE!"=="0" (
    set "REGISTRY=https://registry.npmjs.org/"
    echo [提示] 已选择：官方源（海外，速度可能较慢）
) else if "!CHOICE!"=="1" (
    set "REGISTRY=https://registry.npmmirror.com"
    echo [提示] 已选择：阿里云镜像（推荐，国内速度快）
) else if "!CHOICE!"=="2" (
    set "REGISTRY=https://mirrors.cloud.tencent.com/npm/"
    echo [提示] 已选择：腾讯云镜像
) else if "!CHOICE!"=="3" (
    set "REGISTRY=https://repo.huaweicloud.com/repository/npm/"
    echo [提示] 已选择：华为云镜像
) else if "!CHOICE!"=="4" (
    set "REGISTRY=https://mirrors.ustc.edu.cn/npm/"
    echo [提示] 已选择：中科大镜像
) else if "!CHOICE!"=="5" (
    set "REGISTRY=https://mirrors.tuna.tsinghua.edu.cn/npm/"
    echo [提示] 已选择：清华大学镜像
) else (
    echo [警告] 输入无效，使用默认阿里云镜像
    set "REGISTRY=https://registry.npmmirror.com"
)
echo.

:: ==============================================
:: 步骤五：进入项目目录
:: cd /d 支持跨盘符切换（如从 C: 切到 D:）
:: || 表示前一条命令失败时执行后面的代码块
:: ==============================================
cd /d "%APP_PATH%" || (
    echo [错误] 无法进入目录: %APP_PATH%
    pause
    exit /b 1
)

:: ==============================================
:: 步骤六：初始化 npm 项目
:: npm init -y 生成默认的 package.json
:: call 用于在批处理中调用另一个命令，确保 errorlevel 正确返回
:: ==============================================
echo 正在初始化项目...
call npm init -y
if errorlevel 1 (
    echo [错误] npm init 失败，请检查 node 环境
    pause
    exit /b 1
)

:: ==============================================
:: 步骤七：安装 openclaw
:: --registry 指定本次安装的镜像源
:: --verbose  显示详细日志，便于排查问题
:: ==============================================
echo.
echo 正在安装 openclaw，使用镜像：%REGISTRY%
echo 这可能需要几分钟，请耐心等待...
echo.
call npm install openclaw@latest --registry=%REGISTRY% --verbose
if errorlevel 1 (
    echo.
    echo [错误] openclaw 安装失败
    echo.
    echo 可能原因及解决方案：
    echo   1. 网络连接问题
    echo      → 尝试更换其他镜像源重新运行脚本
    echo   2. npm 缓存损坏
    echo      → 重新运行脚本，选择【清除缓存后重新安装】
    echo   3. 该包名在 npm 上不存在或已更名
    echo      → 请确认包名 "openclaw" 是否正确
    echo   4. 本地 Node.js 版本不兼容
    echo      → 请检查 node 版本是否满足要求
    echo.
    pause
    exit /b 1
)

:: ==============================================
:: 安装完成
:: ==============================================
echo.
echo ==============================================
echo  安装完成！
echo ==============================================
echo.
echo 项目路径: %APP_PATH%
echo Node 版本:
node --version
echo.
pause
exit /b 0

:: ==============================================
:: 【更新分支】选项 3：更新 openclaw
:: 跳过 npm init，直接进入项目目录执行更新
:: ==============================================
:update_openclaw
echo.
echo ==============================================
echo  请选择 npm 镜像源（输入数字后回车）：
echo ==============================================
echo   0. 官方源     https://registry.npmjs.org/
echo   1. 阿里云     https://registry.npmmirror.com
echo   2. 腾讯云     https://mirrors.cloud.tencent.com/npm/
echo   3. 华为云     https://repo.huaweicloud.com/repository/npm/
echo   4. 中科大     https://mirrors.ustc.edu.cn/npm/
echo   5. 清华大学   https://mirrors.tuna.tsinghua.edu.cn/npm/
echo ==============================================
echo.
set /p CHOICE="请输入选项 [0-5，默认 1]: "

if "!CHOICE!"=="" set "CHOICE=1"

if "!CHOICE!"=="0" (
    set "REGISTRY=https://registry.npmjs.org/"
    echo [提示] 已选择：官方源
) else if "!CHOICE!"=="1" (
    set "REGISTRY=https://registry.npmmirror.com"
    echo [提示] 已选择：阿里云镜像
) else if "!CHOICE!"=="2" (
    set "REGISTRY=https://mirrors.cloud.tencent.com/npm/"
    echo [提示] 已选择：腾讯云镜像
) else if "!CHOICE!"=="3" (
    set "REGISTRY=https://repo.huaweicloud.com/repository/npm/"
    echo [提示] 已选择：华为云镜像
) else if "!CHOICE!"=="4" (
    set "REGISTRY=https://mirrors.ustc.edu.cn/npm/"
    echo [提示] 已选择：中科大镜像
) else if "!CHOICE!"=="5" (
    set "REGISTRY=https://mirrors.tuna.tsinghua.edu.cn/npm/"
    echo [提示] 已选择：清华大学镜像
) else (
    echo [警告] 输入无效，使用默认阿里云镜像
    set "REGISTRY=https://registry.npmmirror.com"
)
echo.

:: 进入项目目录
cd /d "%APP_PATH%" || (
    echo [错误] 无法进入目录: %APP_PATH%
    pause
    exit /b 1
)

:: 检查是否已安装
if not exist "node_modules\openclaw" (
    echo [警告] 未检测到已安装的 openclaw
    echo 将执行全新安装...
    call npm init -y
)

:: 执行更新
echo.
echo 正在更新 openclaw 到最新版本...
echo 使用镜像：%REGISTRY%
echo.
call npm install openclaw@latest --registry=%REGISTRY% --verbose
if errorlevel 1 (
    echo.
    echo [错误] openclaw 更新失败
    echo 可能原因：网络问题、镜像源不可用、或 npm 缓存损坏
    echo 建议：尝试选择【清除缓存后重新安装】模式
    pause
    exit /b 1
)

echo.
echo ==============================================
echo  更新完成！
echo ==============================================
echo.
echo 项目路径: %APP_PATH%
echo Node 版本:
node --version
echo.
pause
exit /b 0