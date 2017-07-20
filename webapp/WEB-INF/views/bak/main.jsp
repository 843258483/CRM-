<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">

	$(function() {
		
		
		$.messager.show({
		    title:'提示窗口',
		    msg:'欢迎登陆CRM用户管理系统',
		    showType:'show'
		});
	       
	
        

		// 		url string 检索远程数据的URL地址。 发出ajax请求获取标准格式json数据
		$("#tree").tree({
			url : "/tree.json",
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

	});
</script>
 <link rel="stylesheet" href="/resource/main/css/style.css"/>

    <!--Luara样式文件-->
    <!--渐隐样式-->
    <link rel="stylesheet" href="/resource/main/css/luara.css"/>
    <!--左滑样式-->
    <link rel="stylesheet" href="/resource/main/css/luara.left.css"/>
    上滑样式
    <link rel="stylesheet" href="/resource/main/css/luara.top.css"/>
     <script src="/resource/main/js/jquery-1.8.3.min.js"></script>
    Luara js文件
    <script src="/resource/main/js/jquery.luara.0.0.1.min.js"></script>
     <script>
    $(function(){
        <!--调用Luara示例-->
        $(".example2").luara({width:"100%",height:"100%",interval:2000,selected:"seleted"});

    });
	
    
    </script>
<title>CRM后台主页</title>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height: 80px">
	  <div style="float: left;">
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
    	 <img src="/resource/image/top1.gif" width="125px" height="80px"/>
 
	  </div>
	  <div style="float: right;">
    	  欢迎你：${employeeInSession.realName}	  
    	 <a href="/logout" class="easyui-linkbutton c8" iconCls="icon-undo">注销</a>
	  </div>
	</div>
	<div data-options="region:'west',split:true" title="West" style="width: 150px;">
		西，菜单
		<ul id="tree"></ul>
	</div>
	<div data-options="region:'center'">
		<div id="tt" class="easyui-tabs" fit="true">
    <div class="example2" >
        <ul>
            <li><img src="/resource/main/images/11.jpg" alt="1" width="100%" heigit="100%"/></li>
            <li><img src="/resource/main/images/12.jpg" alt="2"width="100%" heigit="100%"/></li>
            <li><img src="/resource/main/images/13.jpg" alt="3"width="100%" heigit="100%"/></li>
            <li><img src="/resource/main/images/10.jpg" alt="4" width="100%" heigit="100%"/></li>
        </ul>
        <ol>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ol>
    </div>
    <!--Luara图片切换骨架end-->
  

  
</div>
		</div>
	</div>
</body>
</html>