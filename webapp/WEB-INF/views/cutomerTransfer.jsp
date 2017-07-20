<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户移交记录</title>
<%@include file="/WEB-INF/views/common.jsp" %>
<script type="text/javascript">
	$(function() {
		var cutomerTransferDatagrid = $('#cutomerTransferDatagrid');
		var cutomerTransferAdvancedSearchDialog = $('#cutomerTransferAdvancedSearchDialog');
		var advancedSearchCutomerTransfer =$("#advancedSearchCutomerTransfer");
		var cutomerTransferDialog = $('#cutomerTransferDialog');
		var cutomerTransferForm = $('#cutomerTransferForm');
		var searchCutomerTransferFrom = $('#searchCutomerTransferFrom');
		var managerCombogrid = $('#managerCombogrid');
		
		var objectcmd = {
			addCutomerTransfer : function() {
				console.debug('add')
				cutomerTransferDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加客户');
				cutomerTransferForm.form('clear');
				$('#cutomerTransferName').textbox('readonly',false);
				$('#cutomerTransferAge').textbox('readonly',false);
				$('#sourceCombogrid').textbox('readonly',false);
			},
			editCutomerTransfer : function() {
				console.debug('edit')
				var row = cutomerTransferDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				cutomerTransferDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改客户资料');
				cutomerTransferForm.form('clear');
				//回显数据
				if(row.potentialCustomer){
					row['potentialCustomer.id']=row.potentialCustomer.id;
				}
			
				if(row.inputUser){
					row['inputUser.id']=row.inputUser.id;
				}
				cutomerTransferForm.form('load', row);
				
				//修改的时候有 属性 不能被修改  调用 这个方法 能够是 属性不能被修改
				$('#cutomerTransferName').textbox('readonly');
				$('#cutomerTransferAge').textbox('readonly');
				$('#sourceCombogrid').textbox('readonly');
				
				
				
			},
			deleteCutomerTransfer : function() {
				console.debug('delete')
				var row = cutomerTransferDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择具体删除计划!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除吗?', function(r) {
					if (r) {
						$.post('/cutomerTransfer/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								cutomerTransferDatagrid.datagrid('reload'); // reload the user data
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
			saveCutomerTransfer : function() {
				cutomerTransferForm.form('submit', {
					url : "/cutomerTransfer/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//                 var result = eval('('+result+')');
						try {
							var result = JSON.parse(result);
							if (result.success) {
								cutomerTransferDialog.dialog('close'); // close the dialog
								cutomerTransferDatagrid.datagrid('reload'); // reload the user data
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
			cancelCutomerTransfer1 : function() {
				cutomerTransferDialog.dialog('close');
			},
			cancelCutomerTransfer : function() {
				conlose.debug("关闭对话框");
				cutomerTransferDialog.dialog('close');
			},searchCutomerTransfer:function(){  //提交普通查询表单 .  这里传的参数是q
				cutomerTransferDatagrid.datagrid('reload',$("#searchCutomerTransferFrom").serializeJSON());
			},clearCutomerTransfer:function(){ //普通查询 清空 查询表单
				$("#searchCutomerTransferFrom").form("clear");
				$("#checkState").val(-2);
				
				
			},advancedSearchCutomerTransfer:function(){
				$("#AdvancedSearchForm").form("clear");
				cutomerTransferAdvancedSearchDialog.dialog('open').dialog('center');
			},advancedSearchCutomerTransfer:function(){//打开高级搜索
				$("#AdvancedSearchForm").form("clear");
				cutomerTransferAdvancedSearchDialog.dialog('open').dialog('center');
			},cancelCutomerTransfer:function(){	//高级查询  弹窗 关闭
				cutomerTransferAdvancedSearchDialog.dialog('close')
			},cutomerTransferAdvanced:function(){
				cutomerTransferDatagrid.datagrid('reload',$("#AdvancedSearchForm").serializeJSON());
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
    <table id="cutomerTransferDatagrid" title="客户列表" class="easyui-datagrid" fit="true"
            url="/cutomerTransfer/json"
            toolbar="#toolbar" pagination="true"
            fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th  field="id" width="50" sortable="true">编号</th>
                <th field="transTime" width="50" sortable="true">移交时间</th>
                <th field="customer" width="50" formatter="nameFormatter">移交的客户</th>
                <th field="transReason" width="50">移交的原因</th>
                <th field="oldSeller" width="50" formatter="nameFormatter">老客服</th>
                <th field="newSeller" width="50" formatter="nameFormatter">新客服</th>
                <th field="transUser"  width="50" formatter="nameFormatter">实施移交人</th>
            </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a data-cmd="addCutomerTransfer" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add" >增加移交记录</a>
        <a data-cmd="deleteCutomerTransfer" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-remove">删除移交记录</a>
   		
   		<form id="searchCutomerTransferFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">
			<a
			data-cmd="searchCutomerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearCutomerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a
			data-cmd="advancedSearchCutomerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
			</form>
    </div>
    
    	<div id="cutomerTransferDialog" title="客户移交表" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#dlg-buttons">
			    <form id="cutomerTransferForm" method="post">
	    	<table cellpadding="5" align="center">
	    		
	    		<tr>
	    			<td>移交的客户:</td>
	    			<td><select  class="easyui-combogrid" name="customer.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'name',     
            url:'/customer/json',    
            columns:[[    
                {field:'id',title:'客户编号',width:15},    
                {field:'name',title:'客户姓名',width:15},    
            ]],
	"></select></td>
	    		</tr>
	    		<tr>
	    			<td>老销售:</td>
	    			<td><select  class="easyui-combogrid" name="oldSeller.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'业务员编号',width:50},    
                {field:'realName',title:'业务员姓名',width:60},    
            ]],
	"></select></input></td>
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
	    				<select  id="newSellerCombo" class="easyui-combogrid" name="newSeller.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'业务员编号',width:50},    
                {field:'realName',title:'业务员姓名',width:60},    
            ]],
	"></select>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>实施移交人员:</td>
	    			<td>
	    				<select  id="newSellerCombo" class="easyui-combogrid" name="transUser.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'realName',     
            url:'/employee/json',    
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

    
    
    <!-- 高级查询窗体 -->
    <div id="cutomerTransferAdvancedSearchDialog" title="高级查询" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#cutomerTransferDialogButtons">
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
    	<div id="cutomerTransferDialogButtons">
		<a data-cmd="cutomerTransferAdvanced" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">提交计划</a>
		<a data-cmd="advanceResetSearch" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-redo">重置</a> 
		<a data-cmd="cancelCutomerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
    
    
    <div id="dlg-buttons">
        <a data-cmd="saveCutomerTransfer" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="cancelCutomerTransfer1" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"  style="width:90px">取消</a>
    </div>
</body>
</html>