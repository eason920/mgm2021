<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>   
<!-- #include virtual="include/DBConnection.asp"--> 
<!--#include virtual="include/aspJSON1.17.asp"-->
<!-- #include virtual="fundayshop/api/function.asp"--> 
<%
response.Buffer = true
session.Codepage =65001
response.Charset = "utf-8"  


mindx=session("indx")
cindx=session("ip_indx")


mcoins=0

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


' 是否有推薦註冊者漏值
sql="select MML.member_id,mc2.code from exchange.dbo.MGM_member_List MML inner join exchange.dbo.MGM_Code mc2 on MML.ref_member_id =mc2.member_id where MML.ref_member_id='"&mindx&"' and MML.chk=1 and ( select mc.ref_id from exchange.dbo.member_coins mc where mc.rule_id=21 and mc.ref_id like '%'+CONVERT(varchar,MML.member_id) +'%' ) is null order by MML.indx desc"
set rs = connection2.execute(sql)
while not rs.eof 
	ordercode="21-"&mindx&"-"&rs("member_id")&"-"&rs("code")
	MGMCoins 21,ordercode
	rs.movenext
wend

'是否有達成文章漏值
sql="select a.ref_id,a.member_levels from company1.dbo.score a where a.member_id="&mindx&"  and a.listen>=80 and a.word>=80 and a.reading>=80  and datediff(d,'2021/4/20',a.cdate)>=0 and (select ref_id from exchange.dbo.member_coins b where b.member_id=a.member_id and b.rule_id=12 and b.ref_id = '12-'+CONVERT(varchar,a.member_id) +'-'+CONVERT(varchar,a.ref_id)+'-'+CONVERT(varchar,a.member_levels) ) is null"
recordset1.open sql,connection2,1,3 
while not recordset1.eof 
	ordercode="12-"&mindx&"-"&recordset1("ref_id")&"-"&recordset1("member_levels")
	MGMCoins 12,ordercode
	recordset1.movenext
wend
recordset1.close

%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Funday Shop | 集點介紹</title>
		<link href="./2021/css/rule.css" rel="stylesheet">
		<link href="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.css" rel="stylesheet">
		<script src="./2021/assets/plugins/jquery/jquery-1.12.4-min.js"></script>
		<script src="./2021/assets/plugins/vue/vue2.6.12.js"></script>
		<script src="./2021/assets/plugins/perfect-scrollbar-master/perfect-scrollbar.min.js"></script>
		<script src="./2021/js/cpn_rule.js?<%=time%>"></script>
		<!--script src="./js/Ma.js"></script-->
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
					<!--img class="logobox-what" src="./2021/images/what.png"-->
					<div class="logobox-what">Fun Coin 說明</div>
				</div>
				<div class="mainbox">
					<div class="leftbox">
						<div class="tabbox">
							<button class="tabbox-item" @click='fnTabboxItem("list", 0)' data-tab="list">
								<h3>點數紀錄</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("recommend", 1)' data-tab="recommend">
								<h3>推薦獎勵</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("learning", 2)' data-tab="learning">
								<h3>學習獎勵</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("campaign", 3)' data-tab="campaign">
								<h3>活動獎勵</h3>
							</button>
							<button class="tabbox-item" @click='fnTabboxItem("rule", 4)' data-tab="rule">
								<h3>兌換規則</h3>
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
											<div class="for-pc">Fun Coin</div>
											<div class="for-mb">F Coin</div>
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
							<div class="contentbox-item" data-tab="recommend">
								<div class="contentbox-tip is-head">
									<ol>
										<li>項目</li>
									</ol>
									<ol>
										<li>完成日期</li>
									</ol>
									<ol>
										<li> 
											<div class="for-pc">Fun Coin</div>
											<div class="for-mb">F Coin</div>
										</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s1">
									<div class="box">
										<cpn_list
											:prop='item'
											v-for='(item, i) in ary.recommend'
											:key='i'
										></cpn_list>
									</div>
								</div>
							</div>
							<div class="contentbox-item" data-tab="learning">
								<div class="contentbox-tip is-head">
									<ol>
										<li>項目</li>
									</ol>
									<ol>
										<li>完成日期</li>
									</ol>
									<ol>
										<li> 
											<div class="for-pc">Fun Coin</div>
											<div class="for-mb">F Coin</div>
										</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s2">
									<div class="box">
										<cpn_list
											:prop='item'
											v-for='(item, i) in ary.learning'
											:key='i'
										></cpn_list>
									</div>
								</div>
							</div>
							<div class="contentbox-item" data-tab="campaign">
								<div class="contentbox-tip is-head">
									<ol>
										<li>項目</li>
									</ol>
									<ol>
										<li>完成日期</li>
									</ol>
									<ol>
										<li> 
											<div class="for-pc">Fun Coin</div>
											<div class="for-mb">F Coin</div>
										</li>
									</ol>
								</div>
								<div class="contentbox-scroller is-s3">
									<div class="box">
										<cpn_list
											:prop='item'
											v-for='(item, i) in ary.campaign'
											:key='i'
										></cpn_list>
									</div>
								</div>
							</div>
							<div class="contentbox-item" data-tab="rule">
								<div class="contentbox-scroller is-s4">
									<div class="box">
										<cpn_2
											:prop='item'
											v-for='(item, i) in ary.rule'
											:req_i='i + 1'
											:key='i'
										></cpn_2>
									</div>
								</div>
							</div>
							<div class="contentbox-total">
								<h2>目前累積<span id="countToSum"></span>Fun Coin</h2><a class="contentbox-convert" href="list.asp">商品兌換</a>
							</div>
						</div>
					</div>
					<div class="coinbox-lb">
						<div class="coinbox-close">╳</div>
						<div class="coinbox"><img class="img-responsive-title" src="./2021/images/coin-title.png" alt=""><img class="img-responsive-coin-a" src="./2021/images/coin-1.png" alt=""><img class="img-responsive-text" src="./2021/images/coin-text.png" alt="">
							<h3>FUN Coin可兌換FUNDAY SHOP<br>裡的<span>各種商品</span>。</h3>
							<h3>FUN Coin累積達到1,500點時，<br>始可<span>兌換現金</span>。</h3>
							<div class="p">*申請兌換現金時，須提供個人資料與<br>金融帳戶資訊以利報稅與匯款。</div>
							<div class="code-button" 
								@click="fnMA"
								v-if="reactiveMgmCode.length < 2"
							>建立專屬推薦序號</div>
							<div class="code-button-have"
								v-else
							>
								複製您的專屬連結
								<input type="text" :value='reactiveMgmCode' class='copy-source' style='display: none' readonly/>
							</div>
							<a href="list.asp" class="code-button"><img class="is-go" src="./2021/images/btn.png"/></a>
							<img class="img-responsive-coin-b" src="./2021/images/coin-2.png" alt="">
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- #include virtual="fundayshop/footer.asp"-->
		
		<div class="copy-lb" style="display: none;">推薦序號己複製!</div>
		<script>
			const App = new Vue({
				created(){
					$('.mgmnav').load('./2021/header.html?1100601');
					//
					const vm = this;
					$.ajax({
						type: 'GET',
						url: './2021/api/FcoinList.asp',
						contentType: 'application/json',
						success(res){
							console.log('res ', res);
							// (tab 1~4) v
							vm.ary.list = res.List;
							vm.ary.learning = res.List.filter( item => item.type == 'Learning' );
							vm.ary.recommend = res.List.filter( item => item.type == 'Recommend');
							vm.ary.campaign = res.List.filter( item => item.type == 'Campaign');
							// (tab 5)RULE v 
							// 推薦 recommend
							res.RecommendRule.forEach(function(item){
								vm.ary.rule.push(item);
							});
							// 學習 learning
							res.LearningRule.forEach(function(item){
								vm.ary.rule.push(item);
							});
							// 活動 campaign
							res.CampaignRule.forEach(function(item){
								vm.ary.rule.push(item);
							});

							// --------------------------------
							// -- MGM CODE v
							// --------------------------------
							vm.mgmCode = res.Mgm_code;

							// --------------------------------
							// -- POINT ANIMATE v
							// --------------------------------
							vm.fnCountToSum( $('#countToSum') , res.FunCoin, '', 2000);
							
							// --------------------------------
							// -- MOBILE OPEN FUN-COIN LB v
							// --------------------------------
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

								$('.coinbox-close').click(function(){
									$('.mgmcontent').removeClass('is-open');
								});
							};

							// --------------------------------
							// -- DEFAULT CLCIK v
							// --------------------------------
							$('.tabbox-item:eq(4)').click();
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
						const left = index * 20 + '%';
						let key = '';

						//
						switch(index){
							case 1: key = "s1";break;
							case 2: key = "s2";break;
							case 3: key = "s3";break;
							case 4: key = 's4';break;
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

					fnMA(){
						const vm = this;
						$.get("../../../Fundayshop/api/data.asp?target=MGMcode", function(result){
							vm.mgmCode = result;
						});
					}
				},
				data: {
					data: new Object(),
					ww: '',
					ary: {
						list: new Array(),
						learning: new Array(),
						recommend: new Array(),
						campaign: new Array(),
						rule: new Array()
					},
					plugins: {
						s1: false,
						s2: false,
						s3: false
					},
					mgmCode: ''
				},
				computed: {
					reactiveMgmCode(){
						return this.mgmCode;
					},
				},
				el: '#app',
				components: {
					cpn_list,
					cpn_2
				}
			});

			Vue.config.devtools = true;

			// --------------------------------
			// --------------------------------
			// copy
			window.Clipboard = (function (window, document, navigator) {
				var textArea,
					copy;

				function isIOS() {
					return navigator.userAgent.match(/ipad|iphone/i);
				}

				function createTextArea(text) {
					textArea = document.createElement('textArea');
					textArea.value = text;
					document.body.appendChild(textArea);
				}

				function selectText() {
					var range,
						selection;

					if (isIOS()) {
						range = document.createRange();
						range.selectNodeContents(textArea);
						selection = window.getSelection();
						selection.removeAllRanges();
						selection.addRange(range);
						textArea.setSelectionRange(0, 999999);
					} else {
						textArea.select();
					}
				}

				function copyToClipboard() {
					document.execCommand("Copy");
					document.body.removeChild(textArea);
				}

				copy = function (text) {
					createTextArea(text);
					selectText();
					copyToClipboard();
				};

				return {
					copy: copy
				};
			})(window, document, navigator);
			
			$('body').on('click', '.code-button-have', function(){
				var value = $('.copy-source').val();
				window.Clipboard.copy(value);
				 
				$('.copy-lb').fadeIn(200)
				setTimeout(function(){
					$('.copy-lb').fadeOut();
				}, 2000);

			});
		</script>
	</body>
</html>