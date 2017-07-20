<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Permission管理</title>
<%@include file="common.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/easyui/datagrid-detailview.js"></script>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var permissionDatagrid, permissionDialog, permissionForm, selectedResourceDatagrid, allResourceDatagrid;
		// 2、把页面的组件，缓存到上面声明的变量中
		permissionDatagrid = $("#permissionDatagrid");
		permissionDialog = $("#permissionDialog");
		permissionForm = $("#permissionForm");
		selectedResourceDatagrid = $("#selectedResourceDatagrid");
		allResourceDatagrid = $("#allResourceDatagrid");
		// 3、初始化组件		

		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			create : function() {
				// 清空对话框里面的表单内容
				permissionForm.form("clear");
				// 打开对话框
				permissionDialog.dialog("open");
				selectedResourceDatagrid.datagrid('loadData', {
					"total" : 0,
					"rows" : []
				});
			},
			edit : function() {
				// 获取选中行数据
				var rowData = permissionDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				// 清空对话框里面的表单内容
				permissionForm.form("clear");
				// 加载数据：Easyui form的load方法，遵循一个“同名匹配”的原则
				permissionForm.form("load", rowData);
				//动态值：现在从permission对象里面的属性permissions获取
				selectedResourceDatagrid
						.datagrid('loadData', rowData.resources);
				// 打开对话框
				permissionDialog.dialog("open");
			},
			remove : function() {
				// 获取选中行数据
				var rowData = permissionDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				$.messager.confirm('提示信息', '确定要删除该权限吗?', function(r) {
					if (r) {
				jQuery.get("/permission/delete?id=" + rowData.id,
						function(data) {
							if (data.success) {//删除成功
								jQuery.messager.alert('消息提示', '删除成功!', 'info',
										function() {
											//调用重新加载数据的方法
											permissionDatagrid
													.datagrid("reload");
										});//消息							
							} else {
								jQuery.messager.alert('错误提示', "请先解除角色中的该权限",
										'error');
							}
						}, 'json');
					}
				});
			},
			reload : function() {
				//调用重新加载数据的方法
				permissionDatagrid.datagrid("reload");
			},
			save : function() {
				permissionForm
						.form(
								'submit',
								{
									url : "/permission/save",
									onSubmit : function(param) { // 在表单‘提交前’，做验证
										//提交额外的参数格式:param.参数的名称 = '参数的值';					
										//param.p1 = 'value1';
										//param.p2 = 'value2';
										//后台接受：Role.java:List<Resource> permissions = new ArrayList<Resource>();
										//类似进销存pss组合关系，采购订单items[0].product.id
										var rows = selectedResourceDatagrid
												.datagrid("getRows");
										for (var i = 0; i < rows.length; i++) {
											//提交的格式：permissions[0].id=2;
											//提交额外的参数格式:param.参数的名称 = '参数的值';					
											param['resources[' + i + '].id'] = rows[i].id;
										}
										return permissionForm.form("validate");
									},
									success : function(data) {//data是后台save方法返回的字符串
										// 把字符串转变成json对象
										data = jQuery.parseJSON(data);
										// 判断结果
										if (data.success) {
											// 关对话框
											permissionDialog.dialog("close");
											jQuery.messager
													.alert(
															"温馨提示",
															data.message,
															"info",
															function() {
																//调用重新加载数据的方法
																permissionDatagrid
																		.datagrid("reload");
															});
										} else {
											jQuery.messager.alert('错误提示',
													data.message, 'error');
										}
									}
								});
			},
			cancel : function() {
				//关闭对话框
				permissionDialog.dialog("close");
			},
			search : function() {//简单搜索：查询条件必须少
				permissionDatagrid.datagrid("load", $("#searchForm")
						.serializeJSON());
			},
			removeSelect : function() {//清空已有权限
				//方案1：先获取所有已经选择的权限，然后一个一个清空
				//方案2：加载本地空的数据,本质就是清空
				selectedResourceDatagrid.datagrid('loadData', {
					"total" : 0,
					"rows" : []
				});
			}
		};

		//角色列表的datagrid的js组件
		permissionDatagrid
				.datagrid({
					url : '/permission/json',
					title : '权限列表',
					fit : true,
					fitColumns : true,
					pagination : true,
					singleSelect : true,
					columns : [ [ {
						field : 'id',
						title : '编号',
						width : 100
					}, {
						field : 'name',
						title : '名称',
						width : 100
					} ] ],
					toolbar : [ {
						text : '增加',
						iconCls : 'icon-add',
						handler : cmdObj.create
					}, {
						text : '编辑',
						iconCls : 'icon-edit',
						handler : cmdObj.edit
					}, {
						text : '删除',
						iconCls : 'icon-remove',
						handler : cmdObj.remove
					}, '-' ],
					view : detailview,
					detailFormatter : function(index, row) {
						return '<table height="150" id="tt'+index+'"></table>';
					},
					onExpandRow : function(index, row) {
						$("#tt" + index)
								.datagrid(
										{
											title : row[name = "name"]
													+ '拥有的资源',
											width : row[name = "width"],
											remoteSort : false,
											pagination : true,
											showPageList : false,
											showRefresh : false,
											displayMsg : "",
											nowrap : false,
											fitColumns : true,
											url : '/resource/findByPermissionId?permissionId='
													+ row[name = "id"],
											columns : [ [ {
												field : 'id',
												title : 'id',
												width : 100,
												sortable : true
											}, {
												field : 'name',
												title : '资源名称',
												width : 80,
												align : 'right',
												sortable : true
											}, {
												field : 'url',
												title : '资源路径',
												width : 80,
												align : 'right',
												sortable : true
											} ] ]
										});
					}
				});

		//编辑角色的dialog的js组件
		permissionDialog.dialog({
			title : '权限编辑页面',
			width : 840,
			height : 460,
			closed : true,
			modal : true,
			buttons : [ {
				text : '清空已有资源',
				iconCls : "icon-remove",
				handler : cmdObj.removeSelect
			}, {
				text : '保存',
				iconCls : "icon-ok",
				handler : cmdObj.save
			}, {
				text : '关闭',
				iconCls : "icon-cancel",
				handler : cmdObj.cancel
			} ]
		});

		//全部权限的datagrid的js组件
		allResourceDatagrid
				.datagrid({
					url : '/resource/json',
					title : '全部资源列表',
					width : 400,
					height : 370,
					pagination : true,
					fitColumns : true,
					singleSelect : true,
					// 监控双击的行事件
					onDblClickRow : function(rowIndex, rowData) {
						//getRows none 返回当前页的所有行。 
						var rows = selectedResourceDatagrid.datagrid('getRows');
						for (var i = 0; i < rows.length; i++) {
							//获取每一行
							var row = rows[i];
							if (row.id == rowData.id) {//已经存在
								$.messager
										.show({
											title : '错误提示',
											msg : '<center><font color="red" style="font-weight: bold;">请不要重复选中 ！！</font></center>',
											showType : 'fade',
											timeout : 400,
											style : {
												right : '',
												bottom : ''
											}
										});
								return;
							}
						}
						//appendRow追加一个新行。新行将被添加到最后的位置。
						selectedResourceDatagrid.datagrid('appendRow', rowData);
					},
					columns : [ [ {
						field : 'id',
						title : '编号',
						width : 5
					}, {
						field : 'name',
						title : '资源名称',
						width : 10
					}, {
						field : 'url',
						title : '资源路径',
						width : 10
					} ] ],
				});

		//已拥有权限数据表格(新增没有数据，编辑的时候有数据)
		selectedResourceDatagrid.datagrid({
			title : '已拥有资源列表',
			width : 400,
			height : 370,
			rownumbers : true,
			fitColumns : true,
			singleSelect : true,
			// 监控双击的行事件
			onDblClickRow : function(rowIndex, rowData) {
				//deleteRow index 删除行。 
				selectedResourceDatagrid.datagrid("deleteRow", rowIndex);
			},
			columns : [ [ {
				field : 'name',
				title : '资源名称',
				width : 10
			} ] ]
		});

	});
</script>
</head>
<body>
	<!-- 1、数据表格 -->
	<table id="permissionDatagrid"></table>
	<!-- 2、添加编辑对话框 -->
	<div id="permissionDialog">
		<form id="permissionForm" method="post">
			<input name="id" type="hidden" />
			<table>
				<tr>
					<td>权限名称: <input type="text" name="name" />
					</td>
				</tr>
				<tr>
					<td>
						<table id="selectedResourceDatagrid"></table>
					</td>
					<td>
						<table id="allResourceDatagrid"></table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>