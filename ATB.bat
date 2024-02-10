@echo off
set version=1.0.0.0 DEV
set builddate=24/2/10
title ATB %version%
set "licenseFile=license_accepted.txt"
set "welcomePage=welcome_page.txt"

REM 检查许可文件是否存在
if exist %licenseFile% (
    REM 如果许可文件存在，则跳转到主页面
    call :mainPage
) else (
    REM 如果许可文件不存在，则跳转到欢迎页面
    call :welcomePage
)


:welcomePage
REM 显示欢迎页面并等待用户同意许可
echo 欢迎来到欢迎页面！
echo 请阅读许可协议并输入 "agree" 同意：
set /p agree=
if /i "%agree%"=="agree" (
    REM 用户同意许可，生成许可文件并跳转到主页面
    echo 用户已同意许可协议。 > %licenseFile%
    call :mainPage
) else (
    REM 用户未同意许可，退出脚本
    echo 您未同意许可协议，即将退出。
    exit /b
)

:mainPage
REM 主页面的操作
echo 欢迎来到主页面！
:menu
echo 请选择需要的工具箱：
echo 1. 安卓工具箱
echo 2. Wear OS 工具箱
set /p choice="输入选项编号: "

if "%choice%"=="1" (
    goto option_ATB
) elseif "%choice%"=="2" (
    goto option_WTB
) else (
    echo 无效的选项，请重新选择。
    goto menu
)

:option_ATB
echo 执行选项 xxx 的操作
REM 在这里添加选项 xxx 的具体操作
pause
goto option_ATB

:option_WTB
echo 
title Wear Tool Box
echo 1.更改dpi
echo 2.更改分辨率
echo 3.安装任意.apk软件
echo 4.
set /p wchoice="输入选项数字"
if "%wchoice%"=="1" (
    goto changeDpi
) elseif "%wchoice%"=="2" (
    goto changeSize
) else (
    echo 无效的选项，请重新选择。
    goto menu
)
pause
goto option_WTB
REM 接口添加
:changeDpi
set /p dpi="请输入新的 DPI 值: "
adb shell wm density %dpi%
echo 更改已成功完成!
goto option_WTB
:changeSize