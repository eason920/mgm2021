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
		<title>item</title>
		<link href="./2021/css/item.css" rel="stylesheet">
		<link href="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.css" rel="stylesheet">
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<script src="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.min.js"></script>
		<!--script src="./2021/js/page.js"></script-->
		<script src="./2021/js/cpn_page.js"></script>
		<style>
			.ps__rail-x, .ps__rail-y, .ps__thumb-y {opacity: .6}
		</style>
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
						<p class="bread-2">{{category_ch}}</p>
						<span>></span>
						<p class="bread-3">{{obj.title}}</p>
					</div>
					<div class="mgmlb-flex">
						<div class="mgmlb-pic">
							<div class="lbpic-kv" :style="obj.pic[0] | filterBG"><img src="./2021/images/empty_lb.png"></div>
							<div class="lbpic-box">
								<div class="lbpic-item"
									v-for='(item, i) in obj.pic'
									:style="obj.pic[i] | filterBG"
									:key='i'
									:class='{"active": i == 0}'
									@click='fnChange( obj.pic[i], i )'
								><img src="./2021/images/empty_lb.png"></div>
							</div>
						</div>
						<div class="mgmlb-info">
							<div class="lbproduct is-lbblock">
								<div class="lbproduct-title">{{obj.title}}</div>
								<div class="lbproduct-pricebox">
									<div class="lbproduct-price">
										<img class="giftbox-icon" src="./2021/images/icon.svg">
										<span class="lbproduct-prefix">兌換點數：</span><span>{{obj.Fcoin}}</span>點
									</div>
								</div>
							</div>
							<div class="lbtalk is-lbblock">
								<div class="lbtalk-item"
									v-for='(item, i) in obj.description'
									:key='i'
								>{{obj.description[i]}}</div>
							</div>
							<form class="lbinfo is-lbblock">
								<div class="lbinfo-tip">請正確填寫以下收件人相關資訊</div>
								<div class="lbinfo-iptbox">
									<div class="lbinfo-name">收件人姓名</div>
									<input class="lbinfo-ipt" type="text" placeholder="*必填">
								</div>
								<div class="lbinfo-iptbox">
									<div class="lbinfo-name">收件人電話</div>
									<input class="lbinfo-ipt" type="text" placeholder="*必填">
								</div>
								<div class="lbinfo-iptbox is-zipcode">
									<div class="lbinfo-name">郵遞區號及地址</div>
									<div class="zipbox">
										<div class="zipbox-block">
											<select v-model="county">
												<option value='' disabled>請選擇縣市</option>
												<option
													v-for="(item, i) in zipcode"
													:key="i"
												>{{item.county}}</option>
											</select>
											<select v-model="town">
												<option value='' disabled>請選擇鎮市區</option>
												<!--v-for="(item, i) in filter_town"
												
													:key="i"
												<option>{{item.county}}</option>
												-->
											</select>
										</div>
										<div class="zipbox-block">
											<div class="zipbox-code is-selected">114</div>
											<input class="zipbox-ipt" type="text" placeholder="*必填">
										</div>
									</div>
								</div>
							</form>
							<button class="lbbtn">立即兌換</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mgmfoo">
			<div class="mgmfoo-mb">© 2021 Brainstorm Digital Communications Corp.<br>All rights reserved. Privacy Policy</div>
		</div>
			
		<script>
			new Vue({
        created(){
					const vm = this;
					$.ajax({
						url: './2021/api/FundayShop.Json',
						type: "GET",
						contentType: "application/json",
						success(res){
							const url = location.href;
							let val;
							let index;
							if( url.match(/[?=]/) ){
								console.log('have ? = ');
								val = url.split("?")[1].split("&");
								vm.category = val[0].split("cat=")[1];
								vm.id = val[1].split("id=")[1];
								//
								res[vm.category].forEach(function(item,i){
									if( item.id == vm.id ){ index = i };
								})
							}else{
								console.log('no ? =');
								vm.category = "Life";
								index = 0
							}

							// --------------------------------
							if( !res[vm.category] ){
								vm.category = "Life";
							};

							if( !res[vm.category][index] ){
								index = 0;
							};

							switch(vm.category){
								case "Life":
									vm.category_ch = "生活類";break;
								case "Learning":
									vm.category_ch = "學習類";break;
								case "Cash":
									vm.category_ch = "現金類";break;
							}
							// --------------------------------
							vm.obj = res[vm.category][index];
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
							vm.zipcode = res;
						}
					});
				},
				methods: {
					fnChange(style, i){
						$('.lbpic-kv').attr('style', 'background-image: url(' + style + ')');
						$('.lbpic-item').removeClass('active').eq(i).addClass('active');
					},
				},
				computed: {
					filter_town(){
						const vm = this;
						const index = vm.zipcode.findIndex(function(item, i){
							return item.county == vm.county;
						});
						return vm.zipcode[index].ary;
					}
				},
        data: {
					category: "",
					category_ch: "",
					id: "",
					obj: {
						orders: "",
						title: "",
						description: [],
						pic: [],
						Fcoin: "",
					},
					zipcode: [],
					county: "",
					town: "",
					town_ary: "",
				},
        el: "#App",
      })
		</script>
	</body>
</html>