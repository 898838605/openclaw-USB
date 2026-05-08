@echo off
chcp 65001 >nul
title 修改U盘盘符工具
color 0A

:: 检测管理员权限
fltmc >nul 2>&1 || (
    echo 请【以管理员身份运行】此脚本！
    pause
    exit
)

:menu
cls
echo ============================================
echo        修改U盘盘符工具 (管理员权限)
echo ============================================
echo.
echo  [1] 查看当前所有磁盘和盘符
echo  [2] 列出U盘并修改盘符
echo  [3] 退出
echo.
echo ============================================
set "choice="
set /p choice=请输入选项 (1/2/3): 

if "%choice%"=="1" goto list_disk
if "%choice%"=="2" goto auto_usb
if "%choice%"=="3" goto end
goto menu

:list_disk
echo.
echo 正在列出所有磁盘信息...
echo.
(
    echo list disk
    echo list volume
) > "%temp%\diskpart_temp.txt"
diskpart /s "%temp%\diskpart_temp.txt"
del "%temp%\diskpart_temp.txt" 2>nul
echo.
pause
goto menu

:auto_usb
cls
echo ============================================
echo           列出所有磁盘卷
echo ============================================
echo 正在扫描，请稍候...
echo.

:: 输出所有卷信息
echo list volume > "%temp%\vol_list.txt"
diskpart /s "%temp%\vol_list.txt"
del "%temp%\vol_list.txt" 2>nul

echo.
echo ============================================
echo 提示：Type 为 Removable 可移动 就是U盘
echo ============================================
echo.

:: 输入原盘符，容错处理
set "old_letter="
set /p old_letter=请输入U盘现有盘符(只输字母，如 F): 
if not defined old_letter goto auto_usb
:: 截取第一个字符，去掉冒号
set "old_letter=%old_letter:~0,1%"

set "new_letter="
set /p new_letter=请输入新盘符字母(如 Z): 
if not defined new_letter goto auto_usb
set "new_letter=%new_letter:~0,1%"

echo.
echo 即将修改: %old_letter%:  →  %new_letter%:
echo 按任意键继续...
pause >nul

:: 生成diskpart指令（不带冒号，语法正确）
(
echo select volume %old_letter%
echo assign letter=%new_letter%
) > "%temp%\change.txt"

diskpart /s "%temp%\change.txt"
if %errorlevel% equ 0 (
    echo.
    echo ✅ 修改成功！已改为 %new_letter%:
) else (
    echo.
    echo ❌ 修改失败！
    echo 原因：新盘符已占用 / 不是可移动盘 / 权限不足
)

del "%temp%\change.txt" 2>nul
echo.
pause
goto menu

:end
exit