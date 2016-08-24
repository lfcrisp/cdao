<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rd-party/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rd-party/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.easyui.min.js"></script>
</head>
<body>
<script type="text/javascript">
$(function(){
	$("#dg_checkProductList").datagrid({
		url:'<%=request.getContextPath()%>/product/checkProductList.action',
		fitColumns:true,
		fit:true,
		singleSelect:true,
		columns:[[
			{field:'id',title:'ID',width:100},    
			{field:'name',title:'产品名称',width:100},    
		]]
	});
})
</script>
<table id="dg_checkProductList"></table> 
</body>
</html>