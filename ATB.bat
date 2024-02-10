@echo off
REM ���������ð汾�ţ��������ڵĽӿڡ�
set version=1.0.0.10 DEV
set builddate=24/2/10
title ATB %version%
set "licenseFile=license_accepted.txt"
set "welcomePage=welcome_page.txt"

REM �������ļ��Ƿ����
if /i exist %licenseFile% (
    REM �������ļ����ڣ�����ת����ҳ��
    call :mainPage
) else (
    REM �������ļ������ڣ�����ת����ӭҳ��
    call :welcomePage
)

goto :eof

:welcomePage
REM ��ʾ��ӭҳ�沢�ȴ��û�ͬ�����
echo ��ӭʹ�ð�׿�����䣡�ڿ�ʼʹ�ñ�Ӧ��֮ǰ���������ϸ�Ķ����������������ͨ��ʹ�ñ�Ӧ�ã�����ʾ��ͬ����������Э�顣
echo.
echo **��׿������ʹ��Э��**
echo.
echo ��ӭʹ�ð�׿�����䣡�ڿ�ʼʹ�ñ�Ӧ��֮ǰ���������ϸ�Ķ����������������ͨ��ʹ�ñ�Ӧ�ã�����ʾ��ͬ����������Э�顣
echo.
echo **1. �������**
echo.
echo ��׿��������һ�������ṩ��׿�豸������Ż���Ӧ�ó��򡣸�Ӧ���ṩ��һϵ��ʵ�ù��ߣ��������������ļ������豸��Ϣ�鿴�������Ż��ȹ��ܡ��������ȫ��Դ������
echo.
echo **2. �û����**
echo.
echo �����ر�Э���ǰ���£��������������ˡ�����ת�úͷ������Ե���ɣ��Է��ʺ�ʹ�ð�׿�����䡣�������ѭGNUͨ�ù������֤��GNU General Public License��GPL����ԴЭ�顣���ݸ�Э�飬����Ȩ���ɵ�ʹ�á��޸ĺͷַ��������ǰ������Ҳ��������GPLЭ�飬���������޸ĺ�������Ʒͬ����Դ������GPLЭ��ַ���
echo.
echo **3. �û�����**
echo.
echo �����ʹ�ñ�Ӧ�ó������������κ���Ϊ�������������ñ�Ӧ�ó�������κ�Υ������Ȩ��������Ȩ��Ļ��
echo.
echo **4. ��˽����**
echo.
echo ���������û�����˽Ȩ���������ڱ����û��ĸ�����Ϣ��ȫ��������ȫ���ռ��κθ�����Ϣ��
echo.
echo **5. ��������**
echo.
echo ��Ӧ�ó�����ṩ��ع��ܵĹ��ߣ������κ��û���ʹ�ñ�Ӧ�ó�����ɵ���ʧ�����û������ге�ʹ�ñ�Ӧ�ó���ķ��ա�
echo.
echo **6. �޸ĺ���ֹ**
echo.
echo ���Ǳ�����ʱ�޸ġ���ͣ����ֹ��Э���Ȩ����ˡ������֪ͨ���޸ĺ��Э�齫�����ǵ�Ӧ�ó����й�������Ӧ���ڲ��Ĳ��������°汾��Э�顣
echo.
echo **7. ���÷���**
echo.
echo ��Э�����л����񹲺͹����ɹ�Ͻ����Ӧ�����䷨��ԭ��
echo.
echo �������ͬ�����ǵ��û���ɣ������˳��������
echo ���Ķ����Э�飬��ͬ�⣬������ "agree"����
set /p agree=
if /i "%agree%"=="agree" (
    REM �û�ͬ����ɣ���������ļ�����ת����ҳ��
    echo �û���ͬ�����Э�顣 > %licenseFile%
    call :mainPage
) else (
    REM �û�δͬ����ɣ��˳��ű�
    echo ��δͬ�����Э�飬�����˳���
    exit /b
)

goto :eof

:mainPage
goto option_WTB

:option_WTB
cls
echo.
title Android Tool Box
echo 1.��Ļ����
echo 2.ˢ������
echo 3.��ϵͳ�������д���
echo X.����������
set /p wchoice="����ѡ������: "
if /i "%wchoice%"=="1" goto ScreenTool
if /i "%wchoice%"=="2" goto Rsetting
if /i "%wchoice%"=="3" goto processPartition
if /i "%wchoice%"=="4" goto option_WTB
if /i "%wchoice%"=="5" goto option_WTB
if /i "%wchoice%"=="6" goto option_WTB
if /i "%wchoice%"=="X" goto settings

    echo ��Ч��ѡ�������ѡ��
    goto option_WTB


:changeDpi
cls
set /p dpi="�������µ� DPI ֵ: "
adb shell wm density %dpi%
echo �����ѳɹ����
pause
goto option_WTB

:changeSize
cls
set /p width="�������µĿ��: "
set /p height="�������µĸ߶�: "
adb shell wm size %width%x%height%
echo �����ѳɹ����
pause
goto option_WTB

:installApk
cls
echo ��ǰĿ¼�µ� APK �ļ��б�
dir /b *.apk

set /p apkName="������Ҫ��װ�� APK �ļ�����������׺��: "
if /i exist "%apkName%" goto insapk
:insapk
    adb install "%apkName%"
    echo ��װ��ɡ�
pause
goto option_WTB
    echo �ļ� %apkName% �����ڡ�
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
set /p imgFile="������Ҫˢ��� img �ļ�����������׺��: "

if /i exist "%imgFile%"  echo �ļ� %imgFile% ���ڣ���ʼˢ��...
    
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
        echo �޷�ʶ��ķ������ƣ�%imgName%
        pause
        goto option_WTB
    

    fastboot flash %partition% %imgFile%
    echo ˢ����ɡ�
pause
goto option_WTB
    echo �ļ� %imgFile% �����ڡ�
pause
goto option_WTB

:settings
cls
echo ����������
echo 1. �鿴�汾
echo 2. ���ı�����ɫ
echo 3. ������

set /p option="������ѡ������ (1/2/3): "

if /i "%option%"=="1" goto opti1
:opti1
cls
    echo �汾��%version%
    echo �������ڣ�%builddate%
    pause
    goto option_WTB
if /i "%option%"=="2" goto opti2
:opti2
    call :changeColor
    goto option_WTB
if /i "%option%"=="3" goto opti3
:opti3
    echo ���ڼ�����...
    echo �ù�����ʱδ����
    pause
    goto option_WTB
    echo ��Ч��ѡ�������ѡ��
    goto settings

goto :eof

:changeColor
cls
echo ��ѡ�񱳾���ɫ��
echo 0: ��ɫ
echo 1: ��ɫ
echo 2: ��ɫ
echo 3: ��ɫ
echo 4: ��ɫ
echo 5: ��ɫ
echo 6: ��ɫ
echo 7: ��ɫ
set /p bgColor="���뱳����ɫ���룺"

REM ���ñ�����ɫ
color %bgColor%
echo ������ɫ�Ѹ��ġ�
pause
goto option_WTB
:screentool
cls
echo 1. ���� DPI
echo 2. ���ķֱ���
echo 3. ����ˢ���ʣ�ʵ���ԣ�
set /p schoice="����ѡ������: "

if /i "%schoice%"=="1" goto changeDpi
if /i "%schoice%"=="2" goto changeSize
if /i "%schoice%"=="3" goto reducef
:reducef
    REM ����Ҫ�޸ĵ�ˢ����
set /p refreshRate="������Ҫ���ĵ�ˢ����(������)"

REM ʹ�� ADB �����������޸���Ļˢ����
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

echo ��Ļˢ�������޸�Ϊ %refreshRate%Hz
pause
goto option_WTB
    echo ��Ч��ѡ�������ѡ��
pause
goto screentool
)
:Rsetting
cls
echo 1.ˢ������img
echo 2.�鿴ϵͳ��Ϣ
echo 3.��װ����.apk���
set /p Rchoice="������(������)"
if /i "%Rchoice%"=="1" goto flashimage
if /i "%Rchoice%"=="2" goto viewDeviceinfo
if /i "%Rchoice%"=="3" goto installAPK
echo �������!
pause
goto Rsetting