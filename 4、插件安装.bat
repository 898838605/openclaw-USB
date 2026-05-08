@echo off
chcp 936 >nul
title OpenClaw-USB 插件终端

:: ==============================================
:: 脚本说明
:: 打开一个已配置好本地 Node 环境的终端窗口
:: 可直接输入 openclaw 命令（如 openclaw -v、openclaw --help）
:: 也可自由执行 npm install、npx 等命令
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
    echo 请确认 openclaw-USB\node 目录存在
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
:: npx 需要在项目目录下运行，才能找到本地安装的 openclaw
:: ==============================================
cd /d "%APP_DIR%" || (
    echo [错误] 无法进入目录: %APP_DIR%
    pause
    exit /b 1
)

:: ==============================================
:: 创建 openclaw 命令快捷方式
:: 原理：在临时目录生成一个 openclaw.cmd 包装器
::       把它加到 PATH 最前面，这样直接输入 openclaw 就能调用
::       包装器内部会自动切到项目目录并执行 npx openclaw
:: ==============================================
set "CLI_DIR=%TEMP%\openclaw_cli_%RANDOM%"
mkdir "%CLI_DIR%" 2>nul
(
echo @echo off
echo cd /d "%APP_DIR%"
echo npx openclaw %%*
) > "%CLI_DIR%\openclaw.cmd"

:: 将临时目录插入 PATH 最前端，优先级最高
set "PATH=%CLI_DIR%;%PATH%"

:: ==============================================
:: 显示环境信息
:: ==============================================
cls
echo.
echo   ==============================================
echo     OpenClaw-USB 插件终端
echo   ==============================================
echo.
echo   当前目录: %CD%
echo   Node 版本:
node --version
echo.
echo   openclaw 命令已就绪，可直接输入：
echo     openclaw -v              查看版本
echo     openclaw --help          查看帮助
echo     openclaw onboard         运行设置向导
echo     openclaw doctor          诊断修复
echo     openclaw plugins list    列出插件
echo     openclaw plugins install 插件名   安装插件
echo     openclaw plugins remove  插件名   移除插件
echo.
echo   其他常用命令：
echo     npm install 包名         安装 npm 包
echo     npm uninstall 包名       卸载 npm 包
echo     npm list                 查看已装包
echo     npm cache clean --force  清理缓存
echo     exit                     关闭终端
echo   ==============================================
echo.

:: ==============================================
:: 启动交互式终端
:: /k 参数保持窗口不关闭，等待用户手动输入 exit
:: ==============================================
cmd /k

:: ==============================================
:: 用户输入 exit 退出后，自动清理临时命令文件
:: ==============================================
rmdir /s /q "%CLI_DIR%" 2>nul
exit /b 0