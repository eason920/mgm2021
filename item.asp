<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>   
<!-- #include virtual="include/DBConnection.asp"--> 
<%
response.Buffer = true
session.Codepage =65001
response.Charset = "utf-8"  

 mindx=Get_mid()  '--使用者ID
 cindx=Get_cid()  '--customer ID
 enddate=Get_enddate()  '--使用者到期日

 if session("indx")="" then
   response.write "<script>location.href='../../'</script>"
   response.end()
 end if

'mindx=1179  '--使用者ID
'cindx=411  '--customer ID

h=request("h")

if mindx<>"" and h="1" then
	sql = "select * from member_info where customer_id ='"&cindx&"' and  member_id ='"&mindx&"' "
    set rs2 = connection2.execute(sql)
    if not rs2.eof then
		realname=rs2("realname")
		tel=rs2("tel")
		city=rs2("city")
		town=rs2("town")
		zip=rs2("zip")
		location=rs2("location")
		banksn=rs2("banksn")
		bankaccount=rs2("bankaccount")
		accountName=rs2("accountName")
		file1=rs2("file1")
		file2=rs2("file2")
		file3=rs2("file3")
    end if
end if

%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Funday Shop | 商品兌換頁</title>
		<link href="./2021/css/item.css" rel="stylesheet">
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
									:class='{"active": i == 0, "pic-empty": obj.pic[i] == ""}'
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
							<form class="lbinfo is-lbblock" id="Tform" name="Tform" enctype="multipart/form-data" charset="UTF-8">

								<div class="lbinfo-tip">請正確填寫以下收件人相關資訊</div>
								<!-- USUAL v -->
								<div class="lbinfo-iptbox">
									<div class="lbinfo-name">收件人姓名</div>
									<input class="lbinfo-ipt" type="text" ref="ordr_name" name="ordr_name" placeholder="*必填" value="<%=realname%>">									
								</div>
								<div class="lbinfo-iptbox">
									<div class="lbinfo-name">收件人電話</div>
									<input class="lbinfo-ipt" type="text" ref="ordr_tel" name="ordr_tel" placeholder="*必填" value="<%=tel%>">
								</div>

								<!-- BANK v -->
								<div class="bankblock" v-if="category == 'Cash'">
									<div class="lbinfo-iptbox">
										<div class="lbinfo-name">身份證字號</div>
										<input class="lbinfo-ipt" ref="ordr_idno" name="ordr_idno" type="text" placeholder="*必填" autocomplete="off">
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
										<input class="lbinfo-ipt" ref="ordr_Baccount" name="ordr_Baccount" type="text" placeholder="*必填" value="<%=bankaccount%>">
									</div>
									<div class="lbinfo-iptbox">
										<div class="lbinfo-name">帳號戶名</div>
										<input class="lbinfo-ipt" type="text" ref="ordr_BName" name="ordr_BName" placeholder="*必填" value="<%=accountName%>" >									
									</div>									
								</div>

								<!-- TRANSPORT v -->
								<div class="lbinfo-iptbox is-zipcode" >
									<div class="lbinfo-name" v-if="category == 'Cash'">戶籍地址</div>
									<div class="lbinfo-name" v-else>郵遞區號及地址</div>
									<div class="zipbox">
										<div class="zipbox-block">
											<select v-model="zipInfo.county" >
												<option value='' disabled>請選擇縣市</option>
												<option
													v-for="(item, i) in countyAry"
													:key="i"
												>{{item.county}}</option>
											</select>
											<select v-model="zipInfo.town" >
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
											<input class="zipbox-ipt" type="text" ref="zipbox_ipt" v-model="zipipt"  placeholder="*必填" >
										</div>
									</div>
									<input type="hidden" name="ordr_addr"  />
								</div>

								<input type="hidden" name="p_id" v-model="goodsId" />

								<!-- FILES -->
								<div class="filesbox" v-if="category == 'Cash'">
									<div class="lbinfo-tip">請上傳以下證件圖檔</div>
									<div>
										<div class="lbinfo-iptbox">
											<div class="lbinfo-name">匯款存摺封面</div>
											<%if file1<>"" then%>
												<a href='MImg.asp?i=1' class="lb-file" style="margin-right: 10px;font-size: 1.2em;" target="_blank">PIC</a>
											<%end if%>
											<input class="lbinfo-ipt" type="file" ref="file1" name="file1">
										</div>
										<div class="lbinfo-iptbox">
											<div class="lbinfo-name">身份證正面</div>
											<%if file2<>"" then%>
												<a href='MImg.asp?i=2' class="lb-file" style="margin-right: 10px;font-size: 1.2em;" target="_blank">PIC</a>
											<%end if%>											
											<input class="lbinfo-ipt" type="file" ref="file2" name="file2">
										</div>
										<div class="lbinfo-iptbox">
											<div class="lbinfo-name">身份證背面</div>
											<%if file3<>"" then%>
												<a href='MImg.asp?i=3' class="lb-file" style="margin-right: 10px;font-size: 1.2em;" target="_blank">PIC</a>
											<%end if%>											
											<input class="lbinfo-ipt" type="file" ref="file3" name="file3">
										</div>
									</div>
								</div>
								<%if h="" then%>
								<div class="filesbox-ready" style="margin-top: 10px;">
									<div class="filesbox-item" style="cursor: pointer;">使用上回兌換時的系統儲存資料</div>
										<!--<button class="filebox-btn">我要更新</button><!-->
								</div>
								<%end if%>
								<div class="lbinfo-iptbox" v-if="category == 'Cash'" style="height: 100px;color: #10567b;">
									<div class="lbinfo-tip" >
										<p style="height: 40px;">*申請兌換現金時，須提供個人資料與金融帳戶資訊以利報稅與匯款。</p>
										<p>*當月25號前申請，可於次月收到款項。 </p>
									</div>
								</div>
								<div class="lbinfo-iptbox" v-else-if="type==2"  style="height: 60px;color: #10567b;">
									<div class="lbinfo-tip" >* 兌換商品統一於每週一寄出 </div>
								</div>								
							</form>
							<button class="lbbtn">立即兌換</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- #include virtual="fundayshop/footer.asp"-->
			
		<script>
			new Vue({
        created(){
					$('.mgmnav').load('./2021/header.html?1100601');
					//
					const vm = this;
					$.ajax({
						url: './2021/api/FundayShop.asp',
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
							const add = 4- vm.obj.pic.length;
							for(i=1;i<=add;i++){
								vm.obj.pic.push("");
							}
							vm.type=vm.obj.type
							console.log(vm.type)

							// --------------------------------
							// -- PURCHASE v
							// --------------------------------
							$('.filesbox-item').on('click',function(){
								location.href=location.href+'&h=1'
							})
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
									if(chkStr==1 && vm.$refs.ordr_BName.value==''){
										chkStr=0;
										vm.$refs.ordr_BName.focus();				
									}									
									if(chkStr==1 && (!vm.zipInfo.selected || vm.zipipt=='') ){
										chkStr=0;
										vm.$refs.zipbox_ipt.focus();				
									}

									Tform.ordr_addr.value=vm.filterCode+vm.zipInfo.county+vm.zipInfo.town+vm.zipipt	

									<%if h="" or (h<>"" and (file1="" or file2="" or file3="") ) then%>
									if(chkStr==1 && (vm.$refs.file1.value=='' || vm.$refs.file2.value=='' || vm.$refs.file3.value=='')){
										chkStr=0;
										alert('請依序上傳證件圖片')
									}
									<%end if%>								
								}

								//(chkStr==1)?console.log($('#Tform').serialize()):null
								
								if(chkStr==1){
									if(confirm("確定是否兌換商品?")){
										var form = $('#Tform')[0];
    									var formData = new FormData(form);
										//if(vm.category!='Cash'){										
											formData.append('city', vm.zipInfo.county);
											formData.append('town', vm.zipInfo.town);
											formData.append('zip', vm.filterCode);
											formData.append('location', vm.zipipt);
										//}
										var fg={};
										for (var key of formData.keys()) {
											if(key!='file1' && key!='file2' && key!='file3'){
												formData.set(key,escape(formData.get(key)));
											}else{
												
												formData.set(key,formData.get(key),key+escape(formData.get(key).name));
												//formData.set(key,formData.get(key),'file.doc');
												console.log(formData.get(key))
											}	
										}

										$.ajax({
											type: "POST",//方法
											url: "../../../../fundayshop/ordersC.asp" ,//表單接收url
											data: formData,
											contentType: false,
											cache: false,
											processData: false,
											contentType : false , 											
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

											},
											error:function(res){
												console.log(res)
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
						if( style != ''){
							$('.lbpic-kv').attr('style', 'background-image: url(' + style + ')');
							$('.lbpic-item').removeClass('active').eq(i).addClass('active');
						};
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
					type:"",
					obj: {
						orders: "",
						title: "",
						description: [],
						pic: [],
						Fcoin: "",
					},
					countyAry: [],
					zipInfo: {
						county: "<%=city%>",
						town: "<%=town%>",
						selected: false
					},
					zipipt:"<%=location%>",					
					bank: {
						ary: [],
						selected: '<%=banksn%>'
					}

				},
        el: "#App",
      })
		</script>
	</body>
</html>