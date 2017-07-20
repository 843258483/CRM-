<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>潜在客户页面</title>
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript">
	$(function() {
		var potentialCustomerDatagrid = $('#potentialCustomerDatagrid');
		var potentialCustomerDialog = $('#potentialCustomerDialog');
		var potentialCustomerForm = $('#potentialCustomerForm');
		var managerCombo = $("#managerCombo");
		var managerCombo1 = $("#managerCombo1");
		var advancedSearchPotentialCustomer = $("#advancedSearchPotentialCustomer");
		var potentialCustomerSearchDialog = $("#potentialCustomerSearchDialog")
		var inputRealName = '${employeeInSession.realName}';
		var inputId = '${employeeInSession.id}';
		var grid = managerCombo.combogrid("grid");
		var pager = grid.datagrid("getPager");
		var customerDialog = $("#customerDialog");
		var customerForm = $("#customerForm");
		//潜在客户开发计划表单
		var customerDevPlanForm = $("#customerDevPlanForm");
		//用户开发计划
		var customerDevPlanDialog = $("#customerDevPlanDialog");
		pager.pagination({
			showPageList : false,
			showRefresh : false,
			displayMsg : ""
		});
		var objectcmd={
			addPotentialCustomer : function(){

				potentialCustomerDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加潜在客户');
				potentialCustomerForm.form('clear');
				managerCombo1.combogrid('setValue', [{
					id : inputId,
					realName : inputRealName
				}]);
				//默认状态
				$("#state").prop("checked", true);
				$('#cc').combotree({
					url : '/potentialCustomer/getParentTreeData',
				});
			},savefieldUpload:function(){
				alert("确定上传");
			},
			addCustomerDevPlan:function(){
				var row = potentialCustomerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '亲!请选择 制定的潜在客户 定制计划!', 'warning');
					return;
				}
				customerDevPlanDialog.dialog('open').dialog('center');
				customerDevPlanForm.form('clear');
				$("#managerCombogrid1").combogrid('setValue', [{id :inputId,realName:inputRealName}]);
				$("#potentialCustomerCombo").combogrid('setValue', [{id :row.id,name:row.name}]);
				
			},
			
			editPotentialCustomer : function(){
				// 				console.debug('edit')
				var row = potentialCustomerDatagrid.datagrid('getSelected');
				console.debug(row);
				if (!row) {
					$.messager.alert('提示信息', '请选择一行修改!', 'warning');
					return;
				}
				potentialCustomerDialog.dialog('open').dialog('center').dialog(
						'setTitle', '修改潜在客户信息');
				potentialCustomerForm.form('clear');
				if(row.customerSource){
					row['customerSource.id']=row.customerSource.id;
				}
				managerCombo1.combogrid('setValue', [{
					id : inputId,
					realName : inputRealName
				}]);
				potentialCustomerForm.form('load', row);
			},
			deletePotentialCustomer : function(){
				// 				console.debug('delete')
				var row = potentialCustomerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择一条数据删除 !', 'warning');
					return;
				}
				$.messager.confirm('提示信息', '确定要删除吗?', function(r){
					if (r){
						$.post('/potentialCustomer/delete', {
							id : row.id
						}, function(result) {
							if (result.success) {
								potentialCustomerDatagrid.datagrid('reload'); // reload the user data
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
						},'json');
					}
				});
			},cancelCustomerDevPlan1 : function() {
				customerDevPlanDialog.dialog('close');
			},saveCustomerDevPlan : function() {
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
								potentialCustomerDatagrid.datagrid('reload'); // reload the user data
								$.messager.show({
									title:'成功提示',
									msg:'开发计划定制成功,已通知相关销售人员准备',
									timeout:2000,
									showType:'slide'
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
			savePotentialCustomer : function() {
				potentialCustomerForm.form('submit', {
					url : "/potentialCustomer/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						try {
							var result = JSON.parse(result);
							if (result.success) {
								potentialCustomerDialog.dialog('close'); // close the dialog
								potentialCustomerDatagrid.datagrid('reload'); // reload the user data
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
			cancelPotentialCustomer : function() { //关闭
				potentialCustomerDialog.dialog('close');
			},

			searchPotentialCustomer : function() {//普通查询
				potentialCustomerDatagrid.datagrid('reload', $("#searchPotentialCustomerFrom").serializeJSON());
			},adddownload: function(){  //	下载功能的实现
				 var url="/potentialCustomer/download?"+$("#searchPotentialCustomerFrom").serialize();
		            //alert("导出此页数据...");
		            //$.messager.alert('提示',"为兼容低版本客户,导出的文件为2003版Excel文件.","info");
			 		 window.open(url);
			},uploadfile : function(){
				$("#fieldUpload").dialog('open').dialog('center');
			},
			clearPotentialCustomer : function() {//普通查询清除
				$("#searchPotentialCustomerFrom").form("clear");
			},
			advancedSearchPotentialCustomer : function() {//打开高级搜索
				potentialCustomerSearchDialog.dialog('open').dialog('center');
				$("#potentialCustomerSearchForm").form("clear");
			},
			cancelCustomerSearch : function() { //高级表单取消
				potentialCustomerSearchDialog.dialog('close');
			},
			saveCustomerSearch : function() { //提交高级查询
				potentialCustomerDatagrid.datagrid('reload', $(
						"#potentialCustomerSearchForm").serializeJSON());
			},
			resetCustomerSearch : function() { //重置高级查询数据
				$("#potentialCustomerSearchForm").form("clear");
			},
			saveCustomerButton : function() { //提交升级 
				customerForm.form('submit', {
					url : "/potentialCustomer/upToCustomer",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						try {
							var result = JSON.parse(result);
							if (result.success) {
								customerDialog.dialog('close'); // close the dialog
								potentialCustomerDatagrid.datagrid('reload'); // reload the user data
								$.messager.alert('<font color="red">提示信息',
										'已升级 去完成生成订单吧!亲爱的' + inputRealName
												+ '同学<font>', 'alert');
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
			cancelCustomerButton : function() { // 取消升级
				customerDialog.dialog('close')
			},

			upPotentialCustomer : function() {
				var row = potentialCustomerDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '请选择要升级的潜在客户!', 'warning');
					return;
				}
				customerDialog.dialog('open').dialog('center'); //客户升级窗体弹出
				customerForm.form("clear");
				customerForm.form('load', {
					'id' : row.id,
					'name' : row.name,
					sourceName : row.customerSource.name,
					'source.id' : row.customerSource.id
				});
				$("#sellerCombogrid").combogrid('setValue', [{
					id : inputId,
					realName : inputRealName
				}]);
			}

		};
		$("a").click(function() {
			var cmd = $(this).data('cmd');
			if (cmd) {
				console.debug("-------------");
				objectcmd[cmd]();
			}
		});
	});
</script>
</head>
<body>
	<table id="potentialCustomerDatagrid" title="潜在客户列表"
		class="easyui-datagrid" fit="true" url="/potentialCustomer/json"
		singleSelect="true" striped="true" toolbar="#toolbar222"
		pagination="true" fitColumns="true" singleS
		elect="true">
		<thead>
			<tr>
				<th field="id" width="30" sortable="true">编号</th>
				<th field="name" width="50">客户姓名</th>
				<th field="successRate" width="50" sortable="true">成功率</th>
				<th field="linkMan" width="50">联系人</th>
				<th field="linkManTel" width="50">联系人电话</th>
				<th field="remark" width="50">客户的简要备注</th>
				<th field="inputTime" width="50" sortable="true">录入时间</th>
				<th field="customerSource" width="50" formatter="nameFormatter">客户来源</th>
				<th field="inputUser" width="50" formatter="nameFormatter">录入人员</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar222">
		<a data-cmd="addPotentialCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add">添加</a>
		<a data-cmd="editPotentialCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-edit">修改</a>
		<a data-cmd="deletePotentialCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-remove">删除</a>
		<a data-cmd="upPotentialCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-redo">潜在客户升级</a> 
		<a data-cmd="addCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add" >定制开发计划</a>
		<a data-cmd="adddownload" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add" >导出当前页数据</a>
		<form id="searchPotentialCustomerFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15"> <a
				data-cmd="searchPotentialCustomer" href="javascript:void(0)"
				class="easyui-linkbutton c4" iconCls="icon-search">搜索</a> <a
				data-cmd="clearPotentialCustomer" href="javascript:void(0)"
				class="easyui-linkbutton c7" iconCls="icon-cut">清空</a> <a
				data-cmd="advancedSearchPotentialCustomer" href="javascript:void(0)"
				class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
		</form>
	</div>



	<div id="potentialCustomerDialog" title="对话框" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#potentialCustomerDialogButtons">
		<form id="potentialCustomerForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<table cellpadding="5" align="center">
				<input type="hidden" name="id" />
				<div
					style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">潜在客户信息</div>
				<tr>
					<td>客户:</td>
					<td><input name="name" class="easyui-textbox" required="true"
						style="width: 220px"></td>
				</tr>
				<tr>
					<td>简要描述:</td>
					<td><input name="remark" class="easyui-textbox"
						required="true" style="width: 220px"></td>
				</tr>
				<tr>
					<td>联系人:</td>
					<td><input name="linkMan" class="easyui-textbox"
						style="width: 220px"></td>
				</tr>
				<tr>
					<td>联系人电话:</td>
					<td><input name="linkManTel" class="easyui-textbox"
						style="width: 220px"></td>
				</tr>
				<tr>
					<td>成功率:</td>
					<td><input class="easyui-slider" name="successRate"
						style="width: 220px"
						data-options="showTip:true,rule:[0,'|',25,'|',50,'|',75,'|',100]" /></td>
				</tr>
				<tr>
					<td>客户来源:</td>
					<td><select id="managerCombo" class="easyui-combogrid"
						name="customerSource.id" style="width: 180px;"
						data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            mode:'remote',   
            textField:'name',     
            url:'/systemDictionaryItem/json?parentId='+1,    
            columns:[[    
                {field:'name',title:'来源信息',width:60},    
            ]], 
	">
	</select>
		</td>
			</tr>
			
				<tr>
					<td>录入人</td>
					<td><select id="managerCombo1" class="easyui-combogrid"
						name="inputUser.id" style="width: 180px;"
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
						">
	</select>
	</td>
		</tr>
			</table>
		</form>
	</div>
	<div id="potentialCustomerDialogButtons">
		<a data-cmd="savePotentialCustomer" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelPotentialCustomer" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	<div id="CustomerSearchButton">
		<a data-cmd="saveCustomerSearch" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-search"
			style="width: 90px">搜索</a> <a data-cmd="resetCustomerSearch"
			href="javascript:void(0)" class="easyui-linkbutton c3"
			iconCls="icon-redo" style="width: 90px">重置</a> <a
			data-cmd="cancelCustomerSearch" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	<div id="potentialCustomerSearchDialog" title="高级查询"
		class="easyui-dialog" style="width: 400px" closed="true"
		buttons="#CustomerSearchButton">
		<form id="potentialCustomerSearchForm" method="post" novalidate>
			<table cellpadding="10" align="left">
				<tr>
					<td>关键字</td>
					<td><input name="q" class="easyui-textbox"
						style="width: 220px"></td>
				</tr>
				<tr>
					<td>成功率大于:</td>
					<td><input class="easyui-slider" name="maxSuccesNum"
						style="width: 300px"
						data-options="showTip:true,rule:[0,'|',25,'|',50,'|',75,'|',100]" /></td>
				</tr>
				<tr>
					<td>成功率小于:</td>
					<td><input class="easyui-slider" name="mixSuccesNum"
						style="width: 300px"
						data-options="showTip:true,rule:[0,'|',25,'|',50,'|',75,'|',100]" /></td>
				</tr>
				<tr>
					<td>客户来源:</td>
					<td><select id="sourceCombogrid" class="easyui-combogrid"
						name="sourceId" style="width: 150px;"
						data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json?parentId='+1,    
            columns:[[    
                {field:'name',title:'客户来源',width:60},    
            ]]    
        ">
					</select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="customerDialog" title="潜在客户升级菜单" class="easyui-dialog"
		style="width: 400px; height: auto;" closed="true"
		buttons="#CustomerDialogButtons">
		<form id="customerForm" method="post" novalidate>
			<table>
				<input name="id" type="hidden">
				<input name="source.id" type="hidden">
				<tr>
					<td>客户姓名:
					<td>
					<td><input name="name" class="easyui-textbox"
						readonly="readonly" style="width: 200px">
					<td>
				</tr>
				<tr>
					<td>客户年龄:
					<td>
					<td><input name="age" class="easyui-textbox" required="true"
						type="number" style="width: 200px">
					<td>
				</tr>
				<tr>
					<td>客户电话:
					<td>
					<td><input name="tel" class="easyui-textbox" required="true"
						style="width: 200px">
					<td>
				</tr>
				<tr>
					<td>客户邮箱:
					<td>
					<td><input name="email" class="easyui-textbox"
						style="width: 200px">
					<td>
				</tr>
				<tr>
					<td>客户微信:
					<td>
					<td><input name="wechat" class="easyui-textbox"
						style="width: 200px">
					<td>
				</tr>
				<tr>
					<td>客户性别:
					<td>
					<td><input id="gender" type="radio" name="gender" value="1">男
						<input type="radio" name="gender" value="0">女
					<td>
				</tr>
				<tr>
					<td>营销人员:
					<td>
					<td><select id="sellerCombogrid" class="easyui-combogrid"
						name="seller.id" style="width: 150px;"
						data-options="pagination:true,    
            panelWidth:350,    
            idField:'id', 
            readonly:true,   
            textField:'realName',
            url:'/employee/json',    
            columns:[[    
                {field:'id',title:'技师编号',width:60},    
                {field:'realName',title:'姓名',width:100},    
                {field:'tel',title:'电话',width:120}    
            ]]    
        ">
					</select>
					<td>
				</tr>
				<tr>
					<td>客户工作:
					<td>
					<td><select id="jobCombogrid" class="easyui-combogrid"
						name="job.id" style="width: 150px;"
						data-options="pagination:true,    
            panelWidth:350,    
            idField:'id',    
            textField:'name',    
            url:'/systemDictionaryItem/json?parentId='+2,    
            columns:[[    
                {field:'name',title:'工作名称',width:60}    
            ]]    
        ">
					</select>
					<td>
				</tr>
				<tr>
					<td>客户来源:
					<td>
					<td><input name="sourceName" class="easyui-textbox"
						readonly="readonly" style="width: 200px">
					<td>
				</tr>
				<tr>
					<td>缴纳定金:
					<td>
					<td><input name="state" class="easyui-textbox" type="number"
						style="width: 200px">
					<td>
				</tr>

			</table>
		</form>
	</div>


	<div id="CustomerDialogButtons">
		<a data-cmd="saveCustomerButton" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="cancelCustomerButton" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	
	
	   <div id="customerDevPlanDialog" title="开发计划书" class="easyui-dialog" style="width:400px"
            closed="true" buttons="#dlg-buttons">
        <form id="customerDevPlanForm" method="post" novalidate style="margin:0;padding:20px 50px">
        <table cellpadding="5">
        	<input type="hidden" name="id"/>
       			<tr>
				<td>潜在客户:</td><td> 
         	   <select id="potentialCustomerCombo" class="easyui-combogrid" name="potentialCustomer.id" style="width:180px;"  
        data-options="    
            panelWidth:450,    
            value:'006',    
            idField:'id', 
            pagination:true, 
            fitColumns: true,
            readonly:true,
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
            url:'/systemDictionaryItem/json?parentId='+4,    
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
		
		</table>
        </form>
    </div>
	<div id="dlg-buttons">
        <a data-cmd="saveCustomerDevPlan" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="cancelCustomerDevPlan1" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"  style="width:90px">取消</a>
    </div>
</body>
</html>