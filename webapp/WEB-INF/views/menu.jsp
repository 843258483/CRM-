<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单页面</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		var menuDatagrid = $('#menuDatagrid');
		var menuDialog = $('#menuDialog');
		var menuForm = $('#menuForm');
		var objectcmd = {
			addMenu : function() {
// 				console.debug('add')
				menuDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加菜单');
				menuForm.form('clear');
			},
			editMenu : function() {
// 				console.debug('edit')
				var row = menuDatagrid.datagrid('getSelected');
				console.debug(row);
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				menuDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改菜单');
				//回显数据
				if (row.parent) {
					row['parent.id'] = row.parent.id;
				}
				menuForm.form('clear');
				menuForm.form('load', row);
			},
			deleteMenu : function() {
// 				console.debug('delete')
				var row = menuDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一条数据删除!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除吗?', function(r) {
					if (r) {
						$.post('/menu/delete' , {
							id : row.id
						}, function(result) {
							if (result.success) {
								menuDatagrid.datagrid('reload'); // reload the user data
							} else {
								$.messager.show({
									title : '错误信息',
									msg : "<font color='red'>请先解除该菜单的所有资源以及子菜单</font>",
									showType : 'fade',
									style : {
										right : '',
										bottom : ''
									}
								});

							}
						}, 'json');
					}
				});
			},
			saveMenu : function() {
				menuForm.form('submit', {
					url : "/menu/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						try {
							var result = JSON.parse(result);
							if (result.success) {
								menuDialog.dialog('close'); // close the dialog
								menuDatagrid.datagrid('reload'); // reload the user data
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
			cancelMenu : function() {
				menuDialog.dialog('close');
			},
			searchMenu:function(){//普通查询
				
			menuDatagrid.datagrid('load',$("#searchMenuFrom").serializeJSON());
			},
			clearMenu:function(){//普通查询清除
				$("#searchMenuFrom").form("clear");
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
	<table id="menuDatagrid" title="菜单列表" class="easyui-datagrid"
		fit="true" url="/menu/json" singleSelect="true" striped="true"
		toolbar="#toolbar" pagination="true" rownumbers="false"
		fitColumns="true" singleS elect="true">
		<thead>
			<tr>
				<th field="name" width="50" sortable="true">菜单名称</th>
				<th field="url" width="50" sortable="true">URL地址</th>
				<th field="icon" width="50" sortable="true">图标</th>
				<th field="parent" width="50" formatter="nameFormatter"
					sortable="true">上级菜单</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a data-cmd="addMenu" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add">添加</a><a
			data-cmd="editMenu" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-edit">修改</a><a
			data-cmd="deleteMenu" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-remove">删除</a>
			<form id="searchMenuFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">
			<a
			data-cmd="searchMenu" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearMenu" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			</form>
	</div>
	<div id="menuDialog" title="对话框" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#menuDialogButtons">
		<form id="menuForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id" />
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">菜单信息</div>
			<div style="margin-bottom: 10px">
				<input name="name" class="easyui-textbox" required="true"
					label="菜单名称" style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="url" class="easyui-textbox" label="URL地址"
					style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="icon" class="easyui-textbox" label="图标"
					style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				上级菜单&emsp;&emsp;&emsp;<select id="cc" class="easyui-combogrid"
					name="parent.id" style="width: 150px;"
					data-options="    
	            panelWidth:380,    
	            value:'006',    
	            idField:'id',    
	            textField:'name',    
	            url:'/menu/findParentMenu',    
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
	<div id="menuDialogButtons">
		<a data-cmd="saveMenu" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelMenu" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>