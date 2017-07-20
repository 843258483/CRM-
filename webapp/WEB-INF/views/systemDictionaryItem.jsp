<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/common.jsp"%>
<title>部门列表</title>

<script type="text/javascript">
	
	//页面加载之后才执行
	$(function() {
		 // 1、声明出页面需要使用的组件
		 var systemDictionaryItemDatagrid,systemDictionaryItemDialog,systemDictionaryItemForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		// 3、初始化组件，修改组件的值
		 var systemDictionaryItemDatagrid = $('#systemDictionaryItemDatagrid');
		 var systemDictionaryItemDialog = $('#systemDictionaryItemDialog');
		 var systemDictionaryItemForm = $('#systemDictionaryItemForm');
		// 4、创建一个"命令对象"
		var cmdObj = {
				addSystemDictionaryItem:function(){
// 					console.debug("add");
					//弹出对话框
		            systemDictionaryItemDialog.dialog('open').dialog('center').dialog('setTitle','新增页面');
					//清空表单中的数据
		            systemDictionaryItemForm.form('clear');
		          $("#ccType").combobox({    
		                url:'/systemDictionary/getAll',
		                valueField:'id',    
		                textField:'name'
		            });
				},updateSystemDictionaryItem:function(){
					console.debug("update");
					//选择表单中的某一行数据
		            var row = systemDictionaryItemDatagrid.datagrid('getSelected');
		            if (!row){//如果未选中行，给出提示，并结束方法
		            	$.messager.alert('提示信息','请选择一条要修改的数据!','info');
		            	return;//结束方法
		            }
		          //弹出对话框
		          systemDictionaryItemDialog.dialog('open').dialog('center').dialog('setTitle','修改页面');
		        	//清空表单中的数据
		          systemDictionaryItemForm.form('clear');
		          //加载选中的行的数据，用于回显
		       	$("#ccType").combobox({    
		                url:'/systemDictionary/getAll',
		                valueField:'id',    
		                textField:'name'
		            });
		          $("#ccType").combobox("setValue",row.parent.id);
		          //$("#ccType").prop("value",row.parent.id);
		          systemDictionaryItemForm.form('load',row);
		          //url = 'update_user.php?id='+row.id;
				},deleteSystemDictionaryItem:function(){
					console.debug("delete");
					//选择表单中的某一行数据
		            var row = systemDictionaryItemDatagrid.datagrid('getSelected');
		            if (!row){//如果未选中行，给出提示，并结束方法
		            	$.messager.alert('提示信息','请选择一条要删除的数据!','info');
		            	return;//结束方法
		            }
		            if (row){
		                $.messager.confirm('Confirm','确定要删除该条记录吗?',function(r){
		                   if(r){
		                     $.get('/systemDictionaryItem/delete?id='+row.id,function(result){
		                     	if (result.success){//删除成功重新加载页面数据
		                     		$.messager.alert('提示信息','成功删除一条数据!','info');
		                    		systemDictionaryItemDatagrid.datagrid('reload');
		                    		}else{
		                    			$.messager.alert('错误提示',result.message,'error');  
		                    		}
		                     });
		                  }
		              });
		            }
				},saveSystemDictionaryItem:function(){
					console.debug("save");
					 systemDictionaryItemForm.form('submit',{
			                url: "/systemDictionaryItem/save",
			                onSubmit: function(){//验证通过，则执行下面的代码
			                    return $(this).form('validate');
			                },
			                success: function(result){
			                    var result = JSON.parse(result);
			                    if (result.success){
			                    	$.messager.alert('提示信息','操作成功!','info');
			                    	//关闭对话框
			                        systemDictionaryItemDialog.dialog('close');
			                    	//重新加载数据
			                        systemDictionaryItemDatagrid.datagrid('reload');
			                    } else {
			                    	$.messager.alert('错误提示',result.message,'error');
			                        systemDictionaryItemDialog.dialog('close');
			                        systemDictionaryItemDatagrid.datagrid('reload');
			                    }
			                }
			            });
				},cancelSystemDictionaryItem:function(){
					console.debug("cancel");
					systemDictionaryItemDialog.dialog('close');
				},searchSystemDictionaryItem:function(){
					console.debug("search");
					systemDictionaryItemDatagrid.datagrid('reload',$("#searchSystemDictionaryItem").serializeJSON());
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

	});
</script>
</head>
<body>
	<table id="systemDictionaryItemDatagrid" title="字典明细" class="easyui-datagrid"
		fit=true url="/systemDictionaryItem/json" toolbar="#systemDictionaryItemToolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="id" width="50">id编号</th>
				<th field="name" width="50">明细名称</th>
				<th field="sequence" width="50">明细序号</th>
				<th field="intro" width="50">明细简介</th>
				<th field="parent" width="50" formatter="objectFormatter">字典类型</th>
			</tr>
		</thead>
	</table>

	<div id="systemDictionaryItemToolbar">
		<a data-cmd="addSystemDictionaryItem" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add">新增</a> 
		<a data-cmd="updateSystemDictionaryItem"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit">修改</a> 
		<a data-cmd="deleteSystemDictionaryItem"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove">删除</a>
			
		<form id="searchSystemDictionaryItemFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">
			<a data-cmd="searchSystemDictionaryItem" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">搜索</a>
			</form>
	</div>

	<div id="systemDictionaryItemDialog" class="easyui-dialog" style="width: 400px" closed="true"
		buttons="#systemDictionaryItemDialog-buttons" modal="true">
		<form id="systemDictionaryItemForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id"/>
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">字典信息</div>
			<div style="margin-bottom: 10px">
				<input name="name" class="easyui-textbox" required="true"
					label="明细名称:" style="width: 100%">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sequence" class="easyui-textbox" required="true"
					label="明细序号:" style="width: 100%">
			</div>
			
			<div style="margin-bottom: 10px">
				<input name="intro" class="easyui-textbox" required="true"
					label="明细简介:" style="width: 100%">
			</div>
			<div style="margin-bottom: 10px">
				
				字典类型:<br/>	
				<input id="ccType"  required="true" name="parent.id"/>
				<!-- <input id="ccType" class="easyui-combobox" name="parent.id"   
    			data-options="valueField:'id',textField:'name',
    			url:'/systemDictionary/getAll'" /> --> 
			</div>
			
		</form>
	</div>
	<div id="systemDictionaryItemDialog-buttons">
		<a data-cmd="saveSystemDictionaryItem" href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">保存</a> 
		<a data-cmd="cancelSystemDictionaryItem"
			href="javascript:void(0)" class="easyui-linkbutton c7"
			iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>