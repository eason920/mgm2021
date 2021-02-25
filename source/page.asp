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
		<title>mgm page</title>
		<link href="./2021/css/page.css" rel="stylesheet">
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
				<h4 class="gifttitle is-first">學習類</h4>
				<section class="giftbox" data-category="1">
					<div class="giftbox-scroller">
						<cpn_item
							:prop='item'
							v-for='(item, i) in ary.learning'
							:key='i'
							:req_style='item.pic[0] | filterBG'
							@connect_click='fnOpenLB(item)'
						></cpn_item>
						<!--div class="giftbox-item is-empty"></div-->
					</div>
				</section>
				<h4 class="gifttitle">生活類</h4>
				<section class="giftbox" data-category="2">
					<div class="giftbox-scroller">
						<cpn_item
							:prop='item'
							v-for='(item, i) in ary.life'
							:key='i'
							:req_style='item.pic[0] | filterBG'
							@connect_click='fnOpenLB(item)'
						></cpn_item>
					</div>
				</section>
				<h4 class="gifttitle">現金類</h4>
				<section class="giftbox" data-category="3">
					<div class="giftbox-scroller">
						<cpn_item
							:prop='item'
							v-for='(item, i) in ary.cash'
							:key='i'
							:req_style='item.pic[0] | filterBG'
							@connect_click='fnOpenLB(item)'
						></cpn_item>
						<!--div class="giftbox-item is-empty"></div-->
						<!--div class="giftbox-item is-empty"></div-->
					</div>
				</section>
				<section class="mgmlimit">
					<p>**VIP會員若到期，點數僅保留3個月。</p>
					<p>**活動有效日期110年8月31日。</p>
				</section>
			</div>
		</div>
		<div class="mgmfoo">
			<div class="mgmfoo-mb">© 2021 Brainstorm Digital Communications Corp.<br>All rights reserved. Privacy Policy</div>
		</div>
		<div class="mgmlb"></div>
		<div class="mgmlb-scroller" id="AppLB">
			<div class="mgmlb-box">
				<div class="mgmlb-close" @click='fnClose'>╳</div>
				<div class="mgmlb-pic">
					<div class="lbpic-kv" :style="data.pic[0] | filterBG"><img src="./2021/images/empty_lb.png"></div>
					<div class="lbpic-box">
						<div class="lbpic-item"
							v-for='(item, i) in data.pic'
							:style="data.pic[i] | filterBG"
							:key='i'
							:class='{"active": i == 0}'
							@click='fnChange( data.pic[i], i )'
						><img src="./2021/images/empty_lb.png"></div>
					</div>
				</div>
				<div class="mgmlb-info">
					<div class="lbproduct is-lbblock">
						<div class="lbproduct-title">{{data.title}}</div>
						<div class="lbproduct-pricebox">
							<div class="lbproduct-price">
								<img class="giftbox-icon" src="./2021/images/icon.svg">
								<span class="lbproduct-prefix">兌換點數：</span><span>{{data.Fcoin}}</span>點
							</div>
						</div>
					</div>
					<div class="lbtalk is-lbblock">
						<div class="lbtalk-item"
							v-for='(item, i) in data.description'
							:key='i'
						>{{data.description[i]}}</div>
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
									<select>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
									</select>
									<select>
										<option value="a">a</option>
										<option value="b">b</option>
										<option value="c">c</option>
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
		<script>
			const App = new Vue({
				created(){
					const vm = this;
					console.log('page got vue');
					$.ajax({
						url: './2021/api/FundayShop.Json',
						success(res){
							console.log('res > ', res);
							//
							vm.ary.learning = res.Learning;
							vm.ary.life = res.Life;
							vm.ary.cash = res.Cash;
							console.log(vm.ary.learning, vm.ary.life, vm.ary.cash);


							// --------------------------------
							const ww = $(window).width();
							const nua = navigator.userAgent;
							
							if( /android | iphone/i.test(nua) || /ipad/i.test(nua) && ww <= 768 ){
								setTimeout(()=>{
									const w = $('.giftbox-item').outerWidth(true);
									const g = w - $('.giftbox-item').outerWidth();
									for( i=1; i<=3; i++){
										const l = $('.giftbox[data-category="'+i+'"]').find('.giftbox-item').length - $('.giftbox[data-category="'+i+'"]').find('.is-empty').length;
										const width = w * l + g;
										$('.giftbox[data-category="'+i+'"] .giftbox-scroller').css({width});
										console.log('is mb', w, l, g, width);
										//
										vm.deviceClass = 'is-mb-open';
									};
								}, 0);
								
							}else{
								$(window).on('load resize', function(){ vm.fnImgOuterHeight() });

								new PerfectScrollbar('.mgmlb-info');
								//
								vm.deviceClass = 'is-pc-open';
							};
							
						}
					})
				},
				methods: {
					fnOpenLB(item){
						console.log(item);
						const vm = this;
						const time = 300;
						$('.mgmlb, .mgmlb-box').fadeIn(time);
						$('body').addClass(vm.deviceClass);
						setTimeout(()=>{
							$('.mgmlb-box').css('display', 'flex')
							$('.mgmlb-info').scrollTop(1);
						}, time);
						$('html').css('overflow', 'hidden');
						//
						AppLB._data.data = item
					},

					fnImgOuterHeight(){
						setTimeout(()=>{
							const height = $('.giftbox-img').height();
							$('.giftbox-imgouter').css({height});
						}, 100);
					},

					
				},
				data: {
					ary: {
						learning: new Array(),
						life: new Array(),
						cash: new Array()
					},
					deviceClass: '',
				},
				components: {
					cpn_item,
				},
				el: '#App'
			});

			const AppLB = new Vue({
				data: {
					data: {
						orders: "",
						title: "",
						description: [""],
						pic: [""],
						Fcoin: ""
					},
				},
				methods: {
					fnClose(){
						const time = 300;
						$('.mgmlb, .mgmlb-box').fadeOut(time);
						$('html').removeAttr('style');
						//
						setTimeout(()=>{
							$('body').removeClass(App._data.deviceClass);
							$('.lbpic-item').removeClass('active').eq(0).addClass('active');
						}, time);
					},

					fnChange(style, i){
						$('.lbpic-kv').attr('style', 'background-image: url(' + style + ')');
						$('.lbpic-item').removeClass('active').eq(i).addClass('active');
					}
				},
				el: '#AppLB'
			});
		</script>
	</body>
</html>