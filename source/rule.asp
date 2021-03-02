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
		<title>Funday Shop</title>
		<link href="./2021/css/index.css" rel="stylesheet">
		<link href="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.css" rel="stylesheet">
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<script src="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.min.js"></script>
		<script src="./2021/js/cpn_index.js"></script>
		<style>
			.ps__rail-x, .ps__rail-y {opacity: 0.6};
		</style>
		<link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">
	</head>
	<body>
		<div class="mgmnav">
			<div class="wrapper"><a class="mgmnav-box" href="https://funday.asia/" target="_blank"><img class="img-responsive" src="./2021/images/logo.png" alt="fundy logo">
					<div class="mgmnav-home">首頁</div></a></div>
		</div>
		<div class="mgmcontent" id="app">
			<div class="wrapper">
				<div class="logobox">
					<div v-text='text'></div>
					  <select v-model='text'>
							<option value='' disabled>-- select --</option>
							<option value='0'>0</option>
							<option value='1'>1</option>
						</select>
					<img class="logobox-bonus" src="./2021/images/bonus.png"><img class="logobox-what" src="./2021/images/what.png"></div>
				<div class="mainbox">
					<div class="leftbox">
						<div class="tabbox">
							<button class="tabbox-item" @click='fnTabboxItem("list", 0)' data-tab="list"><i class="far fa-paper-plane"></i>
								<h3>列表</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("learning", 1)' data-tab="learning"><i class="far fa-file-alt"></i>
								<h3>學習獎勵</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("recommend", 2)' data-tab="recommend"><i class="fas fa-gift"></i>
								<h3>推薦獎勵</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("campaign", 3)' data-tab="campaign"><i class="fas fa-search-plus"></i>
								<h3>活動獎勵</h3>
							</button>
							<div class="tabbox-active"></div>
						</div>
						<div class="contentbox">
							<div class="contentbox-item" data-tab="list">
								<div class="contentbox-tip is-head">
									<ol>
										<li>項目</li>
									</ol>
									<ol>
										<li>完成日期</li>
									</ol>
									<ol>
										<li> 
											<div class="for-pc">Fun coin幣</div>
											<div class="for-mb">F coin</div>
										</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s0">
									<div class="box">
										<cpn_list
											:prop='item'
											v-for='(item, i) in ary.list'
											:key='i'
										></cpn_list>
									</div>
								</div>
							</div>
							<div class="contentbox-item" data-tab="learning">
								<div class="contentbox-tip is-head">
									<ol>
										<li>學習獎勵</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s1">
									<div class="box">
										<cpn_2
											:prop='item'
											v-for='(item, i) in ary.learning'
											:req_i='i + 1'
											:key='i'
										></cpn_2>
									</div>
								</div>
							</div>
							<div class="contentbox-item" data-tab="recommend">
								<div class="contentbox-tip is-head">
									<ol>
										<li>推薦獎勵</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s2">
									<div class="box">
										<cpn_2
											:prop='item'
											v-for='(item, i) in ary.recommend'
											:req_i='i + 1'
											:key='i'
										></cpn_2>
									</div>
								</div>
							</div>
							<div class="contentbox-item" data-tab="campaign">
								<div class="contentbox-tip is-head">
									<ol>
										<li>活動獎勵</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s3">
									<div class="box">
										<cpn_2
											:prop='item'
											v-for='(item, i) in ary.campaign'
											:req_i='i + 1'
											:key='i'
										></cpn_2>
									</div>
								</div>
							</div>
							<div class="contentbox-total">
								<h2>目前累積<span id="countToSum"></span>Fun Coin幣</h2><a class="contentbox-convert" href="page.asp">兌換</a>
							</div>
						</div>
					</div>
					<div class="coinbox-lb">
						<div class="coinbox-close">╳</div>
						<div class="coinbox"><img class="img-responsive-title" src="./2021/images/coin-title.png" alt=""><img class="img-responsive-coin-a" src="./2021/images/coin-1.png" alt=""><img class="img-responsive-text" src="./2021/images/coin-text.png" alt="">
							<h3>FUN幣可兌換FUNDAY SHOP<br>裡的<span>各種商品</span>。</h3>
							<h3>FUN幣累積達到3000點時，<br>始可<span>兌換現金</span>。</h3>
							<div class="p">*申請兌換現金時，須提供個人資料與<br>金融帳戶資訊以利報稅與匯款。</div>
							<div class="code-button">個人專屬優惠代碼</div><img class="img-responsive-coin-b" src="./2021/images/coin-2.png" alt="">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mgmfoo">
			<div class="mgmfoo-mb">© 2021 Brainstorm Digital Communications Corp.<br>All rights reserved. Privacy Policy</div>
		</div>
		<script>
			const App = new Vue({
				created(){
					const vm = this;
					$.ajax({
						type: 'GET',
						url: './2021/api/FcoinList.Json',
						success(res){
							vm.data = res;
							console.log('data ', vm.data);
							vm.ary.list = vm.data.List;
							vm.ary.learning = vm.data.LearningRule;
							vm.ary.recommend = vm.data.RecommendRule;
							vm.ary.campaign = vm.data.CampaignRule;
							//
							vm.fnCountToSum( $('#countToSum') , vm.data.FunCoin, '', 2000);
							//
							vm.ww = $(window).width();
							if( vm.ww > 991 ){
								new PerfectScrollbar('.is-s0');
								setTimeout(()=>{
									$('.is-s0').scrollTop(1);
								}, 0);
							}else{
								$('.logobox-what').click(function(){
									$('.mgmcontent').addClass('is-open');
								});

								$('.coinbox-lb').click(function(){
									$('.mgmcontent').removeClass('is-open');
								});
							};
							//
							$('.tabbox-item:eq(0)').click();
							//

						}
					});
				},
				methods: {
					fnCountToSum(element, number, suffix, duration) {
						$({ count: parseInt(element.text().split("+")[0].replace(/\,/g, '')) }).animate({ count: number }, {
							duration: duration ? duration : 1000,
							easing: 'swing',
							step: function (now) {
								element.text((Math.floor(now) + suffix).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
							}
						});
					},

					fnTabboxItem(tab, index){
						const vm = this;
						const left = index * 25 + '%';
						let key = '';

						//
						switch(index){
							case 1: key = "s1";break;
							case 2: key = "s2";break;
							case 3: key = "s3";break;
							default:
						};
						if( !vm.plugins[key] ){
							const target = '.is-s' + index;
							new PerfectScrollbar(target);
							setTimeout(()=>{
								$(target).scrollTop(1);
							}, 0);
							vm.plugins[key] = true;
						};

						//
						$('.tabbox-active').css({left})
						//
						$('.tabbox-item, .contentbox-item').removeClass('active');
						$('.tabbox-item:eq('+index+')').addClass('active');
						//
						$('.contentbox').attr('data-tab', tab);
						//
						$('.contentbox-item').css('display', 'none');
						$('.contentbox-item[data-tab="'+ tab +'"]').css('display', 'block').addClass('active');
					},
				},
				data: {
					data: new Object(),
					ww: '',
					ary: {
						list: new Array(),
						learning: new Array(),
						recommend: new Array(),
						campaign: new Array()
					},
					plugins: {
						s1: false,
						s2: false,
						s3: false
					},
					text: 'eason here'
				},
				el: '#app',
				components: {
					cpn_list,
					cpn_2
				}
			});

			Vue.config.devtools = true;
		</script>
	</body>
</html>