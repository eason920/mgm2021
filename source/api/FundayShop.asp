<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>   
<!-- #include virtual="include/DBConnection.asp"--> 
<!--#include virtual="include/aspJSON1.17.asp"-->
<!--#include virtual="myLesson/2020/function.asp"-->
<%
   response.Buffer = true
   session.Codepage =65001
   response.Charset = "utf-8"  


   Response.CacheControl = "cache"
   Response.AddHeader "Pragma", "cache"
   Response.charset = "UTF-8"
   response.contentType = "application/json" 

   function classType(id)
      select Case id
         case 1
            classType="Learning"
         case 2
            classType="Life"
         case 3
            classType="Cash"
      end select
   end function

   mindx=session("indx")
   FunCoin=0

   if mindx<>"" then
      sql="select * from exchange.dbo.MGM_Code where member_id="&mindx&" and ready=1"
      set rs2 = connection2.execute(sql)
      if not rs2.eof then
         Mgm_code=rs2("code")
      end if


      sql="select sum(coin) as c from exchange.dbo.member_coins  where member_id ="&mindx&" and state=1"
      set rs2 = connection2.execute(sql)
      if not rs2.eof then
         FunCoin=rs2("c")
      end if
     
   end if

   Str="{"
   Str=Str&Chr("34")&"Member_id"&Chr("34")&":"&Chr("34")&mindx&Chr("34")&","
   Str=Str&Chr("34")&"Mgm_code"&Chr("34")&":"&Chr("34")&Mgm_code&Chr("34")&","
   Str=Str&Chr("34")&"FunCoin"&Chr("34")&":"&Chr("34")&FunCoin&Chr("34")&","

   Str=Str&Chr("34")&"FadeShow"&Chr("34")&": ["
   Str=Str&"{"&Chr("34")&"pic"&Chr("34")&": {"
   Str=Str&Chr("34")&"pc"&Chr("34")&":"&Chr("34")&"https://funday.asia/fundayshop/2021/images/history/hero_pc.jpg"&Chr("34")&","&Chr("34")&"mb"&Chr("34")&":"&Chr("34")&"https://funday.asia/fundayshop/2021/images/history/hero_mb.jpg"&Chr("34")&"},"&Chr("34")&"subject"&Chr("34")&":"&Chr("34")&"世界再遠，夢想再大，我！都裝得下！"&Chr("34")&","&Chr("34")&"button"&Chr("34")&":"&Chr("34")&"每月主題"&Chr("34")&","&Chr("34")&"href"&Chr("34")&":"&Chr("34")&"history.asp"&Chr("34")&"}"
   Str=Str&"],"

   sql="select * from exchange.dbo.MGM_Item_List  where ready=1 order by class,type"
   rs.open sql,connection2,1,3

   class_temp=""
   While not rs.eof
      if class_temp<>rs("class") then
         Str=Str&Chr("34")&classType(rs("class"))&Chr("34")&":["
      end if

      Str=Str&"{"
      Str=Str&Chr("34")&"id"&Chr("34")&":"&Chr("34")&rs("indx")&Chr("34")&","
      Str=Str&Chr("34")&"title"&Chr("34")&":"&Chr("34")&rs("item")&Chr("34")&","
      Str=Str&Chr("34")&"type"&Chr("34")&":"&Chr("34")&rs("type")&Chr("34")&","
      Str=Str&Chr("34")&"description"&Chr("34")&":"&"["

      description="商品描述 : "&vbcrlf&rs("description")
      description=split(description,vbcrlf)
      if ubound(description)>0 then
         for each x in description
            Str=Str&Chr("34")&x&Chr("34")&","
         next
         Str=left(Str,len(Str)-1)   
      else
         Str=Str&Chr("34")&rs("description")&Chr("34")
      end if

      material=rs("material")

      if material<>"" then
         material="材質 : "&material
         Str=Str&","&Chr("34")&material&Chr("34")
      end if

      origin=rs("origin")
      if origin<>"" then
         origin="產地 : "&origin
         Str=Str&","&Chr("34")&origin&Chr("34")
      end if

      size=rs("size")
      if size<>"" then
         size="尺寸 : "&size
         Str=Str&","&Chr("34")&size&Chr("34")
      end if      

      Str=Str&"],"

      Str=Str&Chr("34")&"pic"&Chr("34")&":"&"["
      if rs("pic")<>"" then
         'pic=split(rs("pic1"),"/")
         'picUrl="https://funday.asia/fundayshop/Img.asp?SN="&pic1(2)
         picUrl="../../../../"&rs("pic")
         Str=Str&Chr("34")&picUrl&Chr("34")
      end if

      if rs("pic1")<>"" then
         'pic1=split(rs("pic1"),"/")
         'pic1Url="https://funday.asia/fundayshop/Img.asp?SN="&pic1(2)
         pic1Url="../../../../"&rs("pic1")
         Str=Str&","&Chr("34")&pic1Url&Chr("34")
      end if

      if rs("pic2")<>"" then
         'pic2=split(rs("pic2"),"/")
         'pic2Url="https://funday.asia/fundayshop/Img.asp?SN="&pic2(2)
         pic2Url="../../../../"&rs("pic2")
         Str=Str&","&Chr("34")&pic2Url&Chr("34")
      end if

      if rs("pic3")<>"" then
         'pic3=split(rs("pic3"),"/")
         'pic3Url="https://funday.asia/fundayshop/Img.asp?SN="&pic3(2)
         pic3Url="../../../../"&rs("pic3")
         Str=Str&","&Chr("34")&pic3Url&Chr("34")
      end if

      if rs("pic4")<>"" then
         'pic4=split(rs("pic4"),"/")
         'pic4Url="https://funday.asia/fundayshop/Img.asp?SN="&pic4(2)
         pic4Url="../../../../"&rs("pic4")
         Str=Str&","&Chr("34")&pic4Url&Chr("34")
      end if

      Str=Str&"],"

      Str=Str&Chr("34")&"Fcoin"&Chr("34")&":"&rs("price")
      Str=Str&"},"

      class_temp=rs("class")

      rs.movenext

      if rs.eof then
         Str=left(Str,len(Str)-1)
         Str=Str&"],"
      elseif  class_temp<>rs("class") then
         Str=left(Str,len(Str)-1)
         Str=Str&"],"
      end if  

   wend

   Str=Str&Chr("34")&"History"&Chr("34")&": [{"
   Str=Str&Chr("34")&"id"&Chr("34")&":"&Chr("34")&"6"&Chr("34")&","
   Str=Str&Chr("34")&"orders"&Chr("34")&":"&Chr("34")&"3"&Chr("34")&","
   Str=Str&Chr("34")&"title"&Chr("34")&":"&Chr("34")&"FUNDAY馬克杯(M)"&Chr("34")&","
   Str=Str&Chr("34")&"type"&Chr("34")&":"&Chr("34")&"2"&Chr("34")&","
   Str=Str&Chr("34")&"description"&Chr("34")&":"&"["&Chr("34")&"規格：容量320ml"&Chr("34")&","&Chr("34")&"材質：瓷"&Chr("34")&","&Chr("34")&"產地：台灣"&Chr("34")&","&Chr("34")&"尺寸：75cm x H80cm x w110cm"&Chr("34")&","&Chr("34")&"特色：看了"&Chr("34")&"],"
   Str=Str&Chr("34")&"pic"&Chr("34")&":"&"["&Chr("34")&"./2021/images/history/main.jpg"&Chr("34")&"],"
   Str=Str&Chr("34")&"Fcoin"&Chr("34")&":"&Chr("34")&"400"&Chr("34")
   Str=Str&"}]"

   Str=Str&"}"

   response.write Str
%>
