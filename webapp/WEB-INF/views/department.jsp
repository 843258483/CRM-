<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门页面</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		var departmentDatagrid = $('#departmentDatagrid');
		var departmentDialog = $('#departmentDialog');
		var departmentForm = $('#departmentForm');
		var managerCombo = $("#managerCombo");
		var advancedSearchDepartment =$("#advancedSearchDepartment");
		var departmentAdvancedSearchDialog=$("#departmentAdvancedSearchDialog")
		var	AdvancedSearchmanagerCombo = $("#AdvancedSearchmanagerCombo");
		var grid = managerCombo.combogrid("grid");
		var pager = grid.datagrid("getPager");
		pager.pagination({
			showPageList : false,
			showRefresh : false,
			displayMsg : ""
		});
		var grid = AdvancedSearchmanagerCombo.combogrid("grid");
		var pager = grid.datagrid("getPager");
		pager.pagination({
			showPageList : false,
			showRefresh : false,
			displayMsg : ""
		});
		$('#tt').tree({    
		    url:'/department/getParentTreeData',
		    	loadFilter: function(data){    
		            if (data.d){    
		                return data.d;    
		            } else {    
		                return data;    
		            }    
		        }    

		});  
		var objectcmd = {
			addDepartment : function() {
// 				console.debug('add')
				departmentDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加部门');
				departmentForm.form('clear');
				//默认添加的部门状态为正常
				$("#state").prop("checked", true);
				
			},
			editDepartment : function() {
// 				console.debug('edit')
				var row = departmentDatagrid.datagrid('getSelected');
				console.debug(row);
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				departmentDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改部门');
				departmentForm.form('clear');
				//回显数据
				$('#cc').combotree({
					url : '/department/getParentTreeData',
				});
				if (row.parent) {

					$('#cc').combotree('setValue', row.parent.id);
				}
// 				console.debug(row.manager.id+"fsfafsa");
				if(row.manager){
					row['manager.id']=row.manager.id;
				}
				departmentForm.form('load', row);
			},
			deleteDepartment : function() {
// 				console.debug('delete')
				var row = departmentDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一条数据停用!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要停用吗?', function(r) {
					if (r) {
						$.post('/department/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								departmentDatagrid.datagrid('reload'); // reload the user data
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
			},
			saveDepartment : function() {
				departmentForm.form('submit', {
					url : "/department/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								departmentDialog.dialog('close'); // close the dialog
								departmentDatagrid.datagrid('reload'); // reload the user data
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
			cancelDepartment : function() {
				departmentDialog.dialog('close');
			},
			searchDepartment:function(){//普通查询
				
			departmentDatagrid.datagrid('load',$("#searchDepartmentFrom").serializeJSON());
			},
			clearDepartment:function(){//普通查询清除
				$("#searchDepartmentFrom").form("clear");
// 				$("#state").append("<option value='-1'>--请选择--</option>");
				location.reload();
			},
			advancedSearchDepartment:function(){//打开高级搜索
				$("#AdvancedSearchForm").form("clear");
				$('#advancedSearchDepartmentcc').combotree({
					url : '/department/getParentTreeData',
				});
				departmentAdvancedSearchDialog.dialog('open').dialog('center');
			},
			advancedSearchDepartmentsave:function(){//高级搜索提交按钮
// 				reload跟load的区别在 reload 是保留当前数据进行加载,而load则是重新加载
				departmentDatagrid.datagrid('load',$("#AdvancedSearchForm").serializeJSON());	
				
			},
			cancelSearchDepartment:function(){//取消高级搜索关闭界面
				departmentAdvancedSearchDialog.dialog('close');
			},resetSearchDepartment:function(){ //重置高级搜索的条件
				$("#AdvancedSearchForm").form("clear");
			}
		};
		$("a").click(function() {
			var cmd = $(this).data('cmd');
			if(cmd){
			objectcmd[cmd]();
			}

		});
		$('#cc').tree({
			url : '/department/getParentTreeData',
			
		});
		$('#tt').tree({
			onClick:function(node){
// 				var id = node.id;
// 				console.debug(id);
				if(node.attributes && node.attributes.dirPath){
					var dirPath=node.attributes.dirPath;
					console.debug(dirPath )
				departmentDatagrid.datagrid("load",
						{dirPath:dirPath
					});
				}
			}
		});


	});
</script>
</head>
<body  >
    <div class="easyui-layout" fit="true">
<!--     部门树列表 -->
        <div data-options="region:'west',split:true" title="部门树" style="width:120px;">
       <ul id="tt" class="easyui-tree">   
    
</ul>
        </div>
        
<!--         部门列表 -->
        <div data-options="region:'center',iconCls:'icon-list'">
        <table id="departmentDatagrid" title="部门列表" class="easyui-datagrid"
		fit="true" url="/department/json" singleSelect="true" striped="true"
		toolbar="#toolbar" pagination="true" rownumbers="false"
		fitColumns="true" singleS elect="true">
		<thead>
			<tr>
				<th field="name" width="50" sortable="true">部门名称</th>
				<th field="sn" width="50" sortable="true">部门编号</th>
				<th field="dirPath" width="50" sortable="true">部门路径</th>
				<th field="state" width="50" formatter="stateFormatter"
					sortable="true">状态</th>
				<th field="manager" width="50" formatter="nameFormatter"
					sortable="true">部门经理</th>
				<th field="parent" width="50" formatter="nameFormatter"
					sortable="true">上级部门</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a data-cmd="addDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add">添加</a> <a
			data-cmd="editDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-edit">修改</a> 
			
<%-- 			<c:if test="${crm:permission('部门停用','部门管理')}"> --%>
			<a
			data-cmd="deleteDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-remove">停用</a>
<%-- 			</c:if> --%>
			<form id="searchDepartmentFrom" action="#" method="POST">
			关键字: <input type="text" name="q" size="15">
			状态:<select id="state" name="state">
			<option value="-1">--请选择--</option>
			<option value="0">正常</option>
			<option value="1">停用</option>
			</select>
			<a
			data-cmd="searchDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a
			data-cmd="advancedSearchDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
			</form>
	</div>
	<div id="departmentDialog" title="对话框" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#departmentDialogButtons">
		<form id="departmentForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id" />
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">部门信息</div>
			<div style="margin-bottom: 10px">
				<input name="name" class="easyui-textbox" required="true"
					label="部门名称" style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sn" class="easyui-textbox" required="true" label="部门编号"
					style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dirPath" class="easyui-textbox" label="部门路径"
					style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				状态:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input id="state" type="radio" name="state" value="0">正常 <input
					type="radio" name="state" value="1">停用
			</div>
			<div style="margin-bottom: 10px">
				部门经理: 
         	   <select id="managerCombo" class="easyui-combogrid" name="manager.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'员工编号',width:50},    
                {field:'realName',title:'员工姓名',width:60},    
                {field:'tel',title:'员工电话',width:100},    
                {field:'email',title:'邮箱',width:200},    
            ]],"         
	
    >
    </select>
			</div>
			<div style="margin-bottom: 10px">
				<select id="cc" class="easyui-combotree" style="width: 200px;"
					name="parent.id" label="上级部门",required:true"></select>
			</div>
		</form>
	</div>
	<div id="departmentDialogButtons">
		<a data-cmd="saveDepartment" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelDepartment" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	
<!-- 	                                                                              高级搜索弹窗 -->
	<div id="departmentAdvancedSearchDialog" title="高级查询" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#departmentSearchDialogButtons">
		<form id="AdvancedSearchForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">部门信息</div>
			<div style="margin-bottom: 10px">
				<input name="q" class="easyui-textbox" 
					label="关键字" style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dirPath" class="easyui-textbox" label="部门路径"
					style="width: 220px">
			</div>
			<div style="margin-bottom: 10px">
				状态:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input id="advancedSearchstate" type="radio" name="state" value="0">正常 <input
					type="radio" name="state" value="1">停用
			</div>
			<div style="margin-bottom: 10px">
				部门经理: 
         	   <select id="AdvancedSearchmanagerCombo" class="easyui-combogrid" name="managerId" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'员工编号',width:50},    
                {field:'realName',title:'员工姓名',width:60},    
                {field:'tel',title:'员工电话',width:100},    
                {field:'email',title:'邮箱',width:200},    
            ]], 
	"></select>
			</div>
			<div style="margin-bottom: 10px">
				<select id="advancedSearchDepartmentcc" class="easyui-combotree" style="width: 200px;"
				name="parentId" label="上级部门",required:true"></select>
			</div>
		</form>
	</div>
	<div id="departmentSearchDialogButtons">
		<a data-cmd="advancedSearchDepartmentsave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">提交</a>
		<a data-cmd="cancelSearchDepartment" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
		<a data-cmd="resetSearchDepartment" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-reload" style="width: 90px">重置</a>
	</div>
        
        </div>
    </div>
</body>
</html>