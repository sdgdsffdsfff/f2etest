@echo off

rem ����������f2etest������
set f2etestDomain=f2etest.xxx.com
set appid=desktop

rem �����в���
set proxymode="%1"
set proxyurl=%2
set url=%3
set apiKey=%4

rem ̽������ģʽ
set isWeb=0
if exist "\\tsclient\G\Download" (
	set isWeb=1
)

rem ��������
set proxypath="HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
reg add %proxypath% /v "ProxyEnable" /t REG_DWORD /d 0 /f>nul 
set proxyurl="http://%f2etestDomain%/getHosts.pac?name=%USERNAME%"
reg add %proxypath% /v "AutoConfigURL" /d %proxyurl% /f >nul

rem ��Ӧ��
start /MAX microsoft-edge:%url%

rem ���ͳ��
start "" curl "http://%f2etestDomain%/applog?userid=%USERNAME%&appid=%appid%&isweb=%isWeb%"
