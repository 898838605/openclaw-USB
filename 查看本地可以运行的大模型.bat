@echo off
chcp 65001 >nul
title 大模型运行环境检测工具

:: 检测管理员权限
fltmc >nul 2>&1 || (
    echo 请【以管理员身份运行】此脚本！
    pause
    exit
)

:: 清屏 + 显示菜单
cls
echo ==============================================
echo           本地大模型运行检测工具
echo ==============================================
echo 1 - 打开在线大模型检测网页 (canirun.ai)
echo 2 - 运行本地检测工具并自动跳转模型页面
echo ==============================================
echo.

:: 让用户输入选择
set /p "choice=请输入数字 1 或 2 并按回车："

:: 判断选项
if "%choice%"=="1" (
    echo 正在打开在线检测网页...
    start https://www.canirun.ai/
    goto end
)

if "%choice%"=="2" (
    echo 正在启动本地检测工具：查看你的电脑能跑那个模型.exe
    echo.
    start "" "查看你的电脑能跑那个模型.exe"
    
    echo 等待工具启动中，请稍候...
    timeout /t 20 /nobreak >nul
    
    echo 正在打开模型运行页面 127.0.0.1:8787...
    start http://127.0.0.1:8787
    goto end
)

:: 无效输入提示
echo 输入无效，请输入 1 或 2！
pause >nul
goto end

:end
exit