<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Demo项目管理系统</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rd-party/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rd-party/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.easyui.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/3rd-party/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/ztree/js/jquery.ztree.core.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.easyui.mobile.js"></script>

</head>
<body>
	<h3 style="font-family:'楷体'">Demo项目管理系统</h3>
	<div class="easyui-tabs" data-options="fit:true" id="main_tabs">
		<div title="我的地盘"   style="padding:10px" name="product/toInsertProduct" data-options="selected:true">
		</div>
		<div title="产品" style="padding:10px" name="product/toInsertProduct">
		</div>
		<div title="项目" style="padding:10px">
		</div>
		<div title="测试" style="padding:10px">
		</div>
		<div title="文档" style="padding:10px">
		</div>
		<div title="统计" style="padding:10px">
		</div>
		<div title="组织" style="padding:10px">
		</div>
		<div title="后台" style="padding:10px">
		</div>
	</div>
	
	
	
	

	
<script type="text/javascript">
$("#main_tabs").tabs({
	onSelect:function(title,index){
		var main_tabs=$("#main_tabs").tabs('getTab',title);
		if(main_tabs.attr("name")!=null&&main_tabs.attr("name")!=""){
    		$("#main_tabs").tabs("update",{
			tab:main_tabs,
			options:{
				content:"<iframe src='<%=request.getContextPath()%>/"+main_tabs.attr("name")+".action' frameborder='0' height='100%' width='100%'></iframe>"
			}
		});
    	}
	}
});
</script>
	
</body>
</html>