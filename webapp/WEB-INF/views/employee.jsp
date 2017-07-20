<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工页面</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		var employeeDatagrid = $('#employeeDatagrid');
		var employeeDialog = $('#employeeDialog');
		var employeeForm = $('#employeeForm');
		var advancedSearchEmployee =$("#advancedSearchEmployee");
		var employeeAdvancedSearchDialog=$("#employeeAdvancedSearchDialog")
		var rolesCombo=$("#rolesCombo")
		var roleDialog=$("#roleDialog")
		var roleForm=$("#roleForm")
		var selectedRoleDatagrid=$("#selectedRoleDatagrid")
		var allRoleDatagrid=$("#allRoleDatagrid")
		
		var grid = rolesCombo.combogrid("grid");
		var pager = grid.datagrid("getPager");
		pager.pagination({
			showPageList : false,
			showRefresh : false,
			displayMsg : ""
		});
		var objectcmd = {
			addEmployee : function() {
				console.debug('add')
				employeeDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加员工');
				employeeForm.form('clear');
				$('#cc').combotree({    
				    url: '/employee/getParentTreeData',    
				});
				$('#roles').datagrid({    
				    url:'/employee/RoleAll',    
				    columns:[[    
				        {field:'name',title:'角色名称',width:100},    
				    ]]    
				});  




			},
			editEmployee : function() {
// 				console.debug('edit')
				var row = employeeDatagrid.datagrid('getSelected');
// 				var row = employeeDatagrid.datagrid('getRows');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				employeeDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改员工');
				employeeForm.form('clear');
				//回显数据
				$('#cc').combotree({    
				    url: '/employee/getParentTreeData',    
				});
				console.debug("ccccccc");
				if(row.department){
					
				$('#cc').combotree('setValue', row.department.id);
				}
				
				if(row.roles){
					row['roles.id']=row.roles.id;
				}
				console.debug(row.roles);
			
				employeeForm.form('load', row);
			},
			deleteEmployee : function() {
				console.debug('delete')
				var row = employeeDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行数据删除!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除该员工吗?', function(r) {
					if (r) {
						$.post('/employee/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								employeeDatagrid.datagrid('reload'); // reload the user data
							} else {
								$.messager.show({
									title : '错误信息',
									msg : "<font color='red'>请将该员工的工作全部移交之后进行删除!</font>",
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
			saveEmployee : function() {
				employeeForm.form('submit', {
					url : "/employee/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								employeeDialog.dialog('close'); // close the dialog
								employeeDatagrid.datagrid('reload'); // reload the user data
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
			cancelEmployee : function() {
				employeeDialog.dialog('close');
			},
			leaveEmployee:function(){//处理离职的状态
				var row = employeeDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行数据!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定该员工离职吗?', function(r) {
					if (r) {
						$.post('/employee/leaveJob', {
							id : row.id
						}, function(result){
							if (result.success) {
								employeeDatagrid.datagrid('reload'); // reload the user data
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
						}, 'json');
					}
				});
			},searchEmployee:function(){
				employeeDatagrid.datagrid('load',$("#searchEmployeeFrom").serializeJSON()); 
			},clearEmployee:function(){//
				$("#searchEmployeeFrom").form('clear');
// 				$("#state").append("<option value='-1'>--请选择--</option>");
				location.reload();
				
			},advancedSearchEmployee:function(){//打开高级搜索
				$("#AdvancedSearchForm").form("clear");
				$('#advancedSearchEmployeecc').combotree({
					url : '/employee/getParentTreeData',
				});
				employeeAdvancedSearchDialog.dialog('open').dialog('center');
			},
			advancedSearchEmployeesave:function(){//高级搜索提交按钮
// 				reload跟load的区别在 reload 是保留当前数据进行加载,而load则是重新加载
				employeeDatagrid.datagrid('load',$("#AdvancedSearchForm").serializeJSON());	
				
			},
			cancelSearchEmployee:function(){//取消高级搜索关闭界面
				employeeAdvancedSearchDialog.dialog('close');
			},resetSearchEmployee:function(){ //重置高级搜索的条件
				$("#AdvancedSearchForm").form("clear");
			},addEmployeeRole:function(){
				var row = employeeDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行数据!', 'warning');
					return;
				}
				roleDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加角色');
				roleForm.form('clear');
				roleForm.form('load', row);
				//动态值：现在从permission对象里面的属性permissions获取
				selectedRoleDatagrid
						.datagrid('loadData', row.roles);
			},removeSelect:function(){
				selectedRoleDatagrid.datagrid('loadData', {
					"total" : 0,
					"rows" : []
				});
			},saveRole:function(){
				roleForm.form('submit', {
					url : "/employee/saveRole",
					onSubmit : function(param) { // 在表单‘提交前’，做验证
						//提交额外的参数格式:param.参数的名称 = '参数的值';					
						//param.p1 = 'value1';
						//param.p2 = 'value2';
						//后台接受：Role.java:List<Resource> permissions = new ArrayList<Resource>();
						//类似进销存pss组合关系，采购订单items[0].product.id
						var rows = selectedRoleDatagrid
								.datagrid("getRows");
						for (var i = 0; i < rows.length; i++) {
							//提交的格式：permissions[0].id=2;
							//提交额外的参数格式:param.参数的名称 = '参数的值';					
							param['roles[' + i + '].id'] = rows[i].id;
						}
						return roleForm.form("validate");
					},
					success : function(result) {
						var result = JSON.parse(result);
						// 判断结果
						if (result.success) {
							// 关对话框
							roleDialog.dialog("close");
							jQuery.messager
									.alert(
											"温馨提示",
											result.message,
											"info",
											function() {
												//调用重新加载数据的方法
												employeeDatagrid
														.datagrid("reload");
											});
						} else {
							jQuery.messager.alert('错误提示',
									result.message, 'error');
						}
					
					}
				});
			},cancelRole:function(){
				//关闭对话框
				roleDialog.dialog("close");
			}
			

		};
		
	//**************************************************************************************
	
	//编辑角色的dialog的js组件
		roleDialog.dialog({
			width : 840,
			height : 460,
			closed : true,
			modal : true,
			buttons : [ {
				text : '清空已有角色',
				iconCls : "icon-remove",
				handler : objectcmd.removeSelect
			}, {
				text : '保存',
				iconCls : "icon-ok",
				handler : objectcmd.saveRole
			}, {
				text : '关闭',
				iconCls : "icon-cancel",
				handler : objectcmd.cancelRole
			} ]
		});

		//全部权限的datagrid的js组件
		allRoleDatagrid
				.datagrid({
					url : '/role/json',
					title : '全部角色列表',
					width : 400,
					height : 370,
					pagination : true,
					fitColumns : true,
					singleSelect : true,
					// 监控双击的行事件
					onDblClickRow : function(rowIndex, rowData) {
						//getRows none 返回当前页的所有行。 
						var rows = selectedRoleDatagrid.datagrid('getRows');
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
						selectedRoleDatagrid.datagrid('appendRow', rowData);
					},
					columns : [ [ {
						field : 'id',
						title : '编号',
						width : 5
					}, {
						field : 'name',
						title : '角色名称',
						width : 10
					}] ],
				});

		//已拥有权限数据表格(新增没有数据，编辑的时候有数据)
		selectedRoleDatagrid.datagrid({
			title : '已拥有角色列表',
			width : 400,
			height : 370,
			rownumbers : true,
			fitColumns : true,
			singleSelect : true,
			// 监控双击的行事件
			onDblClickRow : function(rowIndex, rowData) {
				//deleteRow index 删除行。 
				selectedRoleDatagrid.datagrid("deleteRow", rowIndex);
			},
			columns : [ [ {
				field : 'name',
				title : '角色名称',
				width : 10
			} ] ]
		});

	
	
	//**************************************************************************************
		
		
		$("a[data-cmd]").click(function() {
			var cmd = $(this).data('cmd');
			if(objectcmd[cmd]){
				//判断是否有禁用的样式
				if($(this).hasClass("l-btn-disabled")){
					return;
				}
				
			objectcmd[cmd]();
			}

		});
	});
		function clickRow(index,row){
			if (row.state == 1){
				$("#leave").linkbutton("disable");
				$("#delete").linkbutton("disable");
			} else {
				$("#leave").linkbutton("enable");
				$("#delete").linkbutton("enable");
			}
			
		};
		
		function roleFormatter(value,index,row){
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
		}
</script>
</head>
<body>
    <table id="employeeDatagrid" title="员工列表" class="easyui-datagrid" fit="true"
            url="/employee/json" singleSelect="true" striped="true"
            toolbar="#toolbar" pagination="true" 
            rownumbers="false" fitColumns="true" singleSelect="true" data-options="onClickRow:clickRow">
        <thead>
            <tr>
                <th field="username" width="50" sortable="true">员工账号</th>
                <th field="realName" width="50" sortable="true">真实姓名</th>
                <th field="password" width="50" sortable="true">密码</th>
                <th field="tel" width="50" sortable="true">电话</th>
                <th field="email" width="50" sortable="true">邮箱</th>
                <th field="inputTime" width="50" sortable="true">入职时间</th>
                <th field="state" width="50" formatter="employeestateFormatter" sortable="true">状态</th>
                <th field="roles" width="50" formatter="roleFormatter" sortable="true">角色</th>
                <th field="department" width="50" formatter="nameFormatter" sortable="true">所属部门</th>
            </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a data-cmd="addEmployee" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add" >添加</a>
        <a data-cmd="editEmployee" href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-edit" >修改</a>
        <a data-cmd="leaveEmployee" id="leave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-clear">离职</a>
        <a data-cmd="deleteEmployee" id="delete" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-remove">删除</a>
        <a data-cmd="addEmployeeRole" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add">添加角色</a>
        <form id="searchEmployeeFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">
			状态:<select id="state" name="state" >
			<option value="-1">--请选择--</option>
			<option value="1">离职</option>
			<option value="0">在职</option>
			</select>
			入职日期从:<input name="minDate" type="text" class="easyui-datebox" 
			></input>  
			到:<input name="maxDate" type="text" class="easyui-datebox" ></input>
			<a
			data-cmd="searchEmployee" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearEmployee" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a
			data-cmd="advancedSearchEmployee" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
			</form>
    </div>
    <div id="employeeDialog" title="对话框" class="easyui-dialog" style="width:400px"
            closed="true" buttons="#dlg-buttons">
        <form id="employeeForm" method="post" novalidate style="margin:0;padding:20px 50px">
        	<input type="hidden" name="id"/>
            <div style="margin-bottom:20px;font-size:14px;border-bottom:1px solid #ccc">员工信息</div>
            <div style="margin-bottom:10px">
                <input name="username" class="easyui-textbox" required="true" label="员工账号" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="realName" class="easyui-textbox" required="true" label="真实姓名" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="password" class="easyui-textbox" required="true" label="密码" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="tel" class="easyui-textbox" required="true" label="电话" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="email" class="easyui-textbox" validType="email" label="邮箱" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                 <select id="cc" class="easyui-combotree" style="width:200px;" name="department.id"  label="所属部门"
        		,required:true"></select> 
            </div>
        		<div style="margin-bottom: 10px">
				角色列表: 
         	   <select id="rolesCombo" class="easyui-combogrid" name="role.id" style="width:200px;"  
        data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'name',     
            url:'/employee/RoleAll',    
            columns:[[    
                {field:'id',title:'角色编号',width:50},    
                {field:'name',title:'角色名称',width:60},    
            ]],"         
	
    >
    </select>
			</div>
            
            
        </form>
    </div>
    <div id="dlg-buttons">
        <a data-cmd="saveEmployee" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="cancelEmployee" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"  style="width:90px">取消</a>
    </div>
    
<!--     高级搜索弹窗 -->
    <div id="employeeAdvancedSearchDialog" title="高级查询" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#employeeSearchDialogButtons">
		<form id="AdvancedSearchForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">员工信息</div>
			<div style="margin-bottom: 10px">
				<input name="q" class="easyui-textbox" 
					label="关键字" style="width: 220px">
			</div>
			
			<div style="margin-bottom: 10px">
				状态:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input id="advancedSearchstate" type="radio" name="state" value="0">在职 <input
					type="radio" name="state" value="1">离职
			</div>
			
			<div style="margin-bottom: 10px">
				<select id="advancedSearchEmployeecc" class="easyui-combotree" style="width: 200px;"
				name="departmentId" label="所属部门",required:true"></select>
			</div>
		</form>
	</div>
	<div id="employeeSearchDialogButtons">
		<a data-cmd="advancedSearchEmployeesave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">提交</a>
		<a data-cmd="cancelSearchEmployee" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
		<a data-cmd="resetSearchEmployee" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-reload" style="width: 90px">重置</a>
	</div>
	<!-- 2、添加编辑对话框 -->
	<div id="roleDialog">
		<form id="roleForm" method="post">
			<input name="id" type="hidden" />
			<table>
				<tr>
					<td>用户名称: <input type="text" name="realName" />
					</td>
				</tr>
				<tr>
					<td>
						<table id="selectedRoleDatagrid"></table>
					</td>
					<td>
						<table id="allRoleDatagrid"></table>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>