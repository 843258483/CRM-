function traceResultFormatter(value, row, index){
	return value==0?"<font color='yellow'>中</font>":(value==-1?"<font color='red'>差</font>":"好"); 
}

function customerFormatter(value, row, index){
	return value==0?"<font color='greed'>普通客户</font>":(value==-1?"<font color='red'>资源池</font>":"<font color='blue'>vip</font>"); 
}

