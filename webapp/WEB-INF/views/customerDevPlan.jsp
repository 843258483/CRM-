<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户开发计划页面</title>
<%@include file="/WEB-INF/views/common.jsp" %>
<script type="text/javascript">
	$(function() {
		var customerDevPlanDatagrid = $('#customerDevPlanDatagrid');
		var customerDevPlanAdvancedSearchDialog = $('#customerDevPlanAdvancedSearchDialog');
		var advancedSearchCustomerDevPlan =$("#advancedSearchCustomerDevPlan");
		var customerDevPlanDialog = $('#customerDevPlanDialog');
		var customerDevPlanForm = $('#customerDevPlanForm');
		var searchCustomerDevPlanFrom = $('#searchCustomerDevPlanFrom');
		var managerCombogrid = $('#managerCombogrid');
		var managerCombogrid1 = $('#managerCombogrid1');
		
		var inputRealName  = '${employeeInSession.realName}';
		var inputId  = '${employeeInSession.id}';
		
		var objectcmd = {
			addCustomerDevPlan : function() {
				console.debug('add')
				customerDevPlanDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加客户');
				customerDevPlanForm.form('clear');
				
				managerCombogrid1.combogrid('setValue', [{id : inputId,realName : inputRealName}]);
				$('#customerDevPlanName').textbox('readonly',false);
				$('#customerDevPlanAge').textbox('readonly',false);
				$('#sourceCombogrid').textbox('readonly',false);
			},
			editCustomerDevPlan : function() {
				console.debug('edit')
				var row = customerDevPlanDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				customerDevPlanDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改客户资料');
				customerDevPlanForm.form('clear');
				//回显数据
				if(row.potentialCustomer){
					row['potentialCustomer.id']=row.potentialCustomer.id;
				}
				if(row.inputUser){
					row['inputUser.id']=row.inputUser.id;
				}
				customerDevPlanForm.form('load', row);
				managerCombogrid1.combogrid('setValue', [{id : inputId,realName : inputRealName}]);
				//修改的时候有 属性 不能被修改  调用 这个方法 能够是 属性不能被修改
				$('#customerDevPlanName').textbox('readonly');
				$('#customerDevPlanAge').textbox('readonly');
				$('#sourceCombogrid').textbox('readonly');
				
				
				
			},
			deleteCustomerDevPlan : function() {
				console.debug('delete')
				var row = customerDevPlanDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择具体删除计划!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除吗?', function(r) {
					if (r) {
						$.post('/customerDevPlan/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								customerDevPlanDatagrid.datagrid('reload'); // reload the user data
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
			saveCustomerDevPlan : function() {
				customerDevPlanForm.form('submit', {
					url : "/customerDevPlan/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								customerDevPlanDialog.dialog('close'); // close the dialog
								customerDevPlanDatagrid.datagrid('reload'); // reload the user data
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
			cancelCustomerDevPlan1 : function() {
				customerDevPlanDialog.dialog('close');
			},
			cancelCustomerDevPlan : function() {
				conlose.debug("关闭对话框");
				customerDevPlanDialog.dialog('close');
			},searchCustomerDevPlan:function(){  //提交普通查询表单 .  这里传的参数是q
				customerDevPlanDatagrid.datagrid('reload',$("#searchCustomerDevPlanFrom").serializeJSON());
			},clearCustomerDevPlan:function(){ //普通查询 清空 查询表单
				$("#searchCustomerDevPlanFrom").form("clear");
				$("#checkState").val(-2);
				
				
			},advancedSearchCustomerDevPlan:function(){
				$("#AdvancedSearchForm").form("clear");
				customerDevPlanAdvancedSearchDialog.dialog('open').dialog('center');
			},advancedSearchCustomerDevPlan:function(){//打开高级搜索
				$("#AdvancedSearchForm").form("clear");
				customerDevPlanAdvancedSearchDialog.dialog('open').dialog('center');
			},cancelCustomerDevPlan:function(){	//高级查询  弹窗 关闭
				customerDevPlanAdvancedSearchDialog.dialog('close')
			},customerDevPlanAdvanced:function(){
				customerDevPlanDatagrid.datagrid('reload',$("#AdvancedSearchForm").serializeJSON());
			},advanceResetSearch:function(){
				$("#AdvancedSearchForm").form("clear");
			}
		};
		$("a").click(function() {
			var cmd = $(this).data('cmd');
			if(cmd){
				objectcmd[cmd]();
			}
		});
	});
</script>
</head>
<body>
    <table id="customerDevPlanDatagrid" title="客户开发计划列表" class="easyui-datagrid" fit="true"
            url="/customerDevPlan/json"
            toolbar="#toolbar" pagination="true"
            fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th  field="id" width="30" >开发计划编号</th>
                <th field="potentialCustomer" width="50" formatter="nameFormatter">潜在客户</th>
                <th field="planSubject" width="50">开发主题</th>
                <th field="planDetails" width="50">开发计划详细</th>
                <th field="inputUser" width="50" formatter="nameFormatter">策划人</th>
                <th field="planType" width="50" formatter="nameFormatter">实施方式</th>
                <th field="planTime"  width="50" sortable="true">实施时间</th>
                <th field="inputTime" width="50" sortable="true">记录时间</th>
            </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a data-cmd="addCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add" >定制开发计划</a>
        <a data-cmd="editCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-edit" >修改开发计划</a>
        <a data-cmd="deleteCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-remove">删除开发计划</a>
   		
   		<form id="searchCustomerDevPlanFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">
			
			<a
			data-cmd="searchCustomerDevPlan" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearCustomerDevPlan" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a
			data-cmd="advancedSearchCustomerDevPlan" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
			</form>
    </div>
    
    <div id="customerDevPlanDialog" title="对话框" class="easyui-dialog" style="width:400px"
            closed="true" buttons="#dlg-buttons">
        <form id="customerDevPlanForm" method="post" novalidate style="margin:0;padding:20px 50px">
        <table cellpadding="5">
        	<input type="hidden" name="id"/>
            <div style="margin-bottom:20px;font-size:14px;border-bottom:1px solid #ccc">开发计划书</div>
       			<tr>
				<td>潜在客户:</td><td> 
         	   <select id="managerCombo" class="easyui-combogrid" name="potentialCustomer.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'name',     
            url:'/potentialCustomer/json',    
            columns:[[    
                {field:'id',title:'客户编号',width:50},    
                {field:'name',title:'客户姓名',width:60},    
            ]], 
	"></select>
				</td>
			</tr>
				
       
			<tr>
				<td>计划负责人:</td>
				<td>
				<select id="managerCombogrid" class="easyui-combogrid" name="seller.id" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'realName',    
            url:'/employee/json?departmentId='+2,    
            columns:[[    
                {field:'id',title:'技师编号',width:60},    
                {field:'realName',title:'姓名',width:100},    
                {field:'tel',title:'电话',width:120}    
            ]]    
        ">
        </select>
			</td>
			</tr>
			
	 		<tr>
	 			<td>实施方式:</td>
	 			<td>
				
				<select id="jobCombogrid" class="easyui-combogrid" name="planType.id" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json',    
            columns:[[    
                {field:'name',title:'计划名称',width:60}    
            ]]    
        ">
        </select>
        	</td>
			</tr>
			<tr>
				<td>实施时间:</td>
				<td>
            	<input  id="dd" name="planTime" type= "text" class= "easyui-datebox" required ="required"> </input>
           		</td>
           </tr> 
          <tr>
          	<td>主题:</td>
          	<td>
                <input name="planSubject" class="easyui-textbox"   style="width:220px">
              </td>
           </tr>
            
            <tr>
            	<td>实施细节:</td>
            	<td>
				<input name="planDetails" class="easyui-textbox" required="true"
					style="width:200px;height:80px;"></td>
			</tr>
			
					<tr>
				<td>录入人员:</td>
				<td>
				<select id="managerCombogrid1" class="easyui-combogrid" name="inputUser.id" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'realName', 
            readonly:true,   
            url:'/department/getEmployeeBySaleJob',    
            columns:[[    
                {field:'id',title:'技师编号',width:60},    
                {field:'realName',title:'姓名',width:100},    
                {field:'tel',title:'电话',width:120}    
            ]]    
        ">
        </select>
			</td>
			</tr>
		
		</table>
        </form>
    </div>
    
    
    <!-- 高级查询窗体 -->
    <div id="customerDevPlanAdvancedSearchDialog" title="高级查询" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#customerDevPlanDialogButtons">
		<form id="AdvancedSearchForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<div
				style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">客户信息</div>
			<div style="margin-bottom: 10px">
				<input name="q" class="easyui-textbox" 
					label="关键字" style="width: 220px">
			</div>
			
			<div style="margin-bottom: 10px">
				计划负责人:<select id="managerCombogrid" class="easyui-combogrid" name="seller" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'realName',    
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'技师编号',width:60},    
                {field:'realName',title:'姓名',width:100},    
                {field:'tel',title:'电话',width:120}    
            ]]    
        ">
        </select>
			</div>
			
		</form>
		<!-- 高级查询中的 按钮 -->
	</div>
    	<div id="customerDevPlanDialogButtons">
		<a data-cmd="customerDevPlanAdvanced" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">提交计划</a>
		<a data-cmd="advanceResetSearch" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-redo">重置</a> 
		<a data-cmd="cancelCustomerDevPlan" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
    
    
    <div id="dlg-buttons">
        <a data-cmd="saveCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="cancelCustomerDevPlan1" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"  style="width:90px">取消</a>
    </div>
</body>
</html>