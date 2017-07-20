<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/common.jsp"%>
<title>系统日志</title>

<script type="text/javascript">
	
	//页面加载之后才执行
	$(function() {
		 // 1、声明出页面需要使用的组件
		 var systemLogDatagrid,systemLogDialog,systemLogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		// 3、初始化组件，修改组件的值
		 var systemLogDatagrid = $('#systemLogDatagrid');
		 var systemLogDialog = $('#systemLogDialog');
		 var systemLogForm = $('#systemLogForm');
		// 4、创建一个"命令对象"
		var cmdObj = {
				addSystemLog:function(){
					console.debug("add");
					//弹出对话框
		            systemLogDialog.dialog('open').dialog('center').dialog('setTitle','新增页面');
					//清空表单中的数据
		            systemLogForm.form('clear');
		            //$("input[name=state]").prop("checked",true);
				},updateSystemLog:function(){
					console.debug("update");
					//选择表单中的某一行数据
		            var row = systemLogDatagrid.datagrid('getSelected');
		            if (!row){//如果未选中行，给出提示，并结束方法
		            	$.messager.alert('提示信息','请选择一条要修改的数据!','info');
		            	return;//结束方法
		            }
		          //弹出对话框
		          systemLogDialog.dialog('open').dialog('center').dialog('setTitle','修改页面');
		        	//清空表单中的数据
		          systemLogForm.form('clear');
		          //加载选中的行的数据，用于回显
		         // $("input[name=state]").prop();
		          systemLogForm.form('load',row);
		          //url = 'update_user.php?id='+row.id;
				},deleteSystemLog:function(){
					console.debug("delete");
					//选择表单中的某一行数据
		            var row = systemLogDatagrid.datagrid('getSelected');
		            if (!row){//如果未选中行，给出提示，并结束方法
		            	$.messager.alert('提示信息','请选择一条要删除的数据!','info');
		            	return;//结束方法
		            }
		            if (row){
		                $.messager.confirm('Confirm','确定要删除该条记录吗?',function(r){
		                   if(r){
		                     $.get('/systemLog/delete?id='+row.id,function(result){
		                     	if (result.success){//删除成功重新加载页面数据
		                     		$.messager.alert('提示信息','成功删除一条数据!','info');
		                    		systemLogDatagrid.datagrid('reload');
		                    		}else{
		                    			$.messager.alert('错误提示',result.message,'error');  
		                    		}
		                     });
		                  }
		              });
		            }
				},deleteAllSystemLog:function(){
					 $.messager.confirm('提示信息','确定要删除所有记录吗?',function(r){
						 $.get('/systemLog/deleteAll',function(result){
		                     	if (result.success){//删除成功重新加载页面数据
		                     		$.messager.alert('提示信息','成功删除数据!','info');
		                    		systemLogDatagrid.datagrid('reload');
		                    		}
						 });
					 });
					
				},saveSystemLog:function(){
					console.debug("save");
					 systemLogForm.form('submit',{
			                url: "/systemLog/save",
			                onSubmit: function(){//验证通过，则执行下面的代码
			                    return $(this).form('validate');
			                },
			                success: function(result){
			                    var result = JSON.parse(result);
			                    if (result.success){
			                    	$.messager.alert('提示信息','操作成功!','info');
			                    	//关闭对话框
			                        systemLogDialog.dialog('close');
			                    	//重新加载数据
			                        systemLogDatagrid.datagrid('reload');
			                    } else {
			                    	$.messager.alert('错误提示',result.message,'error');
			                        systemLogDialog.dialog('close');
			                        systemLogDatagrid.datagrid('reload');
			                    }
			                }
			            });
				},cancelSystemLog:function(){
					console.debug("cancel");
					systemLogDialog.dialog('close');
				},searchSystemLog:function(){
					console.debug("search");
					console.debug($("#searchSystemLogForm").serializeJSON());
					systemLogDatagrid.datagrid('load',$("#searchSystemLogForm").serializeJSON());
					console.debug($("#searchSystemLogForm").serializeJSON());
				},downLoadSystemLog:function(){
					console.debug("downLoad");
					 var url="/systemLog/download?"+$("#searchSystemLogForm").serialize();
			            //alert("导出此页数据...");
			            //$.messager.alert('提示',"为兼容低版本客户,导出的文件为2003版Excel文件.","info");
				 		 window.open(url);
				}
		}
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").click(function(){
			var cmd = $(this).data("cmd");
			if(cmd){
				//console.debug(cmd);
				cmdObj[cmd]();//调用方法
			}
		});
		
		//输入用户，传到后台的是用户的id的值
		$('#cc').combogrid({    
		    delay: 500,    
		    mode: 'remote',    
		    url: '/employee/json',    
		    idField: 'id',    
		    textField: 'username',    
		    columns: [[    
		        {field:'username',width:120,sortable:true}   
		    ]]    
		});  


	});
	//格式化显示用户名
	function opUserFormatter(value, row, index) {
		return value ? value.username: "";
	}
</script>
</head>
<body>
	<table id="systemLogDatagrid" title="系统日志" class="easyui-datagrid"
		fit=true url="/systemLog/json" toolbar="#systemLogToolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<!-- <th field="id" width="50">id编号</th> -->
				<th field="opUser" formatter="opUserFormatter" width="20">用户</th>
				<th field="opTime" width="50">操作时间</th>
				<th field="opIp" width="50">登陆Ip</th>
				<th field="function" width="100" >操作类型</th>
				<!-- <th field="params" width="50" >params</th> -->
			</tr>
		</thead>
	</table>

	<div id="systemLogToolbar">
		<!-- <a data-cmd="addSystemLog" 
			href="javascript:void(0)" class="easyui-linkbutton c1"
			iconCls="icon-add">新增</a> 
		<a data-cmd="updateSystemLog"
			href="javascript:void(0)" class="easyui-linkbutton c2"
			iconCls="icon-edit">修改</a>  -->
		<!-- <a data-cmd="deleteSystemLog"
			href="javascript:void(0)" class="easyui-linkbutton c3"
			iconCls="icon-no">删除</a> -->
		<a data-cmd="deleteAllSystemLog"
			href="javascript:void(0)" class="easyui-linkbutton c4"
			iconCls="icon-clear">清空日志</a>
		<a data-cmd="downLoadSystemLog"
			href="javascript:void(0)" class="easyui-linkbutton c5"
			iconCls="icon-redo">导出</a>
			
		<form id="searchSystemLogForm" action="#" method="POST">
			用户名:<input id="cc" type="text" name="q" size="15">
			时间从：<input type="text" name="opTimeBegin" class="easyui-datebox" /> 
			到：<input type="text" name="opTimeEnd" class="easyui-datebox" /> 
			<a data-cmd="searchSystemLog" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-search">搜索</a>
			</form>
	</div>

	<div id="systemLogDialog" class="easyui-dialog" style="width: 400px" closed="true"
		buttons="#systemLogDialog-buttons">
		<form id="systemLogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id"/>
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">字典信息</div>
			<div style="margin-bottom: 10px">
				<input name="name" class="easyui-textbox" required="true"
					label="明细名称:" style="width: 100%">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sn" class="easyui-textbox" required="true"
					label="明细编号:" style="width: 100%">
			</div>
			
			<div style="margin-bottom: 10px">
				<input name="intro" class="easyui-textbox" required="true"
					label="明细简介:" style="width: 100%">
			</div>
			<div style="margin-bottom: 10px">
				<input name="parent.id" class="easyui-textbox" required="true"
					label="字典类型:" style="width: 100%">
			</div>
			
		</form>
	</div>
	<div id="systemLogDialog-buttons">
		<a data-cmd="saveSystemLog" href="javascript:void(0)" class="easyui-linkbutton c7"
			iconCls="icon-ok" style="width: 90px">保存</a> 
		<a data-cmd="cancelSystemLog"
			href="javascript:void(0)" class="easyui-linkbutton c8"
			iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>