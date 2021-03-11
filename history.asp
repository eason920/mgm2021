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
		<!--link href="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.css" rel="stylesheet"-->
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<!--script src="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.min.js"></script-->
		<!--script src="./2021/js/page.js"></script-->
		<script src="./2021/js/cpn_page.js"></script>
		<!--style>
			.ps__rail-x, .ps__rail-y, .ps__thumb-y {opacity: .6}
		</style-->
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
		<div class="mgmfoo">
			<div class="mgmfoo-pc" ><!-- #include virtual="fundayshop/footer.asp"--></div>
			<div class="mgmfoo-mb">© 2021 Brainstorm Digital Communications Corp.<br>All rights reserved. Privacy Policy</div>
		</div>
			
		<script>
			new Vue({
        created(){
					$('.mgmnav').load('./2021/header.html');
					//
					const vm = this;
					$.ajax({
						url: './2021/api/FundayShop.Json',
						type: "GET",
						contentType: "application/json",
						success(res){
							const url = location.href;
							// let val;
							// let index;
							// if( url.match(/[?=]/) ){
							// 	console.log('have ? = ');
							// 	val = url.split("?")[1].split("&");
							// 	vm.category = val[0].split("cat=")[1];
							// 	vm.goodsId = val[1].split("id=")[1];
							// 	//
							// 	res[vm.category].forEach(function(item,i){
							// 		if( item.id == vm.goodsId ){ index = i };
							// 	})
							// }else{
							// 	console.log('no ? =');
							// 	vm.category = "Life";
							// 	index = 0
							// }

							// // --------------------------------
							// if( !res[vm.category] ){
							// 	vm.category = "Life";
							// };

							// if( !res[vm.category][index] ){
							// 	index = 0;
							// };

							// switch(vm.category){
							// 	case "Life":
							// 		vm.categoryCh = "生活類";break;
							// 	case "Learning":
							// 		vm.categoryCh = "學習類";break;
							// 	case "Cash":
							// 		vm.categoryCh = "現金類";break;
							// }
							// --------------------------------
							vm.obj = res.History[0];
						}
					});

					// ==========================================
					// == ZIP CODE v
					// ==========================================
					$.ajax({
						url: "./2021/api/zipcode_item.json",
						type: "GET",
						contentType: "application/json",
						success(res){
							vm.countyAry = res;
						}
					});

					// ==========================================
					// == BANK v
					// ==========================================
					$.ajax({
						url: "./2021/api/bank.json",
						type: "GET",
						contentType: "application/json",
						success(res){
							vm.bank.ary = res;
						}
					});
				},
				methods: {
					// fnChange(style, i){
					// 	$('.lbpic-kv').attr('style', 'background-image: url(' + style + ')');
					// 	$('.lbpic-item').removeClass('active').eq(i).addClass('active');
					// },
				},
				computed: {
					// filterTown(){
					// 	const vm = this;
					// 	const index = vm.countyAry.findIndex(function(item, i){
					// 		return item.county == vm.zipInfo.county;
					// 	});
					// 	if( index >= 0 ){
					// 		return vm.countyAry[index].ary;
					// 	}else{
					// 		return [];
					// 	}
					// },
					// filterCode() {
					// 	const vm = this;
					// 	const countyIndex = vm.countyAry.findIndex(function(item){
					// 		return item.county == vm.zipInfo.county;
					// 	});
					// 	if( countyIndex >= 0){
					// 		const townIndex = vm.countyAry[countyIndex].ary.findIndex(function(item){
					// 			return item.town == vm.zipInfo.town;
					// 		});
					// 		if( townIndex >= 0 ){
					// 			vm.zipInfo.selected = true;
					// 			return vm.countyAry[countyIndex].ary[townIndex].code;
					// 		}else{
					// 			vm.zipInfo.selected = false;
					// 			return "選填郵遞區號";
					// 		}
					// 	}else{
					// 		vm.zipInfo.selected = false;
					// 		return "選填郵遞區號";
					// 	}
					// }
				},
        data: {
					category: "",
					categoryCh: "",
					goodsId: "",
					obj: {
						orders: "",
						title: "",
						description: [],
						pic: [],
						Fcoin: "",
					},
					countyAry: [],
					zipInfo: {
						county: "",
						town: "",
						selected: false
					},
					bank: {
						ary: [],
						selected: ''
					}

				},
        el: "#App",
      })
		</script>
	</body>
</html>