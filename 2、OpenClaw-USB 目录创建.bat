@echo off
:: 关闭命令行默认显示，让界面更干净
chcp 65001 >nul
:: 解决中文乱码问题
title OpenClaw-USB 目录创建工具

:: ==============================
:: 开始创建目录（严格按你需要的结构）
:: ==============================

:: 1. 创建主文件夹 openclaw-USB
mkdir openclaw-USB 2>nul

:: 2. 在主文件夹内创建 3 个一级子文件夹
mkdir openclaw-USB\node 2>nul
mkdir openclaw-USB\openclaw 2>nul
mkdir openclaw-USB\data 2>nul

:: 3. 在 data 文件夹内创建 4 个二级子文件夹
mkdir openclaw-USB\data\.openclaw 2>nul
mkdir openclaw-USB\data\memory 2>nul
mkdir openclaw-USB\data\workspace 2>nul
mkdir openclaw-USB\data\sessions 2>nul

:: ==============================
:: 创建完成提示
:: ==============================
echo.
echo ✅ 目录已成功创建！结构如下：
echo.
echo openclaw-USB/
echo ├─ node/
echo ├─ openclaw/
echo └─ data/
echo    ├─ .openclaw/
echo    ├─ memory/
echo    ├─ workspace/
echo    └─ sessions/
echo 按回车退出
echo.
pause >nul