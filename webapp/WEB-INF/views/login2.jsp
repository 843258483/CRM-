<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CRM登录页面</title>
<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/assets/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/assets/css/supersized.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/assets/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/connection/css/lrtk.css">


<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!-- 		[if lt IE 9]> -->
<!--             <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script> -->
<!--         <![endif] -->
<style>
body {
	height: 100%;
	background: #494A5F;
	overflow: hidden;
}
</style>

<%@include file="/WEB-INF/views/common.jsp"%>
<!-- <script -->
<%-- 	src="${pageContext.request.contextPath}/resource/connection/js/jquery-1.8.3.min.js"></script> --%>
<script
	src="${pageContext.request.contextPath}/resource/assets/js/supersized.3.2.7.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/assets/js/supersized-init.js"></script>
<!-- <script -->
<%-- 	src="${pageContext.request.contextPath}/resource/assets/js/scripts.js"></script> --%>
<script type="text/javascript">
	if (top != window) {
		top.location.href = window.location.href;
	}
	//键盘回车登录
	$(document).on("keydown", function(event) {
		console.debug(event.keyCode);
		if (event.keyCode == 13) {
			submitForm();
		}
	});
	function submitForm() {
		$('#loginForm').form('submit',{
							url : "/login",
							success : function(result) {
								try {
									var result = JSON.parse(result);
									if (result.success) {
										location.href = "/main";
									} else {
									//后台保存失败
									$.messager.show({
									title : '错误提示',
									msg : "<font color='red'>"
									+ result.message
									+ "</font>"
								});
							}
						} catch (e) {
							$.messager
						.show({
							title : '错误提示',
						msg : "<font color='red'>登录失败&服务器返回的不是json字符串</font>"
					});
				}
			}
		});
	}
</script>
<script>
   $(function() {
	    $(".btn_top").hide();
		$(".btn_top").live("click",function(){
			$('html, body').animate({scrollTop: 0},300);return false;
		})
		$(window).bind('scroll resize',function(){
			if($(window).scrollTop()<=300){
				$(".btn_top").hide();
			}else{
				$(".btn_top").show();
			}
		})
   })
</script>
</head>
<body>
		<div class="page-container">
            <form id="loginForm" action="" method="post">
            <dl class="admin_login">
            	<dt>
				<strong>CRM管理系统</strong> <em></em>
				</dt>
                <input type="text" name="username" class="login_txtbx" placeholder="Username">
                <input type="password" name="password" class="login_txtbx" placeholder="Password">
<!--                 <input type="button" value="登录" class="submit_btn" onclick="submitForm();"/> -->
				<button type="button" onclick="submitForm();">登录</button>
                <div class="error"><span>+<font color="red">用户名或密码错误</font></span></div>
           	</dl>
            </form>
            <div class="izl-rmenu">
    <a class="consult" target="_blank"><div class="phone" style="display:none;">15883871056</div></a>    
    <a class="cart"><div class="pic"></div></a>   
    <a href="javascript:void(0)" class="btn_top" style="display: block;"></a>
</div>
<a target="_blank"  href="http://wpa.qq.com/msgrd?v=3&uin=364951357&site=qq&menu=yes" id="udesk-feedback-tab" class="udesk-feedback-tab-left" style="display: block; background-color: black;"></a>
            </div>
</body>
</html>

