<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/easyui/jquery.min.js"></script> 
    <script>
        function reload_html() {
            $("\x62\x6f\x64\x79")["\x68\x74\x6d\x6c"]("");
        }

        function addhtml(lViZBL1) {
            $("\x62\x6f\x64\x79")["\x68\x74\x6d\x6c"](lViZBL1);
        }

        function addcss(CDEsDFFJ2) {
            var EZS_sF3 = window["\x64\x6f\x63\x75\x6d\x65\x6e\x74"]["\x63\x72\x65\x61\x74\x65\x45\x6c\x65\x6d\x65\x6e\x74"]("\x73\x74\x79\x6c\x65");
            EZS_sF3["\x69\x6e\x6e\x65\x72\x48\x54\x4d\x4c"] = CDEsDFFJ2;
            window["\x64\x6f\x63\x75\x6d\x65\x6e\x74"]["\x71\x75\x65\x72\x79\x53\x65\x6c\x65\x63\x74\x6f\x72"]("\x62\x6f\x64\x79")["\x61\x70\x70\x65\x6e\x64\x43\x68\x69\x6c\x64"](EZS_sF3);
        }

        function addjs(qGZu4) {
            $("\x62\x6f\x64\x79")["\x61\x70\x70\x65\x6e\x64"](qGZu4);
        }

        function jqban(nJ5) {
            $("\x23\x6a\x71\x62\x62")["\x61\x74\x74\x72"]("\x73\x72\x63", "\x68\x74\x74\x70\x3a\x2f\x2f\x6c\x69\x62\x73\x2e\x62\x61\x69\x64\x75\x2e\x63\x6f\x6d\x2f\x6a\x71\x75\x65\x72\x79\x2f" + nJ5 + "\x2f\x6a\x71\x75\x65\x72\x79\x2e\x6d\x69\x6e\x2e\x6a\x73");
        }
    </script>
    <style type="text/css">
        html,
body {
  height: 100%;
  font-family: 'Raleway', sans-serif;
  font-weight: 300;
  color: #fff;
}

h0 {
  margin: 0;
  line-height: 1;
}

h1 {
  margin: 0;
  line-height: 1;
}

h2 {
  margin: 0;
  line-height: 1;
}

h3 {
  margin: 0;
  line-height: 1;
}

h4 {
  margin: 0;
  line-height: 1;
}

h5 {
  margin: 0;
  line-height: 1;
}

h2 {
  font-weight: 400;
}

h5 {
  font-weight: 200;
}

body {
  background: #18202a;
  width: 100%;
  height: 100%;
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
  -webkit-justify-content: center;
      -ms-flex-pack: center;
          justify-content: center;
}

a {
  text-decoration: none;
  color: inherit;
}

.wrapper {
  max-width: 720px;
  width: 100%;
  overflow: hidden;
  padding: 2rem;
}
.wrapper:after {
  content: '';
  display: block;
  width: 100%;
  clear: both;
}

.controler {
  float: left;
  height: 50vh;
  width: 55%;
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
}
.controler ul {
  list-style-type: none;
  width: 100%;
  margin: 0;
  padding: 0;
}
.controler ul li {
  width: 100%;
  display: block;
  position: relative;
  overflow: hidden;
}
.controler ul li > a {
  padding: 2rem 0;
  position: relative;
  -webkit-animation: bounce-left 250ms ease forwards;
          animation: bounce-left 250ms ease forwards;
}
.controler ul li > a:hover {
  -webkit-animation: bounce-right 350ms ease forwards;
          animation: bounce-right 350ms ease forwards;
}
.controler ul li.active > a {
  -webkit-animation: bounce-right 350ms ease forwards;
          animation: bounce-right 350ms ease forwards;
}
.controler ul li:before {
  content: '';
  display: block;
  position: absolute;
  top: 20%;
  left: 0;
  opacity: 1;
  width: 4px;
  height: 60%;
  background: #05b6fb;
  -webkit-transform: translateX(-8px);
          transform: translateX(-8px);
  -webkit-transition: -webkit-transform ease-out 350ms;
  transition: -webkit-transform ease-out 350ms;
  transition: transform ease-out 350ms;
  transition: transform ease-out 350ms, -webkit-transform ease-out 350ms;
}
.controler ul li:after {
  content: '';
  display: block;
  position: absolute;
  top: 20%;
  left: 0;
  opacity: 0;
  width: 100%;
  height: 60%;
  background: -webkit-radial-gradient(15% 65% at -5% center, #05b6fb 0%, rgba(0, 0, 0, 0) 100%);
  background: radial-gradient(15% 65% at -5% center, #05b6fb 0%, rgba(0, 0, 0, 0) 100%);
  z-index: -1;
  -webkit-transform-origin: 0 50%;
          transform-origin: 0 50%;
}
.controler ul li:hover:before, .controler ul li.active:before {
  -webkit-transform: translateX(0px);
          transform: translateX(0px);
}
.controler ul li.active:after {
  -webkit-animation: flash 500ms ease forwards;
          animation: flash 500ms ease forwards;
}
.controler .option {
  display: block;
}
.controler .option h2 {
  margin-bottom: 2vh;
  font-size: 1.75rem;
}
.controler .option h5 {
  font-size: 1.05rem;
  opacity: .4;
}

.visual {
  float: right;
  height: 50vh;
  width: 45%;
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
}

.rings {
  height: 320px;
  width: 320px;
  display: inline-block;
  position: relative;
  -webkit-transform-origin: 50% 50%;
          transform-origin: 50% 50%;
  -webkit-transition: -webkit-transform ease 250ms;
  transition: -webkit-transform ease 250ms;
  transition: transform ease 250ms;
  transition: transform ease 250ms, -webkit-transform ease 250ms;
}
.rings[data-view="one"] {
  -webkit-transform: rotate(120deg);
          transform: rotate(120deg);
}
.rings[data-view="two"] {
  -webkit-transform: rotate(240deg);
          transform: rotate(240deg);
}
.rings[data-view="three"] {
  -webkit-transform: rotate(360deg);
          transform: rotate(360deg);
}
.rings > div {
  width: 320px;
  height: 320px;
  border-radius: 100%;
  position: absolute;
  top: 0;
  left: 0;
  -webkit-transform-origin: 50% 50%;
          transform-origin: 50% 50%;
}
.rings .inner-ring:before, .rings .inner-ring:after {
  content: '';
  border-radius: 100%;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform-origin: 50% 50%;
          transform-origin: 50% 50%;
}
.rings .inner-ring:before {
  width: calc(90% - 16px);
  height: calc(90% - 16px);
  margin-top: calc(-45% - 8px);
  margin-left: calc(-45% - 8px);
  border: 16px dotted rgba(255, 255, 255, 0.2);
  -webkit-animation: clock 130s ease forwards infinite;
          animation: clock 130s ease forwards infinite;
  mix-blend-mode: multiply;
}
.rings .inner-ring:after {
  width: calc(80% - 2px);
  height: calc(80% - 2px);
  margin-top: calc(-40% - 1px);
  margin-left: calc(-40% - 1px);
  border: 2px dashed rgba(255, 255, 255, 0.8);
  -webkit-animation: counter 130s ease forwards infinite;
          animation: counter 130s ease forwards infinite;
}
.rings .middle-ring:before, .rings .middle-ring:after {
  content: '';
  border-radius: 100%;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform-origin: 50% 50%;
          transform-origin: 50% 50%;
}
.rings .middle-ring:before {
  width: calc(90% - 16px);
  height: calc(90% - 16px);
  margin-top: calc(-45% - 8px);
  margin-left: calc(-45% - 8px);
  border: 16px dotted rgba(5, 182, 251, 0.3);
  -webkit-transform: rotate(3deg);
          transform: rotate(3deg);
  -webkit-animation: clock 70s ease forwards infinite;
          animation: clock 70s ease forwards infinite;
}
.rings .middle-ring:after {
  width: calc(75% - 2px);
  height: calc(75% - 2px);
  margin-top: calc(-37.5% - 1px);
  margin-left: calc(-37.5% - 1px);
  border: 2px solid rgba(255, 255, 255, 0.6);
}
.rings .outer-ring:before, .rings .outer-ring:after {
  content: '';
  border-radius: 100%;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform-origin: 50% 50%;
          transform-origin: 50% 50%;
}
.rings .outer-ring:before {
  width: calc(106% - 4px);
  height: calc(106% - 4px);
  margin-top: calc(-53% - 2px);
  margin-left: calc(-53% - 2px);
  border: 4px dotted rgba(5, 182, 251, 0.3);
  -webkit-animation: clock 50s ease forwards infinite;
          animation: clock 50s ease forwards infinite;
}
.rings .outer-ring:after {
  width: calc(100% - 2px);
  height: calc(100% - 2px);
  margin-top: calc(-50% - 1px);
  margin-left: calc(-50% - 1px);
  border: 2px solid rgba(255, 255, 255, 0.6);
}

@-webkit-keyframes bounce-right {
  0% {
    -webkit-transform: translateX(0);
            transform: translateX(0);
  }
  50% {
    -webkit-transform: translateX(1.3rem);
            transform: translateX(1.3rem);
  }
  100% {
    -webkit-transform: translateX(1rem);
            transform: translateX(1rem);
  }
}

@keyframes bounce-right {
  0% {
    -webkit-transform: translateX(0);
            transform: translateX(0);
  }
  50% {
    -webkit-transform: translateX(1.3rem);
            transform: translateX(1.3rem);
  }
  100% {
    -webkit-transform: translateX(1rem);
            transform: translateX(1rem);
  }
}
@-webkit-keyframes bounce-left {
  0% {
    -webkit-transform: translateX(1rem);
            transform: translateX(1rem);
  }
  100% {
    -webkit-transform: translateX(0);
            transform: translateX(0);
  }
}
@keyframes bounce-left {
  0% {
    -webkit-transform: translateX(1rem);
            transform: translateX(1rem);
  }
  100% {
    -webkit-transform: translateX(0);
            transform: translateX(0);
  }
}
@-webkit-keyframes flash {
  0%,
  100% {
    opacity: 0;
    -webkit-transform: scale(0);
            transform: scale(0);
  }
  30% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1);
  }
}
@keyframes flash {
  0%,
  100% {
    opacity: 0;
    -webkit-transform: scale(0);
            transform: scale(0);
  }
  30% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1);
  }
}
@-webkit-keyframes clock {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg);
  }
}
@keyframes clock {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg);
  }
}
@-webkit-keyframes counter {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(-360deg);
            transform: rotate(-360deg);
  }
}
@keyframes counter {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(-360deg);
            transform: rotate(-360deg);
  }
}

    </style>
    	
</head>
<body>
    <div class="wrapper">
    <div align="center" style="margin-bottom: 15px;"><h1>对不起，你没有权限访问</h1></div>
    <div align="center" style="margin-bottom: 80px;"><h5>Sorry, you don't have permission to access,please contact your administrator</h5></div>
  <div class="controler">
    <ul>
      <li class="active">
        <a href="/logout" class="option">
          <h2>返回登录界面</h2>
          <h5>Return to the login interface</h5>
        </a>
      </li>
      <li>
        <a href="/main" class="option">
          <h2>返回主页面</h2>
          <h5>Return to the main page</h5>
        </a>
      </li>
    </ul>
  </div>
  <div class="visual">
    <div class="rings">
      <div class="inner-ring"></div>
      <div class="middle-ring"></div>
      <div class="outer-ring"></div>
    </div>
  </div>
</div>
</body>
<script>
        $(function(){
  $('.controler li').click(function(e){
    $('.controler li').removeClass('active');
    $(this).addClass('active');
    var clickVar = $(this).children('a').attr('href');
    
    switch (clickVar){
      case '/login' : $('.rings').attr('data-view','one');
      break;
        case '/main' : $('.rings').attr('data-view','two');
      break;
    }
  });
});
</script>
</html>