dim nodeCount
nodeCount = InputBox("������ڵ�������")
if nodeCount <> "" and IsNumeric(nodeCount) then
	nodeCount = CInt(nodeCount)
	if nodeCount <= 32 then
		for i = 1 to nodeCount
			setUserPassword "node"+iif(i<10,"0","")+CStr(i),"hello1234"
		next
		msgbox "��ʼ��������"
	else
		msgbox "�ڵ������벻Ҫ����32��"
	end if
	
else
	msgbox "�ڵ���������Ϊ������"
end if

function setUserPassword(username, password)
    On Error Resume Next
    dim oSystem,oUser,oGroup
    
    Set oSystem=GetObject("WinNT://127.0.0.1")
    
    Set oUser=oSystem.GetObject("user",username)

    if err <> 0 then
        err = 0
        ' �������û�
        Set oUser=oSystem.Create("user",username)
        oUser.SetPassword password
        oUser.Put "userFlags", &h10040 '������������
        oUser.Setinfo
        
        Set oGroup=oSystem.GetObject("Group","Administrators")
        oGroup.Add ("winnt://"&username)
    else
        ' �޸�����
        oUser.SetPassword password
        oUser.Setinfo
    end if
end function

function iif(expression,returntrue,returnfalse)
	if expression=0 then
		iif=returnfalse
	else
		iif=returntrue
	end if
end function