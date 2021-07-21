<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>   
<!-- #include virtual="include/DBConnection.asp"--> 
<!--#include virtual="include/aspJSON1.17.asp"-->
<!-- #include virtual="fundayshop/api/function.asp"--> 
<%
response.Buffer = true
session.Codepage =65001
response.Charset = "utf-8"  

function MemberJson(mindx)
	Str_count="{"
	Str_count=Str_count&Chr("34")&"member_index"&Chr("34")&" : "&Chr("34")&mindx&Chr("34")
	Str_count=Str_count&"}"

	postData=Str_count

	url="http://salesbackend.funday.asia:81/api/serviceInfo"
	Set winHttpS = CreateObject("WinHttp.WinHttpRequest.5.1")
	winHttpS.setTimeouts 30000, 30000, 70000, 70000
	winHttpS.Open "POST", url, False
	winHttpS.SetRequestHeader "Content-Type", "application/json"
	winHttpS.SetRequestHeader "Statuskey", "member_id|"  
	winHttpS.SetRequestHeader "Content-Length", CStr(Len(postData))
	winHttpS.Send (postData)
	result = winHttpS.ResponseText
	getStatus = winHttpS.Status
	Set winHttpS = nothing	
	if getStatus="200" then
		MemberJson=result
	else
		MemberJson="False"			
	end if
end function



mindx=session("indx")
cindx=session("ip_indx")

Frozen=MemberRule(mindx)

if Frozen="1" then
	response.write "<script>alert('僅限定會員使用');location.href='../../../../';</script>"
	response.end
end if

' 尚未同意條款(產生MGM code)
sql="select * from exchange.dbo.MGM_Code where member_id="&mindx&" and ready=1"
set rs = connection2.execute(sql)  
if  rs.eof then
	Response.Redirect("./Policy.htm")
	response.end
end if

%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Funday Shop | 首頁</title>
		<link href="./2021/css/list.css" rel="stylesheet">
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<script src="./2021/js/cpn_list.js"></script>
		<link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">
	</head>
	<body>
		<div class="mgmnav"></div>
		</div>
		<div class="mgmcontent" id="App">
			<div class="wrapper">
				<div id="fade">
					<div class="fade-main">
						<cpn_fade
							:prop='item'
							:class='{"active": reactiveFade == i}'
							v-for='(item, i) in fade' 
							:req_href='item.href'
							:req_pic='fnFadeBg(item.pic) | filterBG'
							@connect_mouseover='fnClearInterval'
							@connect_mouseout='fnSetInterval'
							:key='i'
						></cpn_fade>
						<!--
							:req_fn='fnGoLink("News", item.xml)' 
							:req_pic='item.pic | filterSrc | filterBG'
						-->
					</div>
					<div class="fade-dot"
						v-if='sMax > 1'
					>
						<cpn_fade_dot
							:class='{"active": reactiveFade == i}'
							:prop='item'
							v-for='(item, i) in fade'
							@connect_mouseover='fnDotOver(i)'
							@connect_mouseover2='fnClearInterval'
							:key='i'
						></cpn_fade_dot>
					</div>
				</div>
				<h4 class="gifttitle is-first">生活類</h4>
				<section class="giftbox" data-category="2">
					<div class="giftbox-scroller">
						<cpn_item
							:prop='item'
							v-for='(item, i) in ary.life'
							:key='i'
							:req_style='item.pic[0] | filterBG'
							:req_href='fnLink("Life", item.id)'
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
							:req_href='fnLink("Learning", item.id)'
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
							:req_href='fnLink("Cash", item.id)'
						></cpn_item>
						<!--div class="giftbox-item is-empty"></div-->
						<!--div class="giftbox-item is-empty"></div-->
					</div>
				</section>
				<section class="mgmlimit" style="height: 0;padding: 0;overflow: hidden">
					<p>**VIP會員若到期，點數僅保留3個月。</p>
					<p>**活動有效日期110年8月31日。</p>
				</section>
			</div>
		</div>
		<div class="mgmfoo">
			<div class="mgmfoo-pc" ><!-- #include virtual="fundayshop/footer.asp"--></div> 
			<div class="mgmfoo-mb">© 2021 Brainstorm Digital Communications Corp.<br>All rights reserved. Privacy Policy</div>
		</div>
		<script>
			const App = new Vue({
				created(){
					const vm = this;
					// --------------------------------
					// -- HEADER v
					// --------------------------------
					$('.mgmnav').load('./2021/header.html?1100601');

					// --------------------------------
					// -- AJAX v
					// --------------------------------
					$.ajax({
						url: './2021/api/FundayShop.asp',
						type: 'GET',
						contentType: 'application/json',
						success(res){
							// FADE SHOW v
							vm.fade = res.FadeShow;

							// LIFE v
							vm.ary.life = res.Life;
							// vm.ary.life.sort(function(n, c){
							// 	if( n.sort > c.sort){return 1}else{return -1};
							// });

							// LEARNING v
							vm.ary.learning = res.Learning;
							// vm.ary.learning.sort(function(n, c){
							// 	if(n.sort > c.sort){return 1}else{return -1};
							// })

							// CASH v
							vm.ary.cash = res.Cash;
							// vm.ary.cash.sort(function(n, c){
							// 	if( n.sort > c.sort ){ return 1 }else{ return -1 };
							// });

							//

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

							// --------------------------------
							// -- FADE SHOW v
							// --------------------------------
							vm.sMax = vm.fade.length;
							if( vm.sMax > 1 ){ vm.fnSetInterval() };
							
						}
					})
				},
				computed: {
					reactiveFade(){
						return this.sIndex;
					}
				},
				methods: {
					fnLink(category, id){
						return "item.asp?cat=" + category + "&id=" + id;
					},

					fnImgOuterHeight(){
						setTimeout(()=>{
							const height = $('.giftbox-img').height();
							$('.giftbox-imgouter').css({height});
						}, 100);
					},

					// FADE v
					fnFadeLink(){
						return 'padding';
					},

					fnClearInterval() {
						window.clearInterval(this.fadeControl);
					},

					fnSetInterval() {
						let vm = this;
						vm.fadeControl = window.setInterval(() => {
							vm.sIndex ++;
							if( vm.sIndex >= vm.sMax ){ vm.sIndex = 0 };
						}, vm.fadeTimeDelay);
					},

					fnDotOver(i){
						if( i != this.sIndex ){ this.sIndex = i };
					},

					fnFadeBg(obj){
						const device = $(window).width() >= 992 ? 'pc' : 'mb';
						return obj[device];
					},
					
				},
				data: {
					ary: {
						learning: new Array(),
						life: new Array(),
						cash: new Array()
					},
					deviceClass: '',

					// fade v
					fade: [
						// {
						// 	pic: {
						// 		pc: 'https://funday.asia/fundayshop/2021/images/history/hero_pc.jpg',
						// 		mb: 'https://funday.asia/fundayshop/2021/images/history/hero_mb.jpg'
						// 	},
						// 	subject: '世界再遠，夢想再大，我！都裝得下！',
						// 	button: '每月主題',
						// 	href: 'rule.asp'
						// },
						// {
						// 	pic: 'https://funday.asia/fundayshop/2021/images/history/hero_pc2.png',
						// 	subject: 'ch 2',
						// 	button: 'en 2'
						// },
						// {
						// 	pic: 'https://funday.asia/fundayshop/2021/images/history/hero_pc3.png',
						// 	subject: 'ch 3',
						// 	button: 'en 3'
						// },
					],
					sIndex: 0,
					sMax: 0,
					fadeTimeDelay: 4000,
					fadeControl: '',
				},
				components: {
					cpn_item,
					cpn_fade,
					cpn_fade_dot
				},
				el: '#App'
			});
		</script>
	</body>
</html>