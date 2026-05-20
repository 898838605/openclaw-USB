@echo off
:: 关闭命令行默认显示，让界面更干净
chcp 65001 >nul 2>&1
:: 解决中文乱码问题
title OpenClaw-USB 目录创建工具

:: 检测管理员权限
fltmc >nul 2>&1 || (
    echo 请【以管理员身份运行】此脚本！
    pause
    exit
)
:: 标记是否创建了任何新目录
set "created="

:: ==============================
:: 开始创建目录（严格按你需要的结构）
:: ==============================

:: 1. 创建主文件夹 openclaw-USB
if not exist "openclaw-USB" (
    mkdir openclaw-USB 2>nul
    set "created=yes"
)

:: 2. 在主文件夹内创建 3 个一级子文件夹
if not exist "openclaw-USB\node" (
    mkdir openclaw-USB\node 2>nul
    set "created=yes"
)
if not exist "openclaw-USB\openclaw" (
    mkdir openclaw-USB\openclaw 2>nul
    set "created=yes"
)
if not exist "openclaw-USB\data" (
    mkdir openclaw-USB\data 2>nul
    set "created=yes"
)

:: 3. 在 data 文件夹内创建 4 个二级子文件夹
if not exist "openclaw-USB\data\.openclaw" (
    mkdir openclaw-USB\data\.openclaw 2>nul
    set "created=yes"
)
if not exist "openclaw-USB\data\memory" (
    mkdir openclaw-USB\data\memory 2>nul
    set "created=yes"
)
if not exist "openclaw-USB\data\workspace" (
    mkdir openclaw-USB\data\workspace 2>nul
    set "created=yes"
)
if not exist "openclaw-USB\data\sessions" (
    mkdir openclaw-USB\data\sessions 2>nul
    set "created=yes"
)

:: ==============================
:: 创建完成提示
:: ==============================
echo.
if defined created (
    echo ✅ 已创建完整目录！结构如下：
) else (
    echo 📁 目录已存在，无需再创建。
)
echo.
echo openclaw-USB/
echo ├─ node/
echo ├─ openclaw/
echo └─ data/
echo    ├─ .openclaw/
echo    ├─ memory/
echo    ├─ workspace/
echo    └─ sessions/
echo.
echo 按回车退出
echo.
pause >nul