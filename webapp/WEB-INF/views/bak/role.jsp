<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/easyui/datagrid-detailview.js"></script>
<title>角色管理</title>

<script type="text/javascript">
	//页面加载之后才执行
	$(function() {
		// 1、声明出页面需要使用的组件
		var roleDatagrid, roleDialog, roleForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		// 3、初始化组件，修改组件的值
		var roleDatagrid = $('#roleDatagrid');
		var roleDialog = $('#roleDialog');
		var roleForm = $('#roleForm');

		// 4、创建一个"命令对象"
		var cmdObj = {
			addRole : function() {
				console.debug("add");
				//弹出对话框
				roleDialog.dialog('open').dialog('center').dialog('setTitle',
						'新增页面');
				//清空表单中的数据
				roleForm.form('clear');
			},
			updateRole : function() {
				console.debug("update");
				//选择表单中的某一行数据
				var row = roleDatagrid.datagrid('getSelected');
				if (!row) {//如果未选中行，给出提示，并结束方法
					$.messager.alert('提示信息', '请选择一条要修改的数据!', 'info');
					return;//结束方法
				}
				//弹出对话框
				roleDialog.dialog('open').dialog('center').dialog('setTitle',
						'修改页面');
				//清空表单中的数据
				roleForm.form('clear');
				//加载选中的行的数据，用于回显
				// $("input[name=state]").prop();
				roleForm.form('load', row);
				//url = 'update_user.php?id='+row.id;
			},
			deleteRole : function() {
				console.debug("delete");
				//选择表单中的某一行数据
				var row = roleDatagrid.datagrid('getSelected');
				if (!row) {//如果未选中行，给出提示，并结束方法
					$.messager.alert('提示信息', '请选择一条要删除的数据!', 'info');
					return;//结束方法
				}
				if (row) {
					$.messager.confirm('Confirm', '确定要删除该条记录吗?', function(r) {
						if (r) {
							$.get('/role/delete?id=' + row[name = "id"],
									function(result) {
										if (result.success) {//删除成功重新加载页面数据
											$.messager.alert('提示信息',
													'成功删除一条数据!', 'info');
											roleDatagrid.datagrid('reload');
										} else {
											$.messager.alert('错误提示',
													result.message, 'error');
										}
									});
						}
					});
				}
			},
			saveRole : function() {
				console.debug("save");
				roleForm.form('submit', {
					url : "/role/save",
					onSubmit : function() {//验证通过，则执行下面的代码
						return $(this).form('validate');
					},
					success : function(result) {
						var result = JSON.parse(result);
						if (result.success) {
							$.messager.alert('提示信息', '操作成功!', 'info');
							//关闭对话框
							roleDialog.dialog('close');
							//重新加载数据
							roleDatagrid.datagrid('reload');
						} else {
							$.messager.alert('错误提示', result.message, 'error');
							roleDialog.dialog('close');
							roleDatagrid.datagrid('reload');
						}
					}
				});
			},
			cancelRole : function() {
				roleDialog.dialog('close');
			},
			searchRole : function() {
				roleDatagrid.datagrid('reload', $("#searchRoleForm")
						.serializeJSON());
			}
		}

		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").click(function() {
			var cmd = $(this).data("cmd");
			if (cmd) {
				cmdObj[cmd]();//调用方法
			}
		});

		//显示每个角色拥有的权限
		roleDatagrid
				.datagrid({
					view : detailview,
					detailFormatter : function(index, row) {
						return '<div class="easyui-panel" style="height:auto;"><table id="tt'+index+'"></table></div>';
					},
					onExpandRow : function(index, row) {
						$("#tt" + index).datagrid(
								{
									title : row[name = "name"] + '拥有的权限',
									width : row[name = "width"],
									remoteSort : false,
									nowrap : false,
									fitColumns : true,
									url : '/permission/findByRoleId?roleId='
											+ row[name = "id"],
									columns : [ [ {
										field : 'id',
										title : 'id',
										width : 100,
										sortable : true
									}, {
										field : 'name',
										title : '权限名称',
										width : 80,
										align : 'right',
										sortable : true
									}, ] ],
								});

					}
				});
	});
</script>



</head>
<body>

	<div id="cc" class="easyui-layout" fit="true">
		<table id="roleDatagrid" class="easyui-datagrid" fit=true
			url="/role/json" toolbar="#roleToolbar" pagination="true"
			rownumbers="false" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="id" width="50">id</th>
					<th field="name" width="50">角色名称</th>
					<th field="permissions" width="50" formatter: function(value,row,index){
        				var string="";
						if (value){
							for (var i = 0; i < value.length; i++) {
								if (i==value.length-1) { 
									string+=value[i].name+" || ";
								}
								string+=value[i].name;
							}
						}
						return string;
					} 
        		}>角色名称</th>
				</tr>
			</thead>
		</table>

		<div id="roleToolbar">
			<a data-cmd="addRole" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-add">新增</a> <a
				data-cmd="updateRole" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-edit">修改</a> <a
				data-cmd="deleteRole" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-remove">删除</a>

			<form id="searchRoleForm" action="#" method="POST">
				关键字:<input type="text" name="q" size="15"> <a
					data-cmd="searchRole" href="javascript:void(0)"
					class="easyui-linkbutton c8" iconCls="icon-search">搜索</a>
			</form>
		</div>

		<div id="roleDialog" class="easyui-dialog" style="width: 400px"
			closed="true" buttons="#roleDialog-buttons">
			<form id="roleForm" method="post" novalidate
				style="margin: 0; padding: 20px 50px">
				<input type="hidden" name="id" />
				<div
					style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">角色信息</div>
				<div style="margin-bottom: 10px">
					<input name="name" class="easyui-textbox" required="true"
						label="角色名称:" style="width: 100%">
				</div>
			</form>
			<div id="roleDialog-buttons">
				<a data-cmd="saveRole" href="javascript:void(0)"
					class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
				<a data-cmd="cancelRole" href="javascript:void(0)"
					class="easyui-linkbutton c7" iconCls="icon-cancel"
					style="width: 90px">取消</a>
			</div>
		</div>
</body>
</html>