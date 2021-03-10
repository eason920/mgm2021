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
		<title>Funday Shop | 商品兌換頁</title>
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
						<p class="bread-2">{{categoryCh}}</p>
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
							<form class="lbinfo is-lbblock" id="Tform" name="Tform">
								<div class="lbinfo-tip">請正確填寫以下收件人相關資訊</div>
								<!-- USUAL v -->
								<div class="lbinfo-iptbox">
									<div class="lbinfo-name">收件人姓名</div>
									<input class="lbinfo-ipt" type="text" ref="ordr_name" name="ordr_name" placeholder="*必填">
								</div>
								<div class="lbinfo-iptbox">
									<div class="lbinfo-name">收件人電話</div>
									<input class="lbinfo-ipt" type="text" ref="ordr_tel" name="ordr_tel" placeholder="*必填">
								</div>

								<!-- BANK v -->
								<div class="bankblock" v-if="category == 'Cash'">
									<div class="lbinfo-iptbox">
										<div class="lbinfo-name">身份證字號</div>
										<input class="lbinfo-ipt" ref="ordr_idno" name="ordr_idno" type="text" placeholder="*必填">
									</div>
									<div class="lbinfo-iptbox">
										<div class="lbinfo-name">銀行代號</div>
										<select class="is-bank-select" ref="ordr_Bcode" name="ordr_Bcode" v-model="bank.selected">
											<option value="" disabled>請選擇銀行代號</option>
											<option
												v-for="(item, i) in bank.ary"
												:key="i"
											>{{item}}</option>
										</select>
									</div>
									<div class="lbinfo-iptbox">
										<div class="lbinfo-name">銀行帳號</div>
										<input class="lbinfo-ipt" ref="ordr_Baccount" name="ordr_Baccount" type="text" placeholder="*必填">
									</div>
								</div>

								<!-- TRANSPORT v -->
								<div class="lbinfo-iptbox is-zipcode" v-else>
									<div class="lbinfo-name">郵遞區號及地址</div>
									<div class="zipbox">
										<div class="zipbox-block">
											<select v-model="zipInfo.county">
												<option value='' disabled>請選擇縣市</option>
												<option
													v-for="(item, i) in countyAry"
													:key="i"
												>{{item.county}}</option>
											</select>
											<select v-model="zipInfo.town">
												<option value='' disabled>請選擇鎮市區</option>
												<option 
													v-for="(item, i) in filterTown"
													:key="i"
												>{{item.town}}</option>
											</select>
										</div>
										<div class="zipbox-block">
											<div class="zipbox-code"
												:class="{ 'is-selected' : zipInfo.selected == true}"
											>{{filterCode}}</div>
											<input class="zipbox-ipt" type="text" ref="zipbox_ipt" v-model="zipipt" placeholder="*必填">
										</div>
									</div>
									<input type="hidden" name="ordr_addr"  />
								</div>
								<input type="hidden" name="p_id" v-model="goodsId" />
							</form>
							<button class="lbbtn">立即兌換</button>
						</div>
					</div>
				</div>
			</div>
		</div>
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
							let val;
							let index;
							if( url.match(/[?=]/) ){
								console.log('have ? = ');
								val = url.split("?")[1].split("&");
								vm.category = val[0].split("cat=")[1];
								vm.goodsId = val[1].split("id=")[1];
								//
								res[vm.category].forEach(function(item,i){
									if( item.id == vm.goodsId ){ index = i };
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
									vm.categoryCh = "生活類";break;
								case "Learning":
									vm.categoryCh = "學習類";break;
								case "Cash":
									vm.categoryCh = "現金類";break;
							}
							// --------------------------------
							vm.obj = res[vm.category][index];

							$('.lbbtn').on('click',function(){
								let chkStr=1;

								if(chkStr==1 && vm.$refs.ordr_name.value==''){
									chkStr=0;
									vm.$refs.ordr_name.focus();		
								}

								if(chkStr==1 && vm.$refs.ordr_tel.value==''){
									chkStr=0;
									vm.$refs.ordr_tel.focus();				
								}


								if(vm.category!='Cash'){

									if(chkStr==1 && (!vm.zipInfo.selected || vm.zipipt=='') ){
										chkStr=0;
										vm.$refs.zipbox_ipt.focus();				
									}

									Tform.ordr_addr.value=vm.filterCode+vm.zipInfo.county+vm.zipInfo.town+vm.zipipt							
								}else{
									if(chkStr==1 && vm.$refs.ordr_idno.value==''){
										chkStr=0;
										vm.$refs.ordr_idno.focus();				
									}
									if(chkStr==1 && vm.$refs.ordr_Bcode.value==''){
										chkStr=0;
										vm.$refs.ordr_Bcode.focus();				
									}	
									if(chkStr==1 && vm.$refs.ordr_Baccount.value==''){
										chkStr=0;
										vm.$refs.ordr_Baccount.focus();				
									}								
								}

								//(chkStr==1)?console.log($('#Tform').serialize()):null
								
								if(chkStr==1){
									if(confirm("確定是否兌換商品?")){
										$.ajax({
											type: "POST",//方法
											url: "../../../../fundayshop/ordersC.asp" ,//表單接收url
											data: $('#Tform').serialize(),
											success: function (res) {
												const obj = JSON.parse(res);
												console.log( 'type is > ', typeof(obj));
												console.log(obj, obj.Status, obj.Status == 0)
												if( obj.Status == 0 ){
													console.log('0, error');
													if( obj.message == "點數不足"){
														alert("點數不足")
													}else{
														alert("無此商品")
													}
												}else{
													console.log('1, success');
													alert( "您的商品「" + vm.obj.title + "」兌換成功!" );
													location.href = "./rule.asp"
												}
											}
										});
									}
								}
								
							})

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
					fnChange(style, i){
						$('.lbpic-kv').attr('style', 'background-image: url(' + style + ')');
						$('.lbpic-item').removeClass('active').eq(i).addClass('active');
					},
				},
				computed: {
					filterTown(){
						const vm = this;
						const index = vm.countyAry.findIndex(function(item, i){
							return item.county == vm.zipInfo.county;
						});
						if( index >= 0 ){
							return vm.countyAry[index].ary;
						}else{
							return [];
						}
					},
					filterCode() {
						const vm = this;
						const countyIndex = vm.countyAry.findIndex(function(item){
							return item.county == vm.zipInfo.county;
						});
						if( countyIndex >= 0){
							const townIndex = vm.countyAry[countyIndex].ary.findIndex(function(item){
								return item.town == vm.zipInfo.town;
							});
							if( townIndex >= 0 ){
								vm.zipInfo.selected = true;
								return vm.countyAry[countyIndex].ary[townIndex].code;
							}else{
								vm.zipInfo.selected = false;
								return "選填郵遞區號";
							}
						}else{
							vm.zipInfo.selected = false;
							return "選填郵遞區號";
						}
					}
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
					zipipt:"",					
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