<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
response.Buffer = true   
session.CodePage = 65001   
response.Charset = "utf-8"

' if session("indx")="" then
'   response.write "<script>location.href='../../'</script>"
'   response.end()
' end if  

' response.cookies("mylesson_id").Expires=now()
url="./2021/list.asp"

server.execute(url)
%>

