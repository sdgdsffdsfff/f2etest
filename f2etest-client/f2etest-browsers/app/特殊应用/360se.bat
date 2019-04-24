@echo off

rem ����������f2etest������
set f2etestDomain=f2etest.xxx.com
set appid=360se

rem �����в���
set proxymode="%1"
set proxyurl=%2
set url=%3
set apiKey=%4

rem ̽������ģʽ
set isWeb=1
if %url% equ desktop (
	set url="about:blank"
	set isWeb=0
)

rem ���ô���
set proxypath="HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
reg add %proxypath% /v "ProxyEnable" /t REG_DWORD /d 0 /f>nul 
set proxydef=
if %proxyurl% equ "" set proxydef=1
if %proxyurl% equ default set proxydef=1
if %proxyurl% equ "default" set proxydef=1
if defined proxydef set proxyurl="http://%f2etestDomain%/getHosts.pac?name=%USERNAME%"
if %proxymode% equ "noproxy" (
	set proxyurl=""
)
if %proxyurl% neq "" (
	rem ��������
	reg add %proxypath% /v "AutoConfigURL" /d %proxyurl% /f >nul
) else (
	rem �رմ���
	reg delete %proxypath% /v "AutoConfigURL" /f > nul
)

rem ��Ӧ��
start /MAX "" "C:\360\360se6\Application\360se.exe" --allow-no-sandbox-job %url% --user-data-dir="%APPDATA%\360se6\User Data"

rem ���ͳ��
start "" curl "http://%f2etestDomain%/applog?userid=%USERNAME%&appid=%appid%&isweb=%isWeb%"
