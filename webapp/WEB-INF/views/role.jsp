<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Role管理</title>
<%@include file="common.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/easyui/datagrid-detailview.js"></script>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var roleDatagrid, roleDialog, roleForm, selectedPermissionDatagrid, allPermissionDatagrid;
		// 2、把页面的组件，缓存到上面声明的变量中
		roleDatagrid = $("#roleDatagrid");
		roleDialog = $("#roleDialog");
		roleForm = $("#roleForm");
		selectedPermissionDatagrid = $("#selectedPermissionDatagrid");
		allPermissionDatagrid = $("#allPermissionDatagrid");
		// 3、初始化组件		

		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			create : function() {
				// 清空对话框里面的表单内容
				roleForm.form("clear");
				// 打开对话框
				roleDialog.dialog("open");
				selectedPermissionDatagrid.datagrid('loadData', {
					"total" : 0,
					"rows" : []
				});
			},
			edit : function() {
				// 获取选中行数据
				var rowData = roleDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				// 清空对话框里面的表单内容
				roleForm.form("clear");
				// 加载数据：Easyui form的load方法，遵循一个“同名匹配”的原则
				roleForm.form("load", rowData);
				//动态值：现在从role对象里面的属性permissions获取
				selectedPermissionDatagrid.datagrid('loadData',
						rowData.permissions);
				// 打开对话框
				roleDialog.dialog("open");
			},
			remove : function() {
				// 获取选中行数据
				var rowData = roleDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				$.messager.confirm('提示信息', '确定要删除该角色吗?', function(r) {
					if (r) {

						jQuery.get("/role/delete?id=" + rowData.id, function(
								data) {
							if (data.success) {//删除成功
								jQuery.messager.alert('消息提示', '删除成功!', 'info',
										function() {
											//调用重新加载数据的方法
											roleDatagrid.datagrid("reload");
										});//消息							
							} else {
								jQuery.messager.alert('错误提示', "请确认员工中是否有正在使用该角色的，请先解除员工的角色，再进行删除",
										'error');
							}
						}, 'json');
					}
				});
			},
			reload : function() {
				//调用重新加载数据的方法
				roleDatagrid.datagrid("reload");
			},
			save : function() {
				roleForm.form('submit', {
					url : "/role/save",
					onSubmit : function(param) { // 在表单‘提交前’，做验证
						//提交额外的参数格式:param.参数的名称 = '参数的值';					
						//param.p1 = 'value1';
						//param.p2 = 'value2';
						//后台接受：Role.java:List<Permission> permissions = new ArrayList<Permission>();
						//类似进销存pss组合关系，采购订单items[0].product.id
						var rows = selectedPermissionDatagrid
								.datagrid("getRows");
						for (var i = 0; i < rows.length; i++) {
							//提交的格式：permissions[0].id=2;
							//提交额外的参数格式:param.参数的名称 = '参数的值';					
							param['permissions[' + i + '].id'] = rows[i].id;
						}
						return roleForm.form("validate");
					},
					success : function(data) {//data是后台save方法返回的字符串
						// 把字符串转变成json对象
						data = jQuery.parseJSON(data);
						// 判断结果
						if (data.success) {
							// 关对话框
							roleDialog.dialog("close");
							jQuery.messager.alert("温馨提示", data.message, "info",
									function() {
										//调用重新加载数据的方法
										roleDatagrid.datagrid("reload");
									});
						} else {
							jQuery.messager
									.alert('错误提示', data.message, 'error');
						}
					}
				});
			},
			cancel : function() {
				//关闭对话框
				roleDialog.dialog("close");
			},
			search : function() {//简单搜索：查询条件必须少
				roleDatagrid.datagrid("load", $("#searchForm").serializeJSON());
			},
			removeSelect : function() {//清空已有权限
				//方案1：先获取所有已经选择的权限，然后一个一个清空
				//方案2：加载本地空的数据,本质就是清空
				selectedPermissionDatagrid.datagrid('loadData', {
					"total" : 0,
					"rows" : []
				});
			}
		};

		//角色列表的datagrid的js组件
		roleDatagrid.datagrid({
			url : '/role/json',
			title : '角色列表',
			fit : true,
			fitColumns : true,
			pagination : true,
			rownumbers : true,
			singleSelect : true,
			columns : [ [ {
				field : 'id',
				title : '编号',
				width : 100
			}, {
				field : 'name',
				title : '名称',
				width : 100
			}, {
				field : 'permissions',
				title : '权限',
				formatter : function(value, row, index) {
					//value===permissions
					if (value) {
						var string = "";
						for (var i = 0; i < value.length; i++) {
							if (i == value.length - 1) {
								string += value[i].name;
							} else {
								string += value[i].name + ",";
							}
						}
						return string;
					}
				},
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
			}, '-' ]
		});

		//编辑角色的dialog的js组件
		roleDialog.dialog({
			title : '角色编辑页面',
			width : 840,
			height : 460,
			closed : true,
			modal : true,
			buttons : [ {
				text : '清空已有权限',
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
		allPermissionDatagrid
				.datagrid({
					url : '/permission/json',
					title : '全部权限列表',
					width : 400,
					height : 370,
					pagination : true,
					fitColumns : true,
					singleSelect : true,
					// 监控双击的行事件
					onDblClickRow : function(rowIndex, rowData) {
						//getRows none 返回当前页的所有行。 
						var rows = selectedPermissionDatagrid
								.datagrid('getRows');
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
						selectedPermissionDatagrid.datagrid('appendRow',
								rowData);
					},
					columns : [ [ {
						field : 'id',
						title : '编号',
						width : 5
					}, {
						field : 'name',
						title : '名称',
						width : 10
					} ] ],
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
											} ] ],
										});
						var pager = $("#tt" + index).datagrid("getPager");
						pager.pagination({
							showPageList : false,
							showRefresh : false,
							displayMsg : ""
						});
					}
				});

		//datagrid组件.getPager none 返回页面对象。 
		var pager = allPermissionDatagrid.datagrid("getPager");
		//设置一些属性不显示，精简分页对象效果
		pager.pagination({
			showPageList : false,//不显示分页条数select
			showRefresh : false,//不显示刷新按钮
			displayMsg : ""//分页的信息条设置为""
		});

		//已拥有权限数据表格(新增没有数据，编辑的时候有数据)
		selectedPermissionDatagrid.datagrid({
			title : '已拥有权限列表',
			width : 400,
			height : 370,
			rownumbers : true,
			fitColumns : true,
			singleSelect : true,
			// 监控双击的行事件
			onDblClickRow : function(rowIndex, rowData) {
				//deleteRow index 删除行。 
				selectedPermissionDatagrid.datagrid("deleteRow", rowIndex);
			},
			columns : [ [ {
				field : 'name',
				title : '名称',
				width : 10
			} ] ]
		});

	});
</script>
</head>
<body>
	<!-- 1、数据表格 -->
	<table id="roleDatagrid"></table>
	<!-- 2、添加编辑对话框 -->
	<div id="roleDialog">
		<form id="roleForm" method="post">
			<input name="id" type="hidden" />
			<table>
				<tr>
					<td>角色名称: <input type="text" name="name" />
					</td>
				</tr>
				<tr>
					<td>
						<table id="selectedPermissionDatagrid"></table>
					</td>
					<td>
						<table id="allPermissionDatagrid"></table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>