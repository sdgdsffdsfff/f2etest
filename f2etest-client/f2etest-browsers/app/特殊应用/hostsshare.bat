@echo off

rem ����������f2etest������
set f2etestDomain=f2etest.xxx.com
set appid=hostsshare

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
set proxy="HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" 
reg add %proxy% /v "ProxyEnable" /t REG_DWORD /d 0 /f>nul 
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v AutoConfigURL

rem ��Ӧ��
start "" "c:\hostsShare\hostsShare.exe" "http://%f2etestDomain%/" "%USERNAME%" %apiKey%

rem ���ͳ��
start "" curl "http://%f2etestDomain%/applog?userid=%USERNAME%&appid=%appid%&isweb=%isWeb%"