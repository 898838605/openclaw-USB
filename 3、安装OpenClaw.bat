@echo off
chcp 65001 >nul 2>&1
title OpenClaw 安装脚本
setlocal enabledelayedexpansion

:: ==============================================
:: 路径配置
:: ==============================================
set "SCRIPT_DIR=%~dp0"
set "NODE_PATH=%SCRIPT_DIR%openclaw-USB\node"
set "APP_PATH=%SCRIPT_DIR%openclaw-USB\openclaw"
set "DATA_DIR=%SCRIPT_DIR%openclaw-USB\data"
set "OPENCLAW_HOME=%DATA_DIR%"
set "OPENCLAW_STATE_DIR=%DATA_DIR%\sessions"

:: ==============================================
:: 步骤一：环境预检
:: ==============================================
if not exist "%NODE_PATH%\node.exe" (
    echo [错误] 未找到本地 Node.js: %NODE_PATH%\node.exe
    pause
    exit /b 1
)

if not exist "%APP_PATH%" (
    echo [错误] 未找到程序目录: %APP_PATH%
    pause
    exit /b 1
)

:: ==============================================
:: 步骤二：添加本地 Node.js 到 PATH
:: ==============================================
set "PATH=%NODE_PATH%;%PATH%"

node --version >nul 2>&1
if errorlevel 1 (
    echo [错误] node 命令无法执行
    pause
    exit /b 1
)

:: ==============================================
:: 步骤三：主菜单
:: ==============================================
echo.
echo ==============================================
echo  请选择操作模式（输入数字后回车）：
echo ==============================================
echo   1. 全新安装
echo ----------------------------
echo   2. 清除缓存后重新安装
echo ----------------------------
echo   3. 更新 openclaw
echo ----------------------------
echo   0. 退出脚本
echo ==============================================
echo.
set /p INSTALL_MODE="请输入选项 [0-3，默认 1]: "
if "!INSTALL_MODE!"=="" set "INSTALL_MODE=1"

if "!INSTALL_MODE!"=="0" (
    echo [提示] 已取消，按任意键退出...
    pause >nul
    exit /b 0
) else if "!INSTALL_MODE!"=="1" (
    echo [提示] 已选择：全新安装
) else if "!INSTALL_MODE!"=="2" (
    echo [提示] 已选择：清除缓存后重新安装
    call npm cache clean --force
    if errorlevel 1 (
        echo [警告] 缓存清除命令返回错误，但通常不影响继续安装
        pause
    )
) else if "!INSTALL_MODE!"=="3" (
    echo [提示] 已选择：更新 openclaw
    goto :update_openclaw
) else (
    echo [警告] 输入无效，默认使用：全新安装
    set "INSTALL_MODE=1"
)

:: ==============================================
:: 步骤四：选择镜像源
:: ==============================================
call :choose_registry

:: ==============================================
:: 步骤五：进入目录并安装
:: ==============================================
cd /d "%APP_PATH%" || (
    echo [错误] 无法进入目录: %APP_PATH%
    pause
    exit /b 1
)

echo 正在初始化项目...
call npm init -y
if errorlevel 1 (
    echo [错误] npm init 失败
    pause
    exit /b 1
)

echo.
echo 正在安装 openclaw，使用镜像：%REGISTRY%
call npm install openclaw@latest --registry=%REGISTRY%
if errorlevel 1 (
    echo [错误] openclaw 安装失败
    pause
    exit /b 1
)

goto :done

:: ==============================================
:: 【更新分支】
:: ==============================================
:update_openclaw
call :choose_registry

cd /d "%APP_PATH%" || (
    echo [错误] 无法进入目录: %APP_PATH%
    pause
    exit /b 1
)

if not exist "node_modules\openclaw" (
    echo [警告] 未检测到已安装的 openclaw，将执行全新安装...
    call npm init -y
    if errorlevel 1 (
        echo [错误] npm init 失败
        pause
        exit /b 1
    )
)

echo.
echo 正在更新 openclaw 到最新版本...
call npm install openclaw@latest --registry=%REGISTRY%
if errorlevel 1 (
    echo [错误] openclaw 更新失败
    pause
    exit /b 1
)

:: ==============================================
:: 安装/更新完成
:: ==============================================
:done
echo.
echo ==============================================
echo  操作完成！
echo ==============================================
echo.
echo 项目路径: %APP_PATH%
echo Node 版本:
node --version
echo.
pause
exit /b 0

:: ==============================================
:: 【子程序】选择镜像源
:: ==============================================
:choose_registry
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
goto :eof