<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="crm" uri="/WEB-INF/views/tlds/crm.tld"%>

<script type="text/javascript">
	var themeName="black";
	if(Config && Config.theme){
		themeName=top.Config.theme;
	}
	document.write('<link id="themestyle"  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/easyui/themes/'+themeName+'/easyui.css"> ')
</script>
<link id="themestyle"  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/easyui/themes/black/easyui.css">   
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/easyui/themes/icon.css">   
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/easyui/themes/color.css">   
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/easyui/jquery.min.js"></script>   
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/easyui/jquery.easyui.min.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/customer.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/easyui/locale/easyui-lang-zh_CN.js"></script>  



