<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单页面</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript" src="/resource/js/common.js" ></script>
<script type="text/javascript">
	$(function() {
		var orderDatagrid = $('#orderDatagrid');
		var orderDialog = $('#orderDialog');
		var orderForm = $('#orderForm');
		var customerCombogrid = $("#customerCombogrid");
		var sellerCombogrid = $("#sellerCombogrid");
		var newContract =$("#newContract");

		//grid和peger是用来将下拉表格的分页栏的多余东西删掉
		var grid = customerCombogrid.combogrid("grid");
		var pager = grid.datagrid("getPager");
		pager.pagination({
			showPageList : false,
			showRefresh : false,
			displayMsg : ""
		});
		var grid2 = sellerCombogrid.combogrid("grid");
		var pager2 = grid2.datagrid("getPager");
		pager2.pagination({
			showPageList : false,
			showRefresh : false,
			displayMsg : ""
		});
		
		var objectcmd = {
			addOrder : function() {
				console.debug('add')
				orderDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加订单');
				orderForm.form('clear');

			},
			editOrder : function() {
// 				console.debug('edit')
				var row = orderDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				orderDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改订单');
				orderForm.form('clear');
				//回显数据

				if(row.customer){
					row['customer.id']=row.customer.id;
					row['customer.name']=row.customer.name;
				}
				if(row.seller){
					row['seller.id']=row.seller.id;
					row['seller.realName']=row.seller.realName;
				}
				orderForm.form('load', row);
			},
			deleteOrder : function() {
// 				console.debug('delete')
				var row = orderDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一行数据作废!', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要作废吗?', function(r) {
					console.debug(row);
					if (row.contract) {
						$.messager.alert('提示信息', '已经生成合同的订单不能作废!', 'warning');
						return;
					}
					if (r) {
						$.post('/order/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								orderDatagrid.datagrid('reload'); // reload the user data
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
			saveOrder : function() {
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
								orderDatagrid.datagrid('reload'); // reload the user data
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
			cancelOrder : function() {
				orderDialog.dialog('close');
			},
			searchOrder:function(){//普通查询
// 		var json={};
// 		var array=$("#searchOrderFrom").serializeArray();
// 		for (var i = 0; i < array.length; i++) {
// // 			console.debug(array[i].name+"="+array[i].value)
// 			json[array[i].name]=array[i].value;
// 		}
				
				orderDatagrid.datagrid('reload',$("#searchOrderFrom").serializeJSON());
			},
			clearOrder:function(){//普通查询清除
				$("#searchOrderFrom").form("clear");
				location.reload();
			},
			newContract:function(){//由此订单生成合同
				var row = orderDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一笔订单来升级为合同!', 'warning');
					return;
				}
				if (row.contract) {
					$.messager.alert('提示信息', '此订单已经升级为合同了!', 'warning');
					return;
				}
				$.post("/order/newContract?id="+row.id, function(data){
					if (data.success) {
						location.reload();
						$.messager.alert('温馨提示', '操作成功!', 'info');
					} else {
						$.messager.alert('提示信息', '操作失败!'+data.msg, 'warning');
					}
				});
			}
		};
		$("a").click(function() {
			
			var cmd = $(this).data('cmd');
			//disabled:true按钮有禁用的效果，但是事件不能禁用,生成html的时候多了一个样式l-btn-disabled
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
				objectcmd[cmd]();
			}

		});
	});
	function clickRow(index,row){
		if (row.state == 1){
			$(".leave").linkbutton("disable");
		} else {
			$(".leave").linkbutton("enable");
		}
		
	};
</script>
</head>
<body>
	<table id="orderDatagrid" title="订单列表" class="easyui-datagrid"
		fit="true" url="/order/json" singleSelect="true" striped="true"
		toolbar="#toolbar" pagination="true" rownumbers="true"
		fitColumns="true" singleS elect="true" data-options="onClickRow:clickRow">
		<thead>
            <tr>
                <th field="sn" width="50">订单编号</th>
                <th field="customer" formatter="nameFormatter" width="50">客户</th>
                <th field="sum" width="50">订单金额</th>
                <th field="seller" formatter="nameFormatter" width="50">销售人员</th>
                <th field="signTime" width="50">签订时间</th>
                <th field="state" formatter="orderStateFormatter" width="50">状态</th>
                
            </tr>
		</thead>
	</table>
	<div id="toolbar">
		<a data-cmd="addOrder" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add">添加</a> <a
			data-cmd="editOrder" href="javascript:void(0)"
			class="easyui-linkbutton c8 leave" iconCls="icon-edit">修改</a> <a
			data-cmd="deleteOrder" href="javascript:void(0)"
			class="easyui-linkbutton c2 leave" iconCls="icon-remove">作废</a>
			<form id="searchOrderFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">&emsp;
			状态:<select id="state" name="state">
			<option value="-1">--请选择--</option>
			<option value="0">正常</option>
			<option value="1">作废</option>
			</select>&emsp;
			时间：从<input class="easyui-datebox" name="beginTime" size="15">
			到<input class="easyui-datebox" name="endTime" size="15">&emsp;
			<a
			data-cmd="searchOrder" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a
			data-cmd="clearOrder" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a
			data-cmd="newContract" href="javascript:void(0)"
			class="easyui-linkbutton c5 leave" iconCls="icon-add">生成合同</a>
			</form>
	</div>
	
	<!-- 增改需要的编辑框 -->
	<div id="orderDialog" title="对话框" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#orderDialogButtons">
		<form id="orderForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
				<input type="hidden" name="id" />
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