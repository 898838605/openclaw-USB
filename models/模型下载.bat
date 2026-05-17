@echo off
chcp 936 >nul
title AI模型跳转工具
color 0A

:main
cls
echo ==========================================
echo         AI模型平台一键跳转
echo ==========================================
echo 1 HuggingFace官网
echo 2 HF国内镜像站
echo 3 阿里魔搭ModelScope
echo 4 Gitee AI模型社区
echo 5 始智AI WiseModel
echo 6 OpenCSG模型平台
echo 7 AIbase模型库
echo 8 华为云AI广场
echo 0 退出程序
echo ==========================================
set /p cho=请输入数字:

if %cho%==1 start https://huggingface.co/models
if %cho%==2 start https://hf-mirror.com/models
if %cho%==3 start https://modelscope.cn/models
if %cho%==4 start https://ai.gitee.com/models
if %cho%==5 start https://wisemodel.cn
if %cho%==6 start https://www.opencsg.com
if %cho%==7 start https://model.aibase.cn/models
if %cho%==8 start https://developer.huaweicloud.com/modelgallery
if %cho%==0 exit

echo 已打开网页，回车返回
pause>nul
goto main