@echo off
chcp 65001 >nul
title Llama.cpp Vulkan API Server
setlocal EnableDelayedExpansion

:: ============================================
:: 配置路径
:: ============================================
set "EXE_DIR=Z:\llama-vulkan"
set "MODEL_DIR=Z:\models"
set "SERVER_EXE=%EXE_DIR%\llama-server.exe"

:: 检查程序是否存在
if not exist "%SERVER_EXE%" (
    echo [错误] 找不到 llama-server.exe
    echo 请确认路径: %SERVER_EXE%
    pause
    exit /b 1
)

:: ============================================
:: 1. 选择模型
:: ============================================
echo.
echo ========== 可用模型 ==========
echo 路径: %MODEL_DIR%
echo.

set "COUNT=0"
for %%F in ("%MODEL_DIR%\*.gguf") do (
    set /a COUNT+=1
    set "MODEL_!COUNT!=%%~nxF"
    echo  [!COUNT!] %%~nxF
)

if %COUNT%==0 (
    echo [错误] %MODEL_DIR% 下没有找到 .gguf 模型文件
    pause
    exit /b 1
)

echo.
set /p MODEL_IDX="请选择模型编号 [1-%COUNT%]: "

if not defined MODEL_%MODEL_IDX% (
    echo [错误] 无效的选择
    pause
    exit /b 1
)

for %%I in (%MODEL_IDX%) do set "MODEL_NAME=!MODEL_%%I!"
set "MODEL_PATH=%MODEL_DIR%\%MODEL_NAME%"

echo.
echo [已选择] %MODEL_NAME%
echo.

:: ============================================
:: 2. 输入参数（带默认值）
:: ============================================
set /p NGL="GPU 卸载层数 -ngl [0=纯CPU, 99=全部GPU, 默认99]: "
if "!NGL!"=="" set "NGL=99"

set /p CTX="上下文长度 -c [输入的最大字数，默认20000]: "
if "!CTX!"=="" set "CTX=20000"

set /p NTOKENS="生成最大 token 数 -n [输出最大字数，默认4096]: "
if "!NTOKENS!"=="" set "NTOKENS=4096"

set /p APIKEY="API 密钥 --api-key [留空则不启用]: "

:: ============================================
:: 3. 构建命令
:: ============================================
set "CMD="%SERVER_EXE%" -m "%MODEL_PATH%" -c %CTX% -n %NTOKENS% -ngl %NGL% --verbose"

if not "!APIKEY!"=="" (
    set "CMD=!CMD! --api-key !APIKEY!"
)

:: 固定参数
set "CMD=!CMD! --host 0.0.0.0 --port 8080"

:: ============================================
:: 4. 显示并执行
:: ============================================
echo.
echo ============================================
echo  启动命令:
echo  !CMD!
echo ============================================
echo.
echo 服务启动后访问:
echo   Web UI:   http://localhost:8080
echo   API 地址: http://localhost:8080/v1/
echo.
echo 按任意键启动服务...
pause >nul

cd /d "%EXE_DIR%"
!CMD!

echo.
echo 服务已停止
pause