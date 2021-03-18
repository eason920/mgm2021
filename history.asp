<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>   
<!-- #include virtual="include/DBConnection.asp"--> 
<%
response.Buffer = true
session.Codepage =65001
response.Charset = "utf-8"  

' mindx=Get_mid()  '--使用者ID
' cindx=Get_cid()  '--customer ID
' enddate=Get_enddate()  '--使用者到期日

' if session("indx")="" then
'   response.write "<script>location.href='../../'</script>"
'   response.end()
' end if

%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Funday Shop | 每月主題</title>
		<link href="./2021/css/history.css" rel="stylesheet">
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<script src="./2021/js/cpn_list.js"></script>
		<link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">
	</head>
	<body>
		<div class="mgmnav">
			<div class="wrapper"><a class="mgmnav-box" href="https://funday.asia/" target="_blank"><img class="img-responsive" src="./2021/images/logo.png" alt="fundy logo">
					<div class="mgmnav-home">首頁</div></a></div>
		</div>
		<div class="mgmcontent" id="App">
			<div class="wrapper">
				<div class="mgmlb-box">
					<div class="mgmlb-bread">
						<p class="bread-1">FUNDAY SHOP</p>
						<span>></span>
						<p class="bread-2">每月主題</p>
						<span>></span>
						<p class="bread-3">{{obj.title}}</p>
					</div>
					<div class="mgmlb-flex">
						<div class="mgmlb-pic">
							<div class="lbpic-kv" :style="obj.pic[0] | filterBG"><img src="./2021/images/history/empty.png"></div>
						</div>
						<div class="mgmlb-info">
							<div class="lbproduct is-lbblock">
								<div class="lbproduct-title">{{obj.title}}</div>
								<div class="lbproduct-pricebox"></div>
							</div>
							<div class="lbtalk is-lbblock">
								<div class="history-name">商品資訊</div>
								<div class="lbtalk-item"
									v-for='(item, i) in obj.description'
									:key='i'
								>{{obj.description[i]}}</div>
							</div>
						</div>
					</div>
				</div>
				<div class="history-tales">
					<img class="is-pc" src="./2021/images/history/talk_pc.jpg">
					<img class="is-mb" src="./2021/images/history/talk_mb.jpg">
				</div>
			</div>
		</div>
		<div class="history-vbox-f1">
			<div class="history-vbox-f2">
				<div class="history-vbox-f3">
					<iframe src="https://www.youtube.com/embed/LZTsEhjRBGI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				</div>
			</div>
		</div>
		<a class="lbbtn" href="https://funday.asia/fundayshop/item.asp?cat=Life&id=18">前往購買</a>
		
		<!-- #include virtual="fundayshop/footer.asp"-->
			
		<script>
			new Vue({
        created(){
					$('.mgmnav').load('./2021/header.html');
					//
					const vm = this;

				},
        data: {
					obj: {
						title:  "FUNDAY馬克杯",
						description: ["材質 : 陶瓷","產地 : MIT","尺寸 : 杯面直徑8CM, 高度9.5CM","商品描述 :","經典直筒陶瓷白杯，搭配FUNDAY專屬字樣LOGO，","襯托出簡約兼具時尚，微波加熱沒問題。"],
						pic: ["./2021/images/history/main.jpg"],
					}
				},
        el: "#App",
      })
		</script>
	</body>
</html>