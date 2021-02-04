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
    <script src="./2021/js/page.js"></script>
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
    <div class="mgmcontent">
      <div class="wrapper">
        <h4 class="gifttitle is-first">學習類</h4>
        <section class="giftbox" data-category="1">
          <div class="giftbox-scroller">
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <!--div class="giftbox-item is-empty"></div-->
          </div>
        </section>
        <h4 class="gifttitle">生活類</h4>
        <section class="giftbox" data-category="2">
          <div class="giftbox-scroller">
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
          </div>
        </section>
        <h4 class="gifttitle">現金類</h4>
        <section class="giftbox" data-category="3">
          <div class="giftbox-scroller">
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
            <div class="giftbox-item">
              <div class="giftbox-imgouter">
                <div class="giftbox-img" style="background-image: url(./2021/images/gifts/1.jpg)"><img src="./2021/images/empty_item.png"></div>
              </div>
              <div class="giftbox-info">
                <div class="giftbox-title">FUNDAY線上數位訂閱-3個月線上數位訂閱-3個月線上數位訂閱線上數位訂閱</div>
                <div class="giftbox-pricebox">
                  <div class="giftbox-price"> <img class="giftbox-icon" src="./2021/images/icon.svg">3050 點</div>
                  <button class="giftbox-btn">兌換</button>
                </div>
              </div>
            </div>
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
    <div class="mgmlb-scroller">
      <div class="mgmlb-box">
        <div class="mgmlb-close">╳</div>
        <div class="mgmlb-pic">
          <div class="lbpic-kv" style="background-image:url(./2021/images/gifts/l.jpg)"><img src="./2021/images/empty_lb.png"></div>
          <div class="lbpic-box">
            <div class="lbpic-item active" style="background-image:url(./2021/images/gifts/l.jpg)"><img src="./2021/images/empty_lb.png"></div>
            <div class="lbpic-item" style="background-image:url(./2021/images/gifts/l.jpg)"><img src="./2021/images/empty_lb.png"></div>
            <div class="lbpic-item" style="background-image:url(./2021/images/gifts/l.jpg)"><img src="./2021/images/empty_lb.png"></div>
            <div class="lbpic-item" style="background-image:url(./2021/images/gifts/l.jpg)"><img src="./2021/images/empty_lb.png"></div>
          </div>
        </div>
        <div class="mgmlb-info">
          <div class="lbproduct is-lbblock">
            <div class="lbproduct-title">FUNDAY運動毛巾FUNDAY運動毛巾FUNDAY運動毛巾FUNDAY運動毛巾FUNDAY運動毛巾FUNDAY運動毛巾</div>
            <div class="lbproduct-pricebox">
              <div class="lbproduct-price"><img class="giftbox-icon" src="./2021/images/icon.svg"><span class="lbproduct-prefix">兌換點數：</span><span>30,000</span>點</div>
            </div>
          </div>
          <div class="lbtalk is-lbblock">
            <div class="lbtalk-item">規格：有機原棉織造 無化學添加  柔細舒適  吸水性佳 有機原棉織造 無化學添加  柔細舒適  吸水性佳</div>
            <div class="lbtalk-item">材質：100% 有機棉 台灣織造</div>
            <div class="lbtalk-item">尺寸：76cm*148cm</div>
          </div>
          <div class="lbinfo is-lbblock">
            <div class="lbinfo-tip">請正確填寫以下收件人相關資訊</div>
            <div class="lbinfo-iptbox">
              <div class="lbinfo-name">收件人姓名</div>
              <input class="lbinfo-ipt" type="text" placeholder="*必填">
            </div>
            <div class="lbinfo-iptbox">
              <div class="lbinfo-name">收件人電話</div>
              <input class="lbinfo-ipt" type="text" placeholder="*必填">
            </div>
            <div class="lbinfo-iptbox">
              <div class="lbinfo-name">郵遞區號及地址</div>
              <input class="lbinfo-ipt" type="text" placeholder="*必填">
            </div>
          </div>
          <button class="lbbtn">立即兌換</button>
        </div>
      </div>
    </div>
  </body>
</html>