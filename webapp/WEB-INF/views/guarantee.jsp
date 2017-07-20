<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/common.jsp"%>
<script type="text/javascript" src="/resource/easyui/datagrid-detailview.js"></script>
<script type="text/javascript" src="/resource/easyui/datagrid-groupview.js"></script>
<script type="text/javascript" src="/resource/js/common.js"></script>
<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件
		var guaranteeDatagrid, guaranteeDialog, guaranteeForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		guaranteeDatagrid = $('#guaranteeDatagrid');
		guaranteeDialog = $('#guaranteeDialog');
		guaranteeForm = $('#guaranteeForm');
		// 3、初始化组件，修改组件的值

		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObject = {
			editGuarantee : function() {
				var row = guaranteeDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '必须先选择一行，在修改!', 'warning');
					return;
				}
				$('#itemsDatagrid').datagrid({'url':'/guarantee/getItems?id='+row.id})
				guaranteeDialog.dialog('open').dialog('center').dialog(
						'setTitle', '添加合同');
				guaranteeForm.form('clear');
				if(row.customer){
					row['customer.id']=row.customer.id;
					row['customer.name']=row.customer.name;
				}
				if(row.contract){
					row['contract.id']=row.contract.id;
					row['contract.sn']=row.contract.sn;
				}
				guaranteeForm.form('load', row);
			},
			deleteGuarantee : function() {
				console.debug('delete');
				var row = guaranteeDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('提示信息', '必须先选择一行，在作废!', 'warning');
					return;
				}
				$.messager.confirm('Confirm', '你真的要作废吗?', function(r) {
					if (r) {
						$.post('/guarantee/delete', {
							id : row.id
						}, function(result) {
							//result 是由后台返回的AjaxResult对象：本质json对象
							if (result.success) {
								guaranteeDatagrid.datagrid('reload');
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
			saveGuarantee : function() {
				console.debug('save');
				guaranteeForm.form('submit', {
					url : "/guarantee/save",
					onSubmit : function(param) {
						
						var arr = $('#itemsDatagrid').datagrid('getRows');
						if (arr.length == 0) {
							$.messager.alert('提示信息', '请至少输入一个保修单明细', 'warning');
							return false;
						}
                        for (var i = 0; i < arr.length ; i++) {
                        	//保存之前进行数据的校验 , 然后结束编辑并初始化编辑状态字段
                      		if($('#itemsDatagrid').datagrid('validateRow',i)){
                          	 	$('#itemsDatagrid').datagrid('endEdit', i);
                      		} else {
                      			$.messager.alert('提示信息', '保修单明细的输入格式不正确', 'warning');
    							return false;
                      		}
//                         	console.debug(arr[i]);
                        	console.debug(arr[i]);
                        	param['items['+i+'].content'] = arr[i].content;
                        	param['items['+i+'].guaranteeTime'] = arr[i].guaranteeTime;
                        	param['items['+i+'].solve'] = arr[i].solve;
                        }
						return $(this).form('validate');
					},
					success : function(result) {
						console.debug(result);
						//result后台返回的数据，不能json格式
						try {
							var result = JSON.parse(result);
							if (result.success) {
								guaranteeDatagrid.datagrid('reload');
								guaranteeDialog.dialog('close');
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
			cancelGuarantee : function() {
				console.debug('cancel');
				guaranteeDialog.dialog('close');
			},
			searchGuarantee:function(){//普通查询
//		 		var json={};
//		 		var array=$("#searchOrderFrom").serializeArray();
//		 		for (var i = 0; i < array.length; i++) {
		// // 			console.debug(array[i].name+"="+array[i].value)
//		 			json[array[i].name]=array[i].value;
//		 		}
						
				guaranteeDatagrid.datagrid('reload',$("#searchGuaranteeFrom").serializeJSON());
			},
			
			clearGuarantee:function(){//普通查询清除
				$("#searchGuaranteeFrom").form("clear");
				location.reload();
			},
		};
		// 5、对页面所有按钮，统一监听
		$("a").click(function() {
			//类似于pss的data-url写法
			//data-cmd="saveGuarantee"
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
<title>保修单管理</title>
</head>
<body>
	<table id="guaranteeDatagrid" title="合同列表" class="easyui-datagrid" fit="true" url="/guarantee/json"
		toolbar="#guaranteeToolbar" pagination="true" fitColumns="true" singleSelect="true"
		 data-options="onClickRow:clickRow">
		<thead>
			<tr>
				<th field="id" width="10">id</th>
				<th field="sn" width="50">保修单编号</th>
				<th field="customer" formatter="nameFormatter" width="50" >客户姓名</th>
				<th field="endTime" width="50">到期时间</th>
				<th field="contract" formatter="nameFormatter" width="50" >合同编号</th>
				<th field="state" formatter="guaranteeStateFormatter" width="50">保修单状态</th>
			</tr>
		</thead>
	</table>
	<div id="guaranteeToolbar">
		<a data-cmd="editGuarantee" href="javascript:void(0)" class="easyui-linkbutton c2 leave" iconCls="icon-edit">修改</a>
		<a data-cmd="deleteGuarantee" href="javascript:void(0)" class="easyui-linkbutton c3 leave" iconCls="icon-remove">作废</a>
		<form id="searchGuaranteeFrom" action="#" method="POST">
			关键字:<input type="text" name="q" size="15">&emsp;
			状态:<select id="state" name="state">
			<option value="-1">--请选择--</option>
			<option value="0">正常</option>
			<option value="1">作废</option>
			</select>&emsp;
			<a data-cmd="searchGuarantee" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-search">搜索</a>
			<a data-cmd="clearGuarantee" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-cut">清空</a>
		</form>
	</div>
	
	    <script type="text/javascript">
        $(function(){
            $('#guaranteeDatagrid').datagrid({
                view: detailview,
                detailFormatter:function(index,row){
                    return '<table class="ddv" width="503px"></table>';
                },
                onExpandRow: function(index,row){
//                 	console.debug(index);
//                 	console.debug(row);
//                 	console.debug(row[name="id"]);
					var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
					console.debug(ddv);
                	ddv.datagrid({    
                		title:'保修单明细',
                		url:'/guarantee/getItems?id='+row.id,
						fitColumns : true,
						singleSelect : true,
						rownumbers : true,
						height : 'auto',
						method : 'get',
                		columns:[[
                			{field:'id',title:'编号',align:'center',width:"80"},
                			{field:'guaranteeTime',title:'到期时间',align:'center',width:"100",editor:"text"},
                			{field:'content',title:'保修内容',align:'center',width:"100"},
                			{field:'solve',title:'是否解决',align:'center',width:"100",
                				formatter: function(value,row,index){
	                				return value==false?"未解决":"已解决";
	                			}
							}
                		]],
            			onResize : function() {
            				$('#guaranteeDatagrid').datagrid('fixDetailRowHeight', index);
            			},
            			onLoadSuccess : function() {
            				setTimeout(function() {
            							$('#guaranteeDatagrid').datagrid('fixDetailRowHeight',index);
            						}, 0);
            			}
            		});
                	$('#guaranteeDatagrid').datagrid('fixDetailRowHeight', index);
                }
            });
        });
    </script>

	<div id="guaranteeDialog" title="对话框" class="easyui-dialog" width="500px" closed="true"
		buttons="#guaranteeDialogButtons">
		<form id="guaranteeForm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input type="hidden" name="id" />
			<input type="hidden" name="customer.id" />
			<input type="hidden" name="contract.id" />
			<input type="hidden" name="id" />
			<div style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">保修单信息</div>
			<div style="margin-bottom: 10px">
				<input name="customer.name" class="easyui-textbox" readonly="true" required="true" label="客户姓名:" style="width: 250px;">
			</div>
			<div style="margin-bottom: 10px">
				<input name="contract.sn" class="easyui-textbox" readonly="true" label="合同编号:" style="width: 250px;">
			</div>
			<div style="margin-bottom: 10px">
				<input name="state" class="easyui-textbox" readonly="true" label="状态:" style="width: 250px;">
			</div>
			<div style="margin-bottom: 10px">
				<input name="endTime" class="easyui-datebox" label="到期时间:" style="width: 250px;">
			</div>
			
			<div style="margin-bottom: 20px; font-size: 14px; border-bottom: 1px solid #ccc">保修单明细</div>
			
			<table id="itemsDatagrid" >
		    </table>
		</form>
	</div>
	<div id="guaranteeDialogButtons">
		<a data-cmd="saveGuarantee" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok"
			style="width: 90px">保存</a> <a data-cmd="cancelGuarantee" href="javascript:void(0)" class="easyui-linkbutton c1"
			iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>

    <script type="text/javascript">  
    
                $(function(){
                    
                    
                    var editing ; //判断用户是否处于编辑状态
                    var flag  ;      //判断新增和修改方法
                    $('#itemsDatagrid').datagrid({
                                title:'保修单明细列表' ,
                                width: '400px',
                                fitColumns: true  ,
                                //url:'/guarantee/getItems?id=1' ,//数据来源
                                striped: true ,       //            
                                loadMsg: '数据正在加载,请耐心的等待...' ,
                                rownumbers:true ,
                                frozenColumns:[[
                                        {field:'ck' , checkbox:true}                                    
                                ]],
                                columns:[[
                                    {
                                        field:'content' ,
                                        title:'保修内容' ,
                                        width: '80px',
                                        align:'center' ,
                                        editor:{
                                            type:'validatebox' ,
                                            options:{
                                                required:true ,
                                                missingMessage:'保修内容必填'
                                            }
                                        }
                                    },{
                                        field:'guaranteeTime' ,
                                        title:'保修时间' ,
                                        width: '80px',
                                        align:'center' ,
                                        editor:{
                                            type:'datebox' ,
                                            options:{
                                            	required:true ,
                                                missingMessage:'保修时间必填'
                                            }
                                        }
                                    },{
                                        field:'solve' ,
                                        width: '80px',
                                        align:'center' ,
                                        title:'是否解决' ,
                                        formatter:function(value , record , index){
                                                        if(value == 0){
                                                            return '<span style=color:red; >未解决</span>' ;
                                                        } else if( value == 1){
                                                            return '<span style=color:green; >已解决</span>' ;
                                                        }
                                        } ,
                                        editor:{
                                            type:'combobox' ,
                                            options:{
                                                data:[{id:1 , val:'已解决'},{id:0 , val:'未解决'}] ,
                                                valueField:'id' ,
                                                textField:'val' ,
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
                                                        if(editing == undefined){
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
</body>
</html>