function nameFormatter(value, row, index) {
	return value ? value.name||value.realName||value.sn : "";
}
		 
function orderStateFormatter(value, row, index) {
//	console.debug(value);
	return value==0?"<font color='green'>正常</font>":"<font color='red'>作废</font>";
}

function guaranteeStateFormatter(value, row, index) {
//	console.debug(value);
	return value==0?"<font color='green'>正常</font>":"<font color='red'>作废</font>";
}

function genderFormatter(value, row, index){
	return value==1?"男":"女";
}

function stateFormatter(value, row, index) {
//	console.debug(value);
	  return value==0?"<font color='green'>正常</font>":"<font color='red'>停用</font>";
	}

function  employeestateFormatter(value, row, index){
	return value==0?"<font color='green'>在职</font>":"<font color='red'>离职</font>";
}

$.fn.serializeJSON=function(){
	var json={};
	var array=$(this).serializeArray();
	for (var i = 0; i < array.length; i++) {
//			console.debug(array[i].name+"="+array[i].value)
		json[array[i].name]=array[i].value;
	}
	return json;
	
}
Number.prototype.toPercent=function(){
	return (Math.round(this * 10000)/100).toFixed(2) + '%';
}
