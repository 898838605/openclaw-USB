@echo off
chcp 936 >nul
title OpenClaw Gateway 启动器
setlocal EnableDelayedExpansion

:: ==============================================
:: 脚本说明
:: 启动 OpenClaw Gateway 服务
:: 启动前自动检测并结束残留的 Gateway 进程，避免端口冲突
:: ==============================================

:: ==============================================
:: 路径配置（%~dp0 = 脚本自身所在目录）
:: ==============================================
set "SCRIPT_DIR=%~dp0"
set "NODE_DIR=%SCRIPT_DIR%openclaw-USB\node"
set "APP_DIR=%SCRIPT_DIR%openclaw-USB\openclaw"
set "DATA_DIR=%SCRIPT_DIR%openclaw-USB\data"
set "STATE_DIR=%SCRIPT_DIR%openclaw-USB\data\.openclaw"
set "OPENCLAW_HOME=%DATA_DIR%"           
set "OPENCLAW_STATE_DIR=%STATE_DIR%"     

:: ==============================================
:: 预检：本地 Node.js 是否存在
:: ==============================================
if not exist "%NODE_DIR%\node.exe" (
    echo [错误] 找不到 Node.js: %NODE_DIR%\node.exe
    pause
    exit /b 1
)

:: ==============================================
:: 配置环境变量（仅当前窗口有效）
:: ==============================================
set "PATH=%NODE_DIR%;%PATH%"
set "NODE_PATH=%APP_DIR%\node_modules"
set "OPENCLAW_HOME=%DATA_DIR%"
set "OPENCLAW_STATE_DIR=%STATE_DIR%"

:: ==============================================
:: 进入项目目录
:: ==============================================
cd /d "%APP_DIR%" || (
    echo [错误] 无法进入目录: %APP_DIR%
    pause
    exit /b 1
)

:: ==============================================
:: 步骤一：检测并结束残留的 Gateway 进程
:: 原理：扫描 Gateway 常用端口范围（18789~18850）
::       找到处于 LISTENING 状态的进程 PID
::       用 taskkill 强制结束，避免端口占用导致启动失败
:: ==============================================
echo.
echo [检查] 正在扫描残留的 OpenClaw Gateway 进程...

set "FOUND=0"
for /l %%p in (18789,1,18850) do (
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%%p " ^| findstr "LISTENING"') do (
        set "FOUND=1"
        echo [发现] 端口 %%p 被 PID %%a 占用，正在结束...
        taskkill /PID %%a /F >nul 2>&1
        if !errorlevel!==0 (
            echo [成功] 已结束 PID %%a
        ) else (
            echo [警告] 无法结束 PID %%a，可能需要以管理员身份运行
        )
    )
)

if "!FOUND!"=="0" (
    echo [信息] 未发现残留的 Gateway 进程，准备启动...
) else (
    echo [信息] 残留进程清理完成，准备启动...
    timeout /t 1 /nobreak >nul
)

:: ==============================================
:: 步骤二：启动 OpenClaw Gateway
:: --verbose 显示详细日志，便于排查问题
:: ==============================================
echo.
echo [启动] 正在启动 OpenClaw Gateway...
echo   项目目录: %CD%
echo   状态目录: %STATE_DIR%
echo   按 Ctrl+C 可停止服务
echo.
echo ==============================================
echo.

call npx openclaw gateway --verbose

:: ==============================================
:: Gateway 退出后的处理
:: ==============================================
echo.
echo ==============================================
echo [退出] Gateway 已停止，返回码: %errorlevel%
echo ==============================================
pause
exit /b %errorlevel%