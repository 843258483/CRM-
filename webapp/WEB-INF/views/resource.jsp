<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源页面</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	function menuFomatter(value, row, index) {
		return value ? value.name : "";
	}
	$(function() {
		var resourceDatagrid = $('#resourceDatagrid');
		var resourceDialog = $('#resourceDialog');
		var resourceForm = $('#resourceForm');
		var objectcmd = {
			addResource : function() {
				console.debug('add')
				resourceDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加资源');
				resourceForm.form('clear');
			},
			editResource : function() {
				console.debug('edit')
				var row = resourceDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				resourceDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改资源');
				resourceForm.form('clear');
				$("#url").combobox('disable');
				//回显数据
				if (row.menu) {
					row['menu.id'] = row.menu.id;
				}
				resourceForm.form('load', row);
			},
			saveResource : function() {
				resourceForm.form('submit', {
					url : "/resource/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								resourceDialog.dialog('close'); // close the dialog
								resourceDatagrid.datagrid('reload'); // reload the user data
							} else {
								$.messager.show({
									title : '错误信息',
									msg : "<font color='red'>" + result.message
											+ "</font>",
									showType : 'fade',
									style : {
										right : '',
										bottom : ''
									}
								});
							}
						} catch (e) {
							$.messager.show({
								title : '错误信息',
								msg : "<font color='red'>" + "类型转换异常或者程序运行异常"
										+ "</font>",
								showType : 'fade',
								style : {
									right : '',
									bottom : ''
								}
							});
						}
					}
				});
			},
			cancelResource : function() {
				resourceDialog.dialog('close');
			},
			searchResource : function() {//普通查询
				resourceDatagrid.datagrid('load', $("#searchResourceFrom")
						.serializeJSON());
			},
			clearResource : function() {//普通查询清除
				$("#searchResourceFrom").form("clear");
			}

		};
		$("a").click(function() {
			var cmd = $(this).data('cmd');
			if (cmd) {
				objectcmd[cmd]();
			}

		});
	});
</script>
</head>
<body>
	<table id="resourceDatagrid" title="资源列表" class="easyui-datagrid"
		fit="true" url="/resource/json" toolbar="#toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="name" width="50">资源名称</th>
				<th field="url" width="50">资源路径</th>
				<th field="menu" formatter="menuFomatter" width="50">所属菜单</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a data-cmd="addResource" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add">添加</a> <a
			data-cmd="editResource" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-edit">修改</a>
		<form id="searchResourceFrom" action="#" method="POST">
			资源名称:<input type="text" name="q" size="15"> <a
				data-cmd="searchResource" href="javascript:void(0)"
				class="easyui-linkbutton c4" iconCls="icon-search">搜索</a> <a
				data-cmd="clearResource" href="javascript:void(0)"
				class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
		</form>
	</div>
	<div id="resourceDialog" title="对话框" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#dlg-buttons">
		<form id="resourceForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id" />
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">资源信息</div>
			<div style="margin-bottom: 10px">
				<input name="name" class="easyui-textbox" required="true"
					label="资源名称" style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="url" id="url" class="easyui-textbox" required="true"
					label="资源地址" style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				所属菜单&emsp;&emsp;&emsp;<select id="cc" class="easyui-combogrid"
					name="menu.id" style="width: 150px;"
					data-options="    
	            panelWidth:380,    
	            value:'006',    
	            idField:'id',    
	            textField:'name',    
	            url:'/resource/findChildrenMenu',    
	            columns:[[    
                {field:'id',title:'ID',width:60},    
                {field:'name',title:'菜单名字',width:100},    
                {field:'url',title:'菜单路径',width:120},    
                {field:'icon',title:'图标',width:100}    
            ]]    
        "></select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a data-cmd="saveResource" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelResource" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>