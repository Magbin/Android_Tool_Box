@echo off
set version=1.0.0.0 DEV
set builddate=24/2/10
title ATB %version%
set "licenseFile=license_accepted.txt"
set "welcomePage=welcome_page.txt"

REM �������ļ��Ƿ����
if exist %licenseFile% (
    REM �������ļ����ڣ�����ת����ҳ��
    call :mainPage
) else (
    REM �������ļ������ڣ�����ת����ӭҳ��
    call :welcomePage
)


:welcomePage
REM ��ʾ��ӭҳ�沢�ȴ��û�ͬ�����
echo ��ӭ������ӭҳ�棡
echo ���Ķ����Э�鲢���� "agree" ͬ�⣺
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

:mainPage
REM ��ҳ��Ĳ���
echo ��ӭ������ҳ�棡
:menu
echo ��ѡ����Ҫ�Ĺ����䣺
echo 1. ��׿������
echo 2. Wear OS ������
set /p choice="����ѡ����: "

if "%choice%"=="1" (
    goto option_ATB
) elseif "%choice%"=="2" (
    goto option_WTB
) else (
    echo ��Ч��ѡ�������ѡ��
    goto menu
)

:option_ATB
echo ִ��ѡ�� xxx �Ĳ���
REM ���������ѡ�� xxx �ľ������
pause
goto option_ATB

:option_WTB
echo 
title Wear Tool Box
echo 1.����dpi
echo 2.���ķֱ���
echo 3.��װ����.apk���
echo 4.
set /p wchoice="����ѡ������"
if "%wchoice%"=="1" (
    goto changeDpi
) elseif "%wchoice%"=="2" (
    goto changeSize
) else (
    echo ��Ч��ѡ�������ѡ��
    goto menu
)
pause
goto option_WTB
REM �ӿ����
:changeDpi
set /p dpi="�������µ� DPI ֵ: "
adb shell wm density %dpi%
echo �����ѳɹ����!
goto option_WTB
:changeSize