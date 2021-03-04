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
		<link href="./2021/css/index_flat.css" rel="stylesheet">
		<!--link href="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.css" rel="stylesheet"-->
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<!--script src="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.min.js"></script-->
		<!--script src="./2021/js/page.js"></script-->
		<script src="./2021/js/cpn_index.js"></script>
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
				<h4 class="gifttitle is-first">生活類</h4>
				<section class="giftbox" data-category="2">
					<div class="giftbox-scroller">
						<cpn_item
							:prop='item'
							v-for='(item, i) in ary.life'
							:key='i'
							:req_style='item.pic[0] | filterBG'
							@connect_click='fnLink("Life", item.id)'
						></cpn_item>
					</div>
				</section>
				<h4 class="gifttitle">學習類</h4>
				<section class="giftbox" data-category="1">
					<div class="giftbox-scroller">
						<cpn_item
							:prop='item'
							v-for='(item, i) in ary.learning'
							:key='i'
							:req_style='item.pic[0] | filterBG'
							@connect_click='fnLink("Learning", item.id)'
						></cpn_item>
						<!--div class="giftbox-item is-empty"></div-->
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
							@connect_click='fnLink("Cash", item.id)'
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
							vm.ary.life = res.Life;
							vm.ary.learning = res.Learning;
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

								// new PerfectScrollbar('.mgmlb-info');
								//
								vm.deviceClass = 'is-pc-open';
							};
							
						}
					})
				},
				methods: {
					fnLink(category, id){
						location.href= "item.asp?cat=" + category + "&id=" + id;
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
		</script>
	</body>
</html>