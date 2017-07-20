<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript" src="/resource/easyui/datagrid-detailview.js"></script>
<script type="text/javascript" src="/resource/easyui/datagrid-groupview.js"></script>
<script type="text/javascript" src="/resource/js/common.js"></script>
<script src="/resource/Highcharts/js/highcharts.js"></script>
<script src="/resource/Highcharts/js/highcharts-3d.js"></script>
<script src="/resource/Highcharts/js/modules/exporting.js"></script>

<style type="text/css">
	${demo.css}
</style>
<script type="text/javascript">
$(function () {
	$.get("/contract/view",function(myData){
		//alert(1);
		console.debug(myData);
	    $('#container').highcharts({
	        chart: {
	            type: 'pie',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	            text: '销售员业绩饼图'
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name}'
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '销售额占总金额百分比',
	            data: myData
	        }]
	    });
	});
});
</script>

<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件
		var contractDatagrid, contractDialog, contractForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		contractDatagrid = $('#contractDatagrid');
		contractDialog = $('#contractDialog');
		contractForm = $('#contractForm');
		
		var contractAdvancedSearchDialog = $('#contractAdvancedSearchDialog');//高级搜索弹窗
		var advancedSearchContract = $('#advancedSearchContract');//高级搜索按钮
		// 3、初始化组件，修改组件的值

		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObject = {
			
			addContract : function() {
				console.debug('add');
				contractDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加合同');
				contractForm.form('clear');
				$("#itemsDatagrid").datagrid('loadData', {total:0, rows:[]});
			},
			editContract : function() {
				var row = contractDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '必须先选择一行，在修改!', 'warning');
					return;
				}
				$('#itemsDatagrid').datagrid({'url':'/contract/getItems?id='+row.id})
				contractDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加合同');
				contractForm.form('clear');
				if(row.customer){
					row['customer.id']=row.customer.id;
				}
				if(row.seller){
					row['seller.id']=row.seller.id;
				}
				contractForm.form('load', row);
			},
			deleteContract : function() {
				console.debug('delete');
				var row = contractDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '必须先选择一行，在作废!', 'warning');
					return;
				}
				$.messager.confirm('Confirm', '你真的要作废吗?', function(r) {
					if (r) {
						$.post('/contract/delete', {
							id : row.id
						}, function(result) {
							//result 是由后台返回的AjaxResult对象：本质json对象
							if (result.success) {
								contractDatagrid.datagrid('reload');
							} else {
								$.messager.show({
									title : '错误提示',
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
			saveContract : function() {
				console.debug('save');
				contractForm.form('submit', {
					url : "/contract/save",
					onSubmit : function(param) {
						
						var arr = $('#itemsDatagrid').datagrid('getRows');
						if (arr.length == 0) {
							$.messager.alert('提示信息', '请至少输入一个合同明细', 'warning');
							return false;
						}
                        for (var i = 0; i < arr.length ; i++) {
                        	//保存之前进行数据的校验 , 然后结束编辑并初始化编辑状态字段
                      		if($('#itemsDatagrid').datagrid('validateRow',i)){
                          	 	$('#itemsDatagrid').datagrid('endEdit', i);
                      		} else {
                      			$.messager.alert('提示信息', '合同明细的输入格式不正确', 'warning');
    							return false;
                      		}
//                         	console.debug(arr[i]);
                        	console.debug(arr[i]);
                        	param['items['+i+'].money'] = arr[i].money;
                        	param['items['+i+'].isPayment'] = arr[i].isPayment;
                        	param['items['+i+'].payTime'] = arr[i].payTime;
                        }
						return $(this).form('validate');
					},
					success : function(result) {
						console.debug(result);
						//result后台返回的数据，不能json格式
						try {
							var result = JSON.parse(result);
							if (result.success) {
								contractDatagrid.datagrid('reload');
								contractDialog.dialog('close');
							} else {
								//后台保存失败
								$.messager.show({
									title : '错误提示',
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
							//出现数据转换异常：400状态,500状态
							$.messager.show({
								title : '错误提示',
								msg : "<font color='red'>数据转换异常或者服务器异常</font>",
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
			cancelContract : function() {
				console.debug('cancel');
				contractDialog.dialog('close');
			},
			searchContract:function(){//普通查询
//		 		var json={};
//		 		var array=$("#searchOrderFrom").serializeArray();
//		 		for (var i = 0; i < array.length; i++) {
		// // 			console.debug(array[i].name+"="+array[i].value)
//		 			json[array[i].name]=array[i].value;
//		 		}
						
				contractDatagrid.datagrid('reload',$("#searchContractFrom").serializeJSON());
			},
			
			clearContract:function(){//普通查询清除
				$("#searchContractFrom").form("clear");
				location.reload();
			},
			printGuarantee : function(){//打印合同---------------------------------------------------------------------
				var row = $('#contractDatagrid').datagrid('getSelected');
				if (!row) {
					$.messager.alert('消息提示', '打印合同必须选中一行!', 'info');
					return;
				}
				console.debug(row);
				$('#printDialog').dialog('open');
				var printHtml = "";
				printHtml += "<td>" + row.id + "</td>";
				printHtml += "<td>" + row.sum + "</td>";
				printHtml += "<td>" + row.signTime + "</td>";
				printHtml += "<td>" + row.customer.name + "</td>";
				printHtml += "<td>" + row.seller.realName + "</td>";
				printHtml += "<td>" + row.intro + "</td>";
				$("#printContractList").html(printHtml);
				$("#jiafang").html(row.seller.realName);
				$("#sn").html(row.sn);
				$("#time").html(row.signTime);
				$("#yifang").html(row.customer.name);
				
				$.get("/contract/getItems?id="+row.id,function(data){
					var itemHtml = "";
					for(var i=0;i<data.rows.length;i++){
						itemHtml += "<tr>";
						itemHtml += "<td>" + data.rows[i].money + "</td>";
						itemHtml += "<td>" + data.rows[i].scale.toPercent() + "</td>";
						itemHtml += "<td>" + data.rows[i].payTime + "</td>";
						itemHtml += "<td>" + (data.rows[i].isPayment==true ? "已付款":"未付款") + "</td>";
						itemHtml += "</tr>";
					}
					$("#contractItemList").html(itemHtml);
				});
			},
			advancedSearchContract:function(){//打开高级搜索
				$("#AdvancedSearchForm").form("clear");
// 				$('#advancedSearchDepartmentcc').combotree({
// 					url : '/department/getParentTreeData',
// 				});
				contractAdvancedSearchDialog.dialog('open').dialog('center');
			},
			advancedSearchContractsave:function(){//高级搜索提交按钮
// 				reload跟load的区别在 reload 是保留当前数据进行加载,而load则是重新加载
				contractDatagrid.datagrid('load',$("#AdvancedSearchForm").serializeJSON());	
				
			},
			cancelSearchContract:function(){//取消高级搜索关闭界面
				contractAdvancedSearchDialog.dialog('close');
			},resetSearchContract:function(){ //重置高级搜索的条件
				$("#AdvancedSearchForm").form("clear");
			},
			sellerView : function() {
				$("#containerDialog").dialog('open').dialog('center').dialog(
						'setTitle', '业绩饼图');
			}
			
		};
		// 5、对页面所有按钮，统一监听
		$("a").click(function() {
			//类似于pss的data-url写法
			//data-cmd="saveContract"
			var cmd = $(this).data("cmd");
			//disabled:true按钮有禁用的效果，但是事件不能禁用,生成html的时候多了一个样式l-btn-disabled
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
				cmdObject[cmd]();
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
<title>合同管理</title>
</head>
<body>
<div id="containerDialog" title="对话框" class="easyui-dialog" width="615px" closed="true">
	<div id="container" style="height: 400px"></div>
</div>
	<table id="contractDatagrid" title="合同列表" class="easyui-datagrid" fit="true" url="/contract/json"
		toolbar="#contractToolbar" pagination="true" fitColumns="true" singleSelect="true"
		data-options="onClickRow:clickRow">
		<thead>
			<tr>
				<th field="id" width="10">id</th>
				<th field="sn" width="50">合同编号</th>
				<th field="customer" formatter="nameFormatter" width="50">客户名称</th>
				<th field="seller" formatter="nameFormatter" width="50">销售人员</th>
				<th field="sum" width="50" >合同总金额</th>
				<th field="intro" width="50" >合同摘要</th>
				<th field="signTime" width="50" >生效时间</th>
				<th field="state" formatter="guaranteeStateFormatter" width="50">合同状态</th>
			</tr>
		</thead>
	</table>
	<div id="contractToolbar">
		<a data-cmd="addContract" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-add">添加</a> <a
			data-cmd="editContract" href="javascript:void(0)" class="easyui-linkbutton c4 leave" iconCls="icon-edit">修改</a> <a
			data-cmd="deleteContract" href="javascript:void(0)" class="easyui-linkbutton c6 leave" iconCls="icon-remove">作废</a>
		<form id="searchContractFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">&emsp;
			状态:<select id="state" name="state">
					<option value="-1">--请选择--</option>
					<option value="0">正常</option>
					<option value="1">作废</option>
				</select>&emsp;
			时间：从<input class="easyui-datebox" name="beginTime" size="15">
			到<input class="easyui-datebox" name="endTime" size="15">&emsp;
			<a data-cmd="searchContract" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a data-cmd="clearContract" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
			<a data-cmd="advancedSearchContract" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-search">高级搜索</a>
			<a data-cmd="printGuarantee" href="javascript:void(0)" class="easyui-linkbutton c3 leave" iconCls="icon-print">打印合同</a>
			<a data-cmd="sellerView" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add">销售业绩图</a>
		</form>
	</div>
	
	    <script type="text/javascript">
        $(function(){
            $('#contractDatagrid').datagrid({
                view: detailview,
                height: 'auto',
                detailFormatter:function(index,row){
                    return '<div style="padding:2px"><table class="ddv" width="503px"></table></div>';
                },
                onExpandRow: function(index,row){
//                 	console.debug(index);
//                 	console.debug(row);
//                 	console.debug(row[name="id"]);
					var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
					console.debug(ddv);
                	ddv.datagrid({    
                		title:'合同明细',
                		url:'/contract/getItems?id='+row.id,
						fitColumns : true,
						singleSelect : true,
						rownumbers : true,
						height : 'auto',
						method : 'get',
                		columns:[[
                			{field:'id',title:'id',align:'right',width:"80"},
                			{field:'money',title:'金额',align:'right',width:"100",editor:"text"},
                			{field:'scale',title:'所占比例',align:'right',width:"100",
                				formatter: function(value,row,index){
                					if (value) {
	                					return value == 1 ? 1 : value.toPercent();
                					}
	                			}
                			},
                			{field:'isPayment',title:'是否支付',align:'right',width:"100",
                				formatter: function(value,row,index){
	                				return value==false?"未支付":"已支付";
	                			}
							},
                			{field:'payTime',title:'支付时间',align:'right',width:"120"},
                		]],
                		onResize : function() {
                			$('#contractDatagrid').datagrid(
            						'fixDetailRowHeight', index);
            			},
            			onLoadSuccess : function() {
            				setTimeout(
            						function() {
            							$('#contractDatagrid').datagrid(
        											'fixDetailRowHeight',
        											index);
            						}, 0);
            			}
            		});
                	$('#contractDatagrid').datagrid('fixDetailRowHeight', index);
                }
            });
        });
    </script>

	<div id="contractDialog" title="对话框" class="easyui-dialog" width="500px" closed="true"
		buttons="#contractDialogButtons">
		<form id="contractForm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id" />
			<div style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">合同信息</div>
			<div style="margin-bottom: 10px">
				<select id="customerCombogrid" class="easyui-combogrid" name="customer.id" style="width: 250px;" label="客户姓名:"
					data-options="    
            panelWidth:450,    
            idField:'id',    
            textField:'name',    
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
				<input name="sum" class="easyui-textbox" required="true" label="总金额:" style="width: 250px;">
			</div>
			<div style="margin-bottom: 10px">
				<input name="signTime" class="easyui-datebox" label="录入时间:" style="width: 250px;">
			</div>
			<div style="margin-bottom: 10px">
				<input class="easyui-combobox" name="seller.id" label="销售人员:" style="width: 250px;"
   					   data-options="valueField:'id',textField:'realName',url:'/department/getEmployeeBySaleJob'" />
			</div>
			<div style="margin-bottom: 10px">
				<input name="intro" class="easyui-textbox"  label="合同简介:" style="width: 250px;">
			</div>
			<div style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">合同明细</div>
			
			<table id="itemsDatagrid" >
		    </table>
		</form>
	</div>
	<div id="contractDialogButtons">
		<a data-cmd="saveContract" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok"
			style="width: 90px">保存</a> <a data-cmd="cancelContract" href="javascript:void(0)" class="easyui-linkbutton c1"
			iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>

<script type="text/javascript">  
$(function(){
    
    
    var editing ; //判断用户是否处于编辑状态
    var flag  ;      //判断新增和修改方法
    $('#itemsDatagrid').datagrid({
                title:'合同明细列表',
                height: '150px',
                width: '400px',
                fitColumns: true  ,
                //url:'/contract/getItems?id=1' ,//数据来源
                striped: true ,       //            
                loadMsg: '数据正在加载,请耐心的等待...' ,
                rownumbers:true ,
                frozenColumns:[[
                        {field:'ck' , checkbox:true}                                    
                ]],
                columns:[[
                    {
                        field:'money' ,
                        title:'支付金额' ,
                        width: '80px',
                        align:'center' ,
                        editor:{
                            type:'validatebox' ,
                            options:{
                                required:true ,
                                missingMessage:'支付金额必填!'
                            }
                        }
                    },{
                        field:'scale' ,
                        title:'金额所占百分比' ,
                        width: '80px',
                        align:'center' ,
                        editor:{
                            type:'validatebox' ,
                            options:{
                                editable:false
                            }
                        }
                    },{
                        field:'isPayment' ,
                        width: '80px',
                        align:'center' ,
                        title:'是否支付' ,
                        formatter:function(value , record , index){
                            if(value == 0){
                                return '<span style=color:red; >未支付</span>' ;
                            } else if( value == 1){
                                return '<span style=color:green; >已支付</span>' ;
                            }
                        } ,
                        editor:{
                            type:'combobox' ,
                            options:{
                                data:[{id:1 , val:'已支付'},{id:0 , val:'未支付'}] ,
                                valueField:'id' ,
                                textField:'val' ,
                                required:true ,
                                missingMessage:'是否支付必填!'
                            }
                        }
                    },{
                        field:'payTime' ,
                        title:'支付时间' ,
                        align:'center' ,
                        width: '80px',
                        sortable : true ,
                        editor:{
                            type:'datebox' ,
                            options:{
                                required:true ,
                                missingMessage:'支付时间必填!' ,
                                editable:false
                            }
                        }
                    }
                ]] ,
                onDblClickCell: function(index,field,value){
                	if($('#itemsDatagrid').datagrid('validateRow',editing)){
                        $('#itemsDatagrid').datagrid('endEdit', editing);
                        editing = undefined;
                        
                }
            		$(this).datagrid('beginEdit', index);
            		var ed = $(this).datagrid('getEditor', {index:index,field:field});
            		$(ed.target).focus();
            	},
                toolbar:[
                    {
                        text:'新增明细',
                        iconCls:'icon-add' ,
                        handler:function(){
                                     flag = 'add';
                                     //1 先取消所有的选中状态
                                     $('#itemsDatagrid').datagrid('unselectAll');
                                     //2追加一行
                                     $('#itemsDatagrid').datagrid('appendRow',{description:''});
                                     //3获取当前页的行号
                                     editing = $('#itemsDatagrid').datagrid('getRows').length -1;
                                     //4开启编辑状态
                                     $('#itemsDatagrid').datagrid('beginEdit', editing);
                                }
                    },{
                        text:'保存明细',
                        iconCls:'icon-save' ,
                        handler:function(){
                        	 var arr = $('#itemsDatagrid').datagrid('getRows');
                        	 for (var i = 0; i < arr.length ; i++) {
                          	//保存之前进行数据的校验 , 然后结束编辑并初始化编辑状态字段
                        		 if($('#itemsDatagrid').datagrid('validateRow',i)){
                             	$('#itemsDatagrid').datagrid('endEdit', i);
                             	//计算scale
                             	//var mon = arr[i].money;
                             	//var sum = 11;
                             	//console.debug(arr[i]);
                             	//arr[i].scale = mon/sum;
                             	
                             	//console.debug(mon);
                             	//console.debug(sum);
                             	//console.debug(arr[i].scale);
                             	//$('#itemsDatagrid').datagrid('acceptChanges');
                        		}
                        	 }
                        }
                    },{
                        text:'删除明细',
                        iconCls:'icon-remove' ,
                        handler:function(){
                            var arr = $('#itemsDatagrid').datagrid('getSelections');
                            var row = $('#itemsDatagrid').datagrid('getSelected');
                            
                            if(arr.length <= 0 ){
                                $.messager.show({
                                    title:'提示信息',
                                    msg:'请选择进行删除操作!'
                                });                                            
                            } else {
                                $.messager.confirm('提示信息' , '确认删除?' , function(r){
                                    if(r){
                                    	for (var i=0; i < arr.length; i++) {
                                    		var index = $('#itemsDatagrid').datagrid('getRowIndex', arr[i]);
                                    		$('#itemsDatagrid').datagrid('deleteRow', index);
                                    	}
                                        
                                        $('#itemsDatagrid').datagrid('endEdit', editing);
                                        editing = undefined;
                                    } else {
                                         return ;
                                    }
                                });
                            }
                        }
                    },{
                        text:'取消操作',
                        iconCls:'icon-cancel' ,
                        handler:function(){
                            //回滚数据
                            $('#itemsDatagrid').datagrid('rejectChanges');
                            editing = undefined;
                        }
                    }    
                ] ,

        });
});


</script>

	<!-- 打印的Dialog start -->
	<div id="printDialog"  iconCls="icon-print" title="打印合同" modal="true" class="easyui-dialog" style="width:700px; height:450px; padding: 10px 20px" closed="true">
		<a href="javascript:window.print();" style="text-decoration:underline;">点击打印</a>
		<table width=100%>
	        <tr>   
	            <th width="50" align="left"></th>   
	            <th width="50" align="right">合同编号：<span id="sn"></span></th>   
	        </tr>   
	        <tr>   
	            <th align="left">甲方：<span id="jiafang"></span></th>   
	            <th align="right">签订地点：成都市</th>   
	        </tr>   
	        <tr>   
	            <th align="left">乙方：<span id="yifang"></span></th>   
	            <th align="right">签订时间：<span id="time"></span></th>   
	        </tr>   
		</table>  
		
		<p style="font-size:14px;">甲乙双方经协商一致，就___方向___方购买事宜达成以下协议，双方共同遵守:</p>
		<table border="1" cellpadding="0" cellspacing="0" style="width:100%;border:1px solid #333;text-align:center;margin:20px 0 20px;font-size:16px;">
			<tr>
				<td colspan="6">合同概况总览</td>
			</tr>
			<tr>
				<th>合同编号</th>
				<th>定金金额</th>
				<th>签订时间</th>
				<th>客户</th>
				<th>销售人员</th>
				<th>备注</th>
			</tr>
			<tr id="printContractList"></tr>
		</table>
		<table border="1" cellpadding="0" cellspacing="0" style="width:100%;border:1px solid #333;text-align:center;margin:20px 0;font-size:16px;">
			<thead>
				<tr>
					<td colspan="4">合同明细列表</td>
				</tr>
				<tr>
					<th>付款金额</th>
					<th>所占比例</th>
					<th>付款时间</th>
					<th>是否已付款</th>
				</tr>
			</thead>
			<tbody id="contractItemList"></tbody>
		</table>
		<p style="font-size:14px;">
			预付款。甲方于本合同签署之日起，在30 日内，将合同总成交价的 30% ，即人民币( 元)，作为预付款支付给乙方。乙方在收到上述款项后，以传真向甲方确认。如甲方不按上述规定准时支付预付款，则延迟货物进场时间.
		</p>
		<p style="font-size:14px;">
			甲方和乙双方合同信息如有变更，变更一方应在合同规定的相关付款期限前二十天内以书面方式通知对方，如未按时通知或通知有误应付相关及连带责任
		</p>
	</div>
	<!-- 打印的Dialog start -->
	
	<!-- 	高级搜索弹窗 -->
	<div id="contractAdvancedSearchDialog" title="高级查询" class="easyui-dialog"
		style="width: 400px" closed="true" buttons="#contractSearchDialogButtons">
		<form id="AdvancedSearchForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<div style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">合同查询
			</div>
			
			<div style="margin-bottom: 10px">
				<select class="easyui-combogrid" name="customerId" style="width: 250px;" label="客户信息："
					data-options="    
		            panelWidth:450,    
		            idField:'id',    
		            textField:'name',    
		            mode:'remote',
		            url:'/customer/json',    
		            columns:[[    
				                {field:'name',title:'姓名',width:60},    
				                {field:'tel',title:'电话',width:60},    
				                {field:'qq',title:'QQ',width:100},    
				                {field:'email',title:'邮箱',width:200}    
		           			]]">
		        </select>
            </div>
			
			<div style="margin-bottom: 10px">
				销售员信息: 
         	   <select class="easyui-combogrid" name="sellerId" style="width:180px;"  
			        data-options="    
			            panelWidth:450,    
			            idField:'id', 
			            mode:'remote',   
			            textField:'realName',     
			            url:'/department/getEmployeeBySaleJob',    
			            columns:[[    
			                {field:'id',title:'员工编号',width:50},    
			                {field:'realName',title:'员工姓名',width:60},    
			                {field:'tel',title:'员工电话',width:100},    
			                {field:'email',title:'邮箱',width:200},    
			            ]], 
				"></select>
			</div>
			
		</form>
	</div>
	<div id="contractSearchDialogButtons">
		<a data-cmd="advancedSearchContractsave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">提交</a>
		<a data-cmd="cancelSearchContract" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
		<a data-cmd="resetSearchContract" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-reload" style="width: 90px">重置</a>
	</div>
	

</body>
</html>