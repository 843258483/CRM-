<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户页面</title>
<%@include file="/WEB-INF/views/common.jsp" %>
<script type="text/javascript">
	$(function() {
		var customerDatagrid = $('#customerDatagrid');
		var customerAdvancedSearchDialog = $('#customerAdvancedSearchDialog');
		var advancedSearchCustomer =$("#advancedSearchCustomer");
		var customerDialog = $('#customerDialog');
		var customerForm = $('#customerForm');
		var searchCustomerFrom = $('#searchCustomerFrom');
		var orderDialog = $('#orderDialog');  //保存订单的 弹出框
		var orderForm = $('#orderForm');  //保存订单的 表单
		var managerCombogrid = $('#managerCombogrid');
		var cutomerTransferDialog = $('#cutomerTransferDialog'); //客户移交窗体
		var cutomerFollowUpDialog = $('#cutomerFollowUpDialog');  //客户跟进窗体
		var cutomerTransferForm = $("#cutomerTransferForm");	//客户移交表单
		var cutomerFollowUpForm = $("#cutomerFollowUpForm");  //客户跟进表单
		var managerCombo1 = $("#managerCombo1");  //录入用户 的下拉框  需要设置当前的用户
		var inputRealName  = '${employeeInSession.realName}';
		var inputId  = '${employeeInSession.id}';
		
		
		var objectcmd = {
			addCustomer : function() {
				console.debug('add')
				customerDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加客户');
				customerForm.form('clear');
				managerCombogrid.textbox('readonly',false);
				$('#customerName').textbox('readonly',false);
				$('#customerAge').textbox('readonly',false);
				$('#sourceCombogrid').textbox('readonly',false);
				managerCombo1.combogrid('setValue', [{id:inputId,realName:inputRealName}]);
			},CustomerToVIP:function(){
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一位客户升级为VIP!', 'warning');
					return;
				}
				if(row.state!=0&&row.state!=-1){
					$.messager.alert('提示信息', '无需升级', 'warning');
					return;
				}
				$.post('/customer/toVIP', {
					id : row.id
				}, function(result) {
					if (result.success) {
						customerDatagrid.datagrid('reload'); // reload the user data
					} else {
						$.messager.show({
							title : '错误信息',
							msg : "<font color='red'>" + result.message+ "</font>",
							showType : 'fade',
							style : {
								right : '',
								bottom : ''
							}
						});

					}
				}, 'json');
			},
			addOrder : function() {   //订单的弹出框
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一位 签订订单的客户!', 'warning');
					return;
				}
				orderDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加订单');
				orderForm.form('clear');
				orderForm.form('load', row);
				
				$("#sellerCombogrid").combogrid('setValue', [{id:inputId,realName:inputRealName}]);
				$("#customerCombogrid").combogrid('setValue', [{id:row.id,name:row.name}]);
			},cancelOrder:function(){  //订单取消功能
				orderDialog.dialog('close')
			},saveOrder : function() {  //订单保存功能
				orderForm.form('submit', {
					url : "/order/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						console.debug(result);
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								orderDialog.dialog('close'); // close the dialog
								customerDatagrid.datagrid('reload'); // reload the user data
								$.messager.show({
									title:'订单信息',
									msg:'订单保存成功',
									showType:'show',
									style:{
										right:'',
										top:document.body.scrollTop+document.documentElement.scrollTop,
										bottom:''
									}
								});

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
			editCustomer : function() {
				console.debug('edit')
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				customerDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改客户资料');
				customerForm.form('clear');
				//回显数据
				if(row.seller){
					row['seller.id']=row.seller.id;
				}
				if(row.customerSource){
					row['customerSource.id']=row.customerSource.id;
				}
				if(row.salaryLevel){
					row['salaryLevel.id']=row.salaryLevel.id;
				}
				if(row.job){
					row['job.id']=row.job.id;
				}
				if(row.inputUser){
					row['inputUser.id']=row.inputUser.id;
				}
				//客户修改页面 , 有些值不希望被修改 需要添加这个 属性让他不能修改
				customerForm.form('load', row);
				$('#customerName').textbox('readonly');
				$('#customerAge').textbox('readonly');
				$('#sourceCombogrid').textbox('readonly');
				managerCombo1.combogrid('setValue', [{id:inputId,realName:inputRealName}]);
				managerCombogrid.textbox('readonly');
			},
			deleteCustomer : function() {
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行删除!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除吗?', function(r) {
					if (r) {
						$.post('/customer/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								customerDatagrid.datagrid('reload'); // reload the user data
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
			},changeCustomer:function(){
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择具体的客户进行移交!', 'warning');
					return;
				}
				if (row.state==-1) {
					$.messager.alert('提示信息', '销售人员都没有移交个毛啊! 直接跟进', 'warning');
					return;
				}
				cutomerTransferDialog.dialog('open');
				cutomerTransferForm.form("clear");
				//!--手动加载  用户移交 数据
				$("#transUserCombo").combogrid('setValue', [{id:inputId,realName:inputRealName}]);
				cutomerTransferForm.form('load', {'customer.id':row.id,customerName:row.name,oldSellerName:row.seller.realName,'oldSeller.id':row.seller.id});
			},saveCutomerTransfer:function(){
				//移交客户 , 要改变 客户现在的销售员 ,  同时 要在 客户移交记录 表里面增加一条 移交数据
				cutomerTransferForm.form('submit', {
					url : "/customer/cutomerTransfer",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								cutomerTransferDialog.dialog('close'); // close the dialog
								customerDatagrid.datagrid('reload'); // reload the user data
								$.messager.alert('提示信息', '移交成功', 'warning');
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
			},saveCutomerFollowUp:function(){ //提交 客户跟进 表单
				cutomerFollowUpForm.form('submit', {
					url : "/customer/cutomerFollowUp",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						try {
							var result = JSON.parse(result);
							if (result.success) {
								cutomerFollowUpDialog.dialog('close'); // close the dialog
								customerDatagrid.datagrid('reload'); // reload the user data
								$.messager.alert('提示信息', '客户跟进历史录入成功', 'warning');
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
			cancelCutomerTransfer:function(){  //关闭 客户移交 窗体
				cutomerTransferDialog.dialog('close');
			},cancelCutomerFollowUp:function(){  //关闭 客户跟进窗体 
				cutomerFollowUpDialog.dialog('close');
			},
			saveCustomer : function() {
				customerForm.form('submit', {
					url : "/customer/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
// 						   var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								customerDialog.dialog('close'); // close the dialog
								customerDatagrid.datagrid('reload'); // reload the user data
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
			cancelCustomer1 : function() {
				customerDialog.dialog('close');
			},
			cancelCustomer : function() {
				conlose.debug("关闭对话框");
				customerDialog.dialog('close');
			},searchCustomer:function(){  //提交普通查询表单 .  这里传的参数是q
				customerDatagrid.datagrid('reload',$("#searchCustomerFrom").serializeJSON());
			},clearCustomer:function(){ //普通查询 清空 查询表单
				$("#searchCustomerFrom").form("clear");
				$("#checkState").val(-2);
			},advancedSearchCustomer:function(){//打开高级搜索
				$("#AdvancedSearchForm").form("clear");
				$("#salaryLevelserch").combogrid('setValue', [{id:-2,'name':'请选择'}]);;
				$("#jobserch").combogrid('setValue', [{id:-2,'name':'请选择'}]);;
				customerAdvancedSearchDialog.dialog('open').dialog('center');
			},cancelCustomer:function(){	//高级查询  弹窗 关闭
				customerAdvancedSearchDialog.dialog('close')
			},
			customerAdvanced:function(){
				customerDatagrid.datagrid('reload',$("#AdvancedSearchForm").serializeJSON());
			},advanceResetSearch:function(){
				$("#AdvancedSearchForm").form("clear");
			},
			followingCustomer:function(){
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择具体的客户进行跟进!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要跟进吗?', function(r) {  //这里跟进的  人应该 是登录的用户
					if(r){
						cutomerFollowUpDialog.dialog('open');
						cutomerFollowUpForm.form("clear");
						$("#traceUserName").combogrid('setValue', [{id:inputId,realName:inputRealName}]);
						cutomerFollowUpForm.form('load',{'customer.id':row.id,customerName:row.name});
					}
				});
				
			},giveUpCustomer:function(){
				var row = customerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择具体客户放入资源池!', 'warning');
					return;
				}
				if(row.state==-1){
					$.messager.alert('提示信息', '确认更改?', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定放入吗?', function(r) {
					if (r) {
						$.post('/customer/giveUp', {
							id : row.id
						}, function(result) {
							if (result.success) {
								customerDatagrid.datagrid('reload'); // reload the user data
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
    <table id="customerDatagrid" title="客户列表" class="easyui-datagrid" fit="true"
            url="/customer/json"
            toolbar="#toolbar" pagination="true"
            rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
<!--                 <th  field="id" width="50" >客户编号</th> -->
                <th  field="name" width="50" >客户姓名</th>
                <th field="gender" formatter="genderFormatter" width="50">客户性别</th>
                <th field="age" width="50">年龄</th>
                <th field="tel" width="50">电话</th>
                <th field="seller" width="50" formatter="nameFormatter">销售人员</th>
                <th field="job" width="50" formatter="nameFormatter">客户工作</th>
                <th field="customerSource" width="50" formatter="nameFormatter">客户来源</th>
                <th field="salaryLevel" width="50" formatter="nameFormatter">收入等级</th>
                <th field="email" width="50">邮箱</th>
                <th field="qq" width="50">邮箱</th>
                <th field="wechat" width="50">微信</th>
                <th field="inputTime" width="50">记录时间</th>
                <th field="state" width="50" formatter="customerFormatter">状态</th>
            </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a data-cmd="addCustomer" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-add" >添加</a>
        <a data-cmd="editCustomer" href="javascript:void(0)" class="easyui-linkbutton c4" iconCls="icon-edit" >修改</a>
        <a data-cmd="deleteCustomer" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-remove">删除</a>
        
        <a
			data-cmd="addOrder" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add">生成订单</a>
        
   		<a
			data-cmd="followingCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-redo">客户跟进</a>
		<a
			data-cmd="changeCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-redo">客户移交</a>
			
		<a data-cmd="giveUpCustomer" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-undo">放入资源池</a>
		<a data-cmd="CustomerToVIP" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-redo">升级VIP</a>
   		<form id="searchCustomerFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">
			状态:<select name="state" id="checkState">
			<option value="-2">--请选择--</option>
			<option value="0">跟进中</option>
			<option value="-1">资源池</option>
			<option value="1">vip</option>
			</select>
			<a
			data-cmd="searchCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a
			data-cmd="advancedSearchCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
			</form>
   			
    </div>
    <div id="customerDialog" title="对话框" class="easyui-dialog" style="width:400px"
            closed="true" buttons="#dlg-buttons">
        <form id="customerForm" method="post" novalidate style="margin:0;padding:20px 50px">
        	<div><input type="hidden" name="id"/></div>
            <div style="margin-bottom:20px;font-size:14px;border-bottom:1px solid #ccc">客户信息</div>
            <div style="margin-bottom:10px">
                <input id="customerName" name="name" class="easyui-textbox" required="true" label="客户姓名" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input id="customerAge" name="age" class="easyui-textbox" required="true"  type="number" label="客户年龄" style="width:220px" >
            </div>
            <div style="margin-bottom:10px">
                <input name="tel" class="easyui-textbox" required="true" label="电话" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="email" class="easyui-textbox"  label="邮箱" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="qq" class="easyui-textbox"  label="qq" style="width:220px">
            </div>
            <div style="margin-bottom:10px">
                <input name="wechat" class="easyui-textbox"  label="微信" style="width:220px">
            </div>
            <div style="margin-bottom: 10px">
				性别:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
					id="gender" type="radio" name="gender" value="1">男 <input type="radio" name="gender" value="0">女
			</div>
			<div class="fitem">
				<label>营销人员:</label>
					<input id="managerCombogrid" class="easyui-combobox" name="seller.id"  style="width: 150px;"
   					   data-options="valueField:'id',textField:'realName',url:'/department/getEmployeeBySaleJob'" />
			</div>
			
	 		<div class="fitem">
				<label>客户工作:</label>
				<select id="jobCombogrid" class="easyui-combogrid" name="job.id" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json',    
            columns:[[    
                {field:'name',title:'工作名称',width:60}    
            ]]    
        ">
        </select>
			</div>
			
		<div class="fitem">
				<label>客户来源:</label>
				<select id="sourceCombogrid" class="easyui-combogrid" name="customerSource.id" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json',    
            columns:[[    
                {field:'name',title:'详细',width:60},    
            ]]    
        ">
        </select>
        </div>
        
		<div class="fitem">
				<label>客户薪资:</label>
				<select id="salaryLevelCombogrid" class="easyui-combogrid" name="salaryLevel.id" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json',    
            columns:[[    
                {field:'name',title:'薪资等级',width:60}    
            ]]    
        ">
        </select>
	</div>
	<div class="fitem">
				<label>录入人员:</label>
				<select id="managerCombo1" class="easyui-combogrid" name="inputUser.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            readonly:true,
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
            columns:[[    
                {field:'realName',title:'来源信息',width:60},    
            ]], 
	"></select>
			</div>
			
        </form>
    </div>
    
    
    <!-- 高级查询窗体 -->
    <div id="customerAdvancedSearchDialog" title="高级查询" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#customerDialogButtons">
		<form id="AdvancedSearchForm" method="post" novalidate>
			<table  cellpadding="10" align="left">
				<tr><td>关键字:<td><td><input name="q" class="easyui-textbox" style="width: 220px"><td></tr>
				<tr><td>年龄:<td><td><input class="easyui-slider" name="maxAge" style="width:250px"   
        data-options="showTip:true,rule:[0,'|',25,'|',50,'|',75,'|',100]" /><td></tr>
        
				<tr><td>录入时间:<td><td><input name="inputTimes" type= "text" class= "easyui-datebox" required ="required"> </input><td></tr>
				<tr><td>收入等级:<td><td><select id="salaryLevelserch" class="easyui-combogrid" name="salaryLevelId" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json',    
            columns:[[    
                {field:'name',title:'薪资等级',width:60}    
            ]]    
        ">
        </select><td></tr>
				<tr><td>客户工作:<td><td><select id="jobserch" class="easyui-combogrid" name="jobId" style="width: 150px;"
					data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json',    
            columns:[[    
                {field:'name',title:'薪资等级',width:60}    
            ]]    
        ">
        </select><td></tr>
			</table>
		</form>
		<!-- 高级查询中的 按钮 -->
	</div>
    	<div id="customerDialogButtons">
		<a data-cmd="customerAdvanced" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">提交</a>
		<a data-cmd="advanceResetSearch" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-redo">重置</a> 
		<a data-cmd="cancelCustomer" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
    
    
    <div id="dlg-buttons">
        <a data-cmd="saveCustomer" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="cancelCustomer1" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"  style="width:90px">取消</a>
    </div>
    	<!-- 客户移交弹窗 -->
    	<div id="cutomerTransferDialog" title="客户移交信息" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#cutomerTransferDialogButtons">
			    <form id="cutomerTransferForm" method="post">
	    	<table cellpadding="5" align="center">
	    		<tr>
	    			<td></td>
	    			<td><input class="easyui-textbox" type="hidden" name="customer.id" ></input></td>
	    		</tr>
	    		<tr>
	    			<td></td>
	    			<td><input class="easyui-textbox" type="hidden" name="oldSeller.id" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>客户:</td>
	    			<td><input class="easyui-textbox" type="text" name="customerName" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>老销售:</td>
	    			<td><input  name="oldSellerName" type= "text" style="width:120" class= "easyui-textbox" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>移交时间:</td>
	    			<td><input  name="transTime" type= "text" class= "easyui-datebox" required ="required"></td>
	    		</tr>
	    		<tr>
	    			<td>移交原因:</td>
	    			<td><input class="easyui-textbox" name="transReason" data-options="multiline:true" style="height:60px"></input></td>
	    		</tr>
	    		<tr>
	    			<td>新销售:</td>
	    			<td>
				<input class="easyui-combobox" name="newSeller.id"  style="width: 180px;"
   					   data-options="valueField:'id',textField:'realName',url:'/department/getEmployeeBySaleJob'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>实施移交人员:</td>
	    			<td>
	    				<select  id="transUserCombo" class="easyui-combogrid" name="transUser.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            readonly:true,
            mode:'remote',   
            textField:'realName',     
            url:'/department/getEmployeeBySaleJob',    
            columns:[[    
                {field:'id',title:'业务员编号',width:50},    
                {field:'realName',title:'业务员姓名',width:60},    
            ]],
	"></select>
	    			</td>
	    		</tr>
	    		
	    	</table>
	    </form>
	</div>
	
	   	<!-- 客户跟进窗体 -->
    	<div id="cutomerFollowUpDialog" title="客户跟进历史" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#cutomerFollowUpDialogButtons">
			    <form id="cutomerFollowUpForm" method="post">
	    	<table cellpadding="5" align="center">
	    		<tr>
	    			<td></td>
	    			<td><input class="easyui-textbox" type="hidden" name="customer.id" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>跟进客户:</td>
	    			<td><input class="easyui-textbox" type="text" name="customerName" readonly="readonly"></input></td>
	    		</tr>
	    		<tr>
	    			<td>跟进时间:</td>
	    			<td><input  name="traceTime" type= "text" class= "easyui-datebox" required ="required"></td>
	    		</tr>
	    		<tr>
	    			<td>跟进人员:</td>
	    			<td>
	    				<select  id="traceUserName" class="easyui-combogrid" name="traceUser.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote', 
            readonly:true,  
            textField:'realName',     
            url:'/department/getEmployeeBySaleJob',    
            columns:[[    
                {field:'id',title:'业务员编号',width:20},    
                {field:'realName',title:'业务员姓名',width:20},    
            ]],
	"></select>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>跟进方式:</td>
	    			<td>
	    				<select  id="newSellerCombo" class="easyui-combogrid" name="traceType.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'name',     
            url:'/systemDictionaryItem/json',  
            columns:[[    
                {field:'name',title:'跟进方式',width:60},    
            ]],
	"></select>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>跟进主题:</td>
	    			<td><input class="easyui-textbox" type="text" name="title" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>跟进细节:</td>
	    			<td><input class="easyui-textbox" name="remark" data-options="multiline:true" style="height:60px"></input></td>
	    		</tr>
	    		<tr>
	    			<td>跟进效果:</td>
	    			<td><select id="cc" class="easyui-combobox" name="traceResult" style="width:200px;">   
							    <option value="1">好</option>   
							    <option value="0">中</option>   
							    <option value="-1">差</option>   
							</select></td>
	    		</tr>
	    		
	    	</table>
	    </form>
	</div>
	
	
    <div id="cutomerTransferDialogButtons">
		<a data-cmd="saveCutomerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelCutomerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	<div id="cutomerFollowUpDialogButtons">
		<a data-cmd="saveCutomerFollowUp" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelCutomerFollowUp" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
    
    
    	<!-- 增改需要的编辑框 -->
	<div id="orderDialog" title="对话框" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#orderDialogButtons">
		<form id="orderForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<div style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">订单信息</div>
			<div style="margin-bottom: 10px">
				<input name="sum" class="easyui-textbox" required="true" label="订单金额:" style="width: 250px">
			</div>
			<div style="margin-bottom: 10px">
				<input name="signTime" class="easyui-datebox" label="录入时间:" style="width: 250px">
			</div>
			
			<div style="margin-bottom: 10px">
				<select id="customerCombogrid" class="easyui-combogrid" required="true" name="customer.id" style="width: 250px;" label="客户姓名:"
					data-options="    
            panelWidth:450,    
            idField:'id',    
            textField:'name',    
            pagination:true,
            readonly:true,
            mode:'remote',
            url:'/customer/json',    
            columns:[[    
                {field:'name',title:'姓名',width:60},    
                {field:'tel',title:'电话',width:60},    
                {field:'qq',title:'QQ',width:100},    
                {field:'email',title:'邮箱',width:200}    
            ]]    
        "></select></div>
        <div style="margin-bottom: 10px">
				<select id="sellerCombogrid" class="easyui-combogrid" name="seller.id" style="width: 250px;" label="销售人员:"
					data-options="    
            panelWidth:450,    
            idField:'id',    
            textField:'realName',    
            pagination:true,
            mode:'remote',
            url:'/department/getEmployeeBySaleJob',    
            columns:[[    
                {field:'username',title:'用户名',width:60},    
                {field:'realName',title:'姓名',width:60},    
                {field:'tel',title:'电话',width:100},    
                {field:'email',title:'邮箱',width:200}    
            ]]    
        "></select>
			</div>
		</form>
	</div>
	<div id="orderDialogButtons">
		<a data-cmd="saveOrder" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelOrder" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
    
    
</body>
</html>