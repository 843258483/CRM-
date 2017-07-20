<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户跟进历史页面</title>
<%@include file="/WEB-INF/views/common.jsp" %>
<script src="/resource/Highcharts/js/highcharts.js"></script>
<script src="/resource/Highcharts/js/highcharts-3d.js"></script>
<script src="/resource/Highcharts/js/modules/exporting.js"></script>

<script type="text/javascript">
	
	$(function() {
		var customerTraceHistoryDatagrid = $('#customerTraceHistoryDatagrid');
		var customerTraceHistoryDialog = $('#customerTraceHistoryDialog');
		var customerTraceHistoryForm = $('#customerTraceHistoryForm');
		var managerCombogrid = $('#managerCombogrid')
		var objectcmd = {
			addCustomer : function() {
				customerTraceHistoryDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加跟进记录');
				customerTraceHistoryForm.form('clear');
			},
			deleteCustomer : function() { //删除记录的方法
				console.debug('delete')
				var row = customerTraceHistoryDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行删除!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除吗?', function(r) {
					if (r) {
						$.post('/customerTraceHistory/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								customerTraceHistoryDatagrid.datagrid('reload'); // reload the user data
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
			},DCustomer :function(){
				$("#containerDialog").dialog('open');
			},
			saveCustomer : function() {
				customerTraceHistoryForm.form('submit', {
					url : "/customerTraceHistory/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								customerTraceHistoryDialog.dialog('close'); // close the dialog
								customerTraceHistoryDatagrid.datagrid('reload'); // reload the user data
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
			cancelCustomer : function() {
				customerTraceHistoryDialog.dialog('close');
			},searchPotentialCustomer:function(){  //提交普通查询表单 .  这里传的参数是q
				customerTraceHistoryDatagrid.datagrid('reload',$("#searchPotentialCustomerFrom").serializeJSON());
			},clearPotentialCustomer:function(){  //普通查询 清空
				$("#searchPotentialCustomerFrom").form("clear");
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
    <table id="customerTraceHistoryDatagrid" title="客户跟进历史" class="easyui-datagrid" fit="true"
            url="/customerTraceHistory/json"
            toolbar="#toolbar" pagination="true"
            fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="id" width="50" sortable=true>编号</th>
                <th field="traceTime" width="50" sortable=true>跟进日期</th>
                <th field="customer" width="50" formatter="nameFormatter">跟进客户</th>
                <th field="traceUser" width="50" formatter="nameFormatter">跟进负责人</th>
                <th field="traceType" width="50" formatter="nameFormatter">跟进方式</th>
                <th field="title" width="50">跟进主题</th>
                <th field="remark" width="50">跟进细节</th>
            </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a data-cmd="addCustomer" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add" >添加</a>
        <a data-cmd="deleteCustomer" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-remove">删除</a>
    </div>
    
      	<div id="customerTraceHistoryDialog" title="客户跟进计划" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#dlg-buttons">
			    <form id="customerTraceHistoryForm" method="post">
	    	<table cellpadding="5" align="center">
	    		
	    		<tr>
	    			<td>跟进客户:</td>
	    			<td><select   class="easyui-combogrid" name="customer.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'name',     
            url:'/customer/json',    
            columns:[[    
                {field:'id',title:'客户编号',width:10,sortable:true},    
                {field:'name',title:'客户姓名',width:10},    
                {field:'state',title:'客户状态',width:10},    
            ]],
	"></select></td>
	    		</tr>
	    		<tr>
	    			<td>跟进时间:</td>
	    			<td><input  name="traceTime" type= "text" class= "easyui-datebox" required ="required"></td>
	    		</tr>
	    		<tr>
	    			<td>跟进人员:</td>
	    			<td>
	    				<select   class="easyui-combogrid" name="traceUser.id" style="width:180px;"  
        data-options="    
            panelWidth:150,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'业务员编号',width:10,sortable:true},    
                {field:'realName',title:'业务员姓名',width:10},    
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
            url:'/systemDictionaryItem/json?parentId',  
            columns:[[    
                {field:'name',title:'跟进方式',width:60},    
            ]],">
            </select>
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
    <div id="dlg-buttons">
        <a data-cmd="saveCustomer" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="cancelCustomer" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"  style="width:90px">取消</a>
    </div>
    
   <div id="containerDialog" title="对话框" class="easyui-dialog" width="615px" closed="true">
	<div id="container" style="height: 400px"></div>
</div>
    
</body>
</html>