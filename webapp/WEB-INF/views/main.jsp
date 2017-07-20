<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resource/global/planetarium.css" rel='stylesheet' type='text/css'>
<!-- <link rel="stylesheet" href="/resource/index/css/normalize.css"> -->

<!-- <link rel="stylesheet" href="/resource/index/css/styles.css" type="text/css" /> -->

<%@include file="/WEB-INF/views/common.jsp"%>
<!-- 	这个是global的注释掉,不然会和easyui冲突 -->
<!-- <script type="text/javascript" src="/resource/global/jquery-1.9.1.js"></script> -->
<script type="text/javascript" src="/resource/global/jquery.planetarium.js"></script>
    <script type="text/javascript">
//     主页动画效果
    $(document).ready(function(){
    	   $(".planet").planetarium({
    		  space: "html, body"
    		});
    		});
//  主页动画效果
    
    
    $(function(){
    // 添加单机右键弹出菜单的方法	
   	$(document).bind('contextmenu',function(e){
           e.preventDefault();
           $('#gg').menu('show', {
               left: e.pageX,
               top: e.pageY
           });
       });	
    	
//     $.messager.show({
//         title:'温馨提示',
//         msg:'<font color="#7FFFD4">尊敬的'+"${employeeInSession.realName}"+'欢迎登陆CRM用户管理系统</font>',
//         showType:'show'
//     });
    
//		url string 检索远程数据的URL地址。 发出ajax请求获取标准格式json数据
	$("#tree").tree({
		url :"/left",
		onClick : function(node) {
			console.debug(node);
			//先判断原来tabs里面有无当前tab，每次点击都创建一个tab
			//getTab which 获取指定选项卡面板，'which'参数可以是选项卡面板的标题或者索引。 
			var tab = $("#tt").tabs('getTab',node.text);
			if(tab){//已经创建了
				//select which 选择一个选项卡面板，'which'参数可以是选项卡面板的标题或者索引。 
				$("#tt").tabs('select',node.text);
			}else{
			//注意现在使用easyui版本1.5,
			//注意1.3.2版本(含)不能直接获取node.url 
				var url = node.url;
				if(url){
	         $('#tt').tabs('add',{
	             title: node.text,
	             iconCls:node.iconCls,
	             content: "<iframe frameborder='0' src='"+ url+ "' style='width:100%;height:99.1%'></iframe>",
	             closable: true
	         });			
					
				}
			}

		}

	});
    
    
    
    $("#mm1 > div").bind("click",function(){
    	//获取新样式名称
    	var themeName = $(this).data("theme")
    	console.debug(themeName)
		//修改主页面
		$("#themestyle").attr("href","${pageContext.request.contextPath}/resource/easyui/themes/"+themeName+"/easyui.css");
		//修改所有ifrom下面的主题
		$("iframe").each(function(i,iframeDom){
			$(iframeDom.contentDocument).find("#themestyle").attr("href","${pageContext.request.contextPath}/resource/easyui/themes/"+themeName+"/easyui.css");
		});
// 		4.
		window.Config={
				theme:themeName
		};
		$()
    	
    });
    
    ${pageContext.request.contextPath}
    });
	

	function menuHandler(item){
//		tabs none 返回所有选项卡面板。 
//		close which 关闭一个选项卡面板，'which'参数可以是选项卡面板的标题或者索引，以指定要关闭的面板。
//		关闭所有面板菜单的点击事件
		$("#closeAll").click(function() {
				var tabs = $("#tt").tabs("tabs");
				var length = tabs.length;
				for (var i = 0; i < length; i++) {
					$("#tt").tabs("close", 0);
				}
			});
}
    </script>
<title>CRM后台主页</title>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height: 100px" >
	  <div style="text-align:center;">
		<p style="width:100%; display:block; line-height:1.5em; overflow:visible; font-size:28px; text-shadow:#f3f3f3 1px 1px 0px, #b2b2b2 1px 2px 0;">C&nbsp;R&nbsp;M&nbsp;客&nbsp;户&nbsp;关&nbsp;系&nbsp;管&nbsp;理&nbsp;系&nbsp;统</p>
    
	  </div>
	  <div style="float: right;">
	 
    	 <div id="mml" style="position:absolute;right:20px;bottom:5px;">
    	  <div>
    	<font style="font-size:14px;color:#7FFFD4">欢迎你：${employeeInSession.realName}</font>	  
    	 <a href="/logout" class="easyui-linkbutton c8" iconCls="icon-undo">注销</a>
    	  </div>
    	 <a href="#" class="easyui-menubutton" data-options="menu:'#mm1'"><font color="#7FFFD4"><b>主题</b></font></a>
    	 </div>
			<div id="mm1" style="width: 60px;">
				<div data-theme="default">default</div>
				<div data-theme="gray">gray</div>
				<div data-theme="black">black</div>
				<div data-theme="green">green</div>
				<div data-theme="blue">blue</div>
				<div data-theme="orange">orange</div>
				<div data-theme="red">red</div>
				<div data-theme="ui-cupertino">ui-cupertino</div>
				<div data-theme="ui-dark-hive">ui-dark-hive</div>
				<div data-theme="ui-pepper-grinder">ui-pepper-grinder</div>
				<div data-theme="ui-sunny">ui-sunny</div>
			</div>
		</div>
	</div>
	<div data-options="region:'west',split:true" title="菜单" style="width: 150px;">
		<ul id="tree"></ul>
	</div>
	<div data-options="region:'center'"  >
		<div id="tt" class="easyui-tabs" fit="true" >
		<div title="主页">
<!-- 		<canvas class="canvas" width=400 height=300></canvas> -->
<!-- 地球主页调整展示位置 -->
<!-- 		<canvas class="canvas" fit="true"></canvas> -->
		<div class="help"></div> 

<!-- 		<div class="ui"> -->
<!-- 		  <input class="ui-input" type="text" /> -->
<!-- 		</div> -->
<!--     添加单机右键关闭所有菜单的方法 -->
    <div id="gg" class="easyui-menu" data-options="onClick:menuHandler" style="width:120px;">  
		    <div data-options="name:'new',iconCls:'icon-new'">新建</div>   
		    <div data-options="name:'open',iconCls:'icon-open'">打开</div>   
		    <div id="closeAll" data-options="name:'closeAll',iconCls:'icon-cancel'">关闭所有</div>   
		    <div data-options="name:'exit',iconCls:'icon-back'">退出</div>   
	</div>  
<!-- <div class="overlay"> -->
<!--   <div class="tabs"> -->
<!--     <div class="tabs-labels"><span class="tabs-label">制作团队</span><span class="tabs-label">系统简介</span></div> -->

<!--     <div class="tabs-panels"> -->
<!--       <ul class="tabs-panel commands"> -->
<!--         <li class="commands-item"><span class="commands-item-title">小组</span><span class="commands-item-info" data-demo="GROUPONE">GROUPONE</span></li> -->
<!--         <li class="commands-item"><span class="commands-item-title">组织机构模块</span> -->
<!-- 		<span class="commands-item-info" data-demo="李武">李武</span></li> -->
<!--         <li class="commands-item"><span class="commands-item-title">客户模块</span><span class="commands-item-info" data-demo="徐玉婷">徐玉婷</span></li> -->
<!--         <li class="commands-item"><span class="commands-item-title">权限模块</span><span class="commands-item-info" data-demo="蒋欢">蒋欢</span></li> -->
<!--         <li class="commands-item"><span class="commands-item-title">高级业务模块</span><span class="commands-item-info" data-demo="吴科">吴科</span></li> -->
<!-- 		<li class="commands-item"><span class="commands-item-title">基础数据模块</span><span class="commands-item-info" data-demo="肖建">肖建</span></li> -->
<!--       </ul> -->
<!--       <div class="tabs-panel ui-share"> -->
<!--         <div class="ui-share-content"> -->
<!--           <h1>CRM客户关系管理系统</h1> -->
<!--           <p>客户关系管理（CRM）是利用信息科学技术，实现市场营销、销售、服务等活动自动化，使企业能更高效地为客户提供满意、周到的服务，以提高客户满意度、忠诚度为目的的一种管理经营方式。客户关系管理既是一种管理理念，又是一种软件技术。以客户为中心的管理理念是CRM实施的基础。</p> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
<!-- </div> -->

<!--   <script src="/resource/index/js/index.js"></script> -->
<!--   </div> -->
<!-- 主页效果展示 -->
  <div class="wrapper">	
	<div style="text-align:center;" class="main">
		<div data-ptr-size="200x200" data-ptr-pattern="/resource/global/texture-saturn.jpg" data-ptr-ring="true" class="saturn planet"></div>
		<div data-ptr-autospin="3000ms" data-ptr-angle="20deg" data-ptr-glow="0 0 50px rgba(0,252,255,0.35), inset 33px 20px 50px rgba(0,0,0,0.5)" data-ptr-size="300x300" data-ptr-pattern="/resource/global/texture-earth.jpg" class="earth planet"></div>
		<div data-ptr-autospin="400ms" data-ptr-angle="40deg" data-ptr-glow="0 0 50px rgba(236,206,20,0.35), inset 33px 20px 50px rgba(0,0,0,0.5)" data-ptr-size="150x150" data-ptr-pattern="/resource/global/texture-jupiter.jpg" class="jupiter planet"></div>
	</div>
</div>
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';color:#ffffff">
<p><h2>第三组: 肖建 李武 吴科 徐玉婷 蒋欢</h2></p>
<p><h2>CRM项目演示</h2></p>
<p><h6>2017.1.20</h6></p>
<!-- 主页效果展示 -->

</div>



		</div>
		</div>
	</div>
</body>
</html>