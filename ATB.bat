@echo off
REM 这里是设置版本号，编译日期的接口。
set version=1.0.0.10 DEV
set builddate=24/2/10
title ATB %version%
set "licenseFile=license_accepted.txt"
set "welcomePage=welcome_page.txt"

REM 检查许可文件是否存在
if /i exist %licenseFile% (
    REM 如果许可文件存在，则跳转到主页面
    call :mainPage
) else (
    REM 如果许可文件不存在，则跳转到欢迎页面
    call :welcomePage
)

goto :eof

:welcomePage
REM 显示欢迎页面并等待用户同意许可
echo 欢迎使用安卓工具箱！在开始使用本应用之前，请务必仔细阅读以下条款和条件。通过使用本应用，即表示您同意遵守以下协议。
echo.
echo **安卓工具箱使用协议**
echo.
echo 欢迎使用安卓工具箱！在开始使用本应用之前，请务必仔细阅读以下条款和条件。通过使用本应用，即表示您同意遵守以下协议。
echo.
echo **1. 服务概述**
echo.
echo 安卓工具箱是一款用于提供安卓设备管理和优化的应用程序。该应用提供了一系列实用工具，包括但不限于文件管理、设备信息查看、性能优化等功能。本软件完全开源，自由
echo.
echo **2. 用户许可**
echo.
echo 在遵守本协议的前提下，我们授予您个人、不可转让和非排他性的许可，以访问和使用安卓工具箱。本软件遵循GNU通用公共许可证（GNU General Public License，GPL）开源协议。根据该协议，您有权自由地使用、修改和分发本软件，前提是您也必须遵守GPL协议，并将您的修改和派生作品同样开源，并以GPL协议分发。
echo.
echo **3. 用户责任**
echo.
echo 您须对使用本应用程序所产生的任何行为负责。您不得利用本应用程序从事任何违法、侵权或损害他人权益的活动。
echo.
echo **4. 隐私政策**
echo.
echo 我们尊重用户的隐私权，并致力于保护用户的个人信息安全。我们完全不收集任何个人信息。
echo.
echo **5. 免责声明**
echo.
echo 本应用程序仅提供相关功能的工具，不对任何用户因使用本应用程序造成的损失负责。用户需自行承担使用本应用程序的风险。
echo.
echo **6. 修改和终止**
echo.
echo 我们保留随时修改、暂停或终止本协议的权利，恕不另行通知。修改后的协议将在我们的应用程序中公布，您应定期查阅并遵守最新版本的协议。
echo.
echo **7. 适用法律**
echo.
echo 本协议受中华人民共和国法律管辖，并应适用其法律原则。
echo.
echo 如果您不同意我们的用户许可，请您退出此软件。
echo 请阅读许可协议，若同意，请输入 "agree"。：
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

goto :eof

:mainPage
goto option_WTB

:option_WTB
cls
echo.
title Android Tool Box
echo 1.屏幕工具
echo 2.刷机工具
echo 3.对系统分区进行处理
echo X.工具箱设置
set /p wchoice="输入选项数字: "
if /i "%wchoice%"=="1" goto ScreenTool
if /i "%wchoice%"=="2" goto Rsetting
if /i "%wchoice%"=="3" goto processPartition
if /i "%wchoice%"=="4" goto option_WTB
if /i "%wchoice%"=="5" goto option_WTB
if /i "%wchoice%"=="6" goto option_WTB
if /i "%wchoice%"=="X" goto settings

    echo 无效的选项，请重新选择。
    goto option_WTB


:changeDpi
cls
set /p dpi="请输入新的 DPI 值: "
adb shell wm density %dpi%
echo 操作已成功完成
pause
goto option_WTB

:changeSize
cls
set /p width="请输入新的宽度: "
set /p height="请输入新的高度: "
adb shell wm size %width%x%height%
echo 操作已成功完成
pause
goto option_WTB

:installApk
cls
echo 当前目录下的 APK 文件列表：
dir /b *.apk

set /p apkName="请输入要安装的 APK 文件名（包括后缀）: "
if /i exist "%apkName%" goto insapk
:insapk
    adb install "%apkName%"
    echo 安装完成。
pause
goto option_WTB
    echo 文件 %apkName% 不存在。
pause
goto option_WTB

:processPartition
python tool.py
pause
goto option_WTB

:viewDeviceInfo
cls
adb devices
echo.
adb shell getprop ro.product.model
echo.
adb shell getprop ro.product.brand
echo.
adb shell getprop ro.build.version.release
echo.
adb shell getprop ro.build.version.sdk
echo.
adb shell getprop ro.product.manufacturer
echo.
adb shell getprop ro.product.device
echo.
adb shell getprop ro.build.version.security_patch
echo.
pause
goto option_WTB

:flashImage
cls
set /p imgFile="请输入要刷入的 img 文件名（包括后缀）: "

if /i exist "%imgFile%"  echo 文件 %imgFile% 存在，开始刷入...
    
    for %%i in ("%imgFile%") do set imgName=%%~ni
    
    if /i "%imgName%"=="boot" (
        set partition=boot
    )if /i "%imgName%"=="system" (
        set partition=system
    )if /i "%imgName%"=="recovery" (
        set partition=recovery
    )if /i "%imgName%"=="vendor" (
        set partition=vendor
    pause
goto option_WTB
        echo 无法识别的分区名称：%imgName%
        pause
        goto option_WTB
    

    fastboot flash %partition% %imgFile%
    echo 刷入完成。
pause
goto option_WTB
    echo 文件 %imgFile% 不存在。
pause
goto option_WTB

:settings
cls
echo 工具箱设置
echo 1. 查看版本
echo 2. 更改背景颜色
echo 3. 检查更新

set /p option="请输入选项数字 (1/2/3): "

if /i "%option%"=="1" goto opti1
:opti1
cls
    echo 版本：%version%
    echo 更新日期：%builddate%
    pause
    goto option_WTB
if /i "%option%"=="2" goto opti2
:opti2
    call :changeColor
    goto option_WTB
if /i "%option%"=="3" goto opti3
:opti3
    echo 正在检查更新...
    echo 该功能暂时未开放
    pause
    goto option_WTB
    echo 无效的选项，请重新选择。
    goto settings

goto :eof

:changeColor
cls
echo 请选择背景颜色：
echo 0: 黑色
echo 1: 蓝色
echo 2: 绿色
echo 3: 青色
echo 4: 红色
echo 5: 紫色
echo 6: 黄色
echo 7: 白色
set /p bgColor="输入背景颜色代码："

REM 设置背景颜色
color %bgColor%
echo 背景颜色已更改。
pause
goto option_WTB
:screentool
cls
echo 1. 更改 DPI
echo 2. 更改分辨率
echo 3. 更改刷新率（实验性）
set /p schoice="输入选项数字: "

if /i "%schoice%"=="1" goto changeDpi
if /i "%schoice%"=="2" goto changeSize
if /i "%schoice%"=="3" goto reducef
:reducef
    REM 设置要修改的刷新率
set /p refreshRate="请输入要更改的刷新率(纯数字)"

REM 使用 ADB 发送命令来修改屏幕刷新率
adb shell wm size reset
adb shell wm density reset
adb shell settings put system screen_off_timeout 60000
adb shell settings put system screen_brightness 0
adb shell dumpsys display | findstr "mRefreshRateRange"
adb shell wm size 1080x1920
adb shell wm density 480
adb shell am display-size 1080x1920
adb shell am display-density 480
adb shell settings put system screen_off_timeout 30000
adb shell settings put system screen_brightness 255

echo 屏幕刷新率已修改为 %refreshRate%Hz
pause
goto option_WTB
    echo 无效的选项，请重新选择。
pause
goto screentool
)
:Rsetting
cls
echo 1.刷入任意img
echo 2.查看系统信息
echo 3.安装任意.apk软件
set /p Rchoice="请输入(纯数字)"
if /i "%Rchoice%"=="1" goto flashimage
if /i "%Rchoice%"=="2" goto viewDeviceinfo
if /i "%Rchoice%"=="3" goto installAPK
echo 输入错误!
pause
goto Rsetting