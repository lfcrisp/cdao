<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/3rd-party/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/ztree/js/jquery.ztree.core.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/3rd-party/jqueryUI/themes/base/jquery.ui.all.css">
<script src="<%=request.getContextPath()%>/3rd-party/jqueryUI/ui/jquery.ui.core.js"></script>
<script src="<%=request.getContextPath()%>/3rd-party/jqueryUI/ui/jquery.ui.widget.js"></script>
<script src="<%=request.getContextPath()%>/3rd-party/jqueryUI/ui/jquery.ui.position.js"></script>
<script src="<%=request.getContextPath()%>/3rd-party/jqueryUI/ui/jquery.ui.autocomplete.js"></script>
<body>
<script type="text/javascript">
	$(function(){
		var url="<%=request.getContextPath()%>/user/deptZtreeList.action";
		$.post(url,{},function(data){
			//alert(data)
			var setting = {
				data: {
					simpleData: {
						enable: true,
						pIdKey: "pid",
					}
				},
				callback: {
					onClick: zTreeOnClick
				}

			};
			
			var zNodes =data;
			
			
		    var myArray=[];
			for(var i in data){
				myArray[i]=data[i].name;
			} 
			var availableTags =myArray;
	   		$( "#tags" ).autocomplete({
	   			source: availableTags,
	   			select: function(event, ui){
	   				var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
	   				var node = treeObj.getNodeByParam("name", ui.item.value, null);
	   				zTreeOnClick(null, null, node);
	   			}
	   		});
			  
			
			$(document).ready(function(){
				$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
			});
			
		},'json');
		
	})
	
	function zTreeOnClick(event, treeId, treeNode) {
	    window.parent.setDeptid(treeNode);
	};

</script>
	<input id="tags" />
	<div id="treeDemo2" class='ztree'></div>
</body>
</html>