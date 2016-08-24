<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rd-party/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rd-party/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/easyUI/jquery.easyui.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/3rd-party/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/js/jquery-form.js"></script></head>
<body>
<script type="text/javascript">
	$(function(){
		$("#item_tt").tabs({
			tools:'#tab-tools',
			toolPosition:'left'
		});
	});
	
	
	
	
	
	function InsertProduct(){
		var pro_tabs=$("#item_tt").tabs('getTab',"产品");
		$('#item_tt').tabs('update', {
			tab: pro_tabs,
			options: {
				href: '',  // 新内容的URL
				content:'<iframe src="<%=request.getContextPath()%>/product/toInsertProduct.action" width="100%" height="100%" frameborder="0"></iframe>'
			}
		});
		pro_tabs.panel('refresh');
		$("#item_tt").tabs('select',"产品");
	}
	
	function checkProduct(){
		var pro_tabs=$("#item_tt").tabs('getTab',"产品");
		$('#item_tt').tabs('update', {
			tab: pro_tabs,
			options: {
				href: '',  // 新内容的URL
				content:'<iframe src="<%=request.getContextPath()%>/product/toCheckProductList.action" width="100%" height="100%" frameborder="0"></iframe>'
			}
		});
		pro_tabs.panel('refresh');
		$("#item_tt").tabs('select',"产品");
	}
	
	

	
	
</script>
<div class="easyui-tabs"  data-options="fit:true" id="item_tt">
	<div title="需求"   style="padding:10px" name="product/toProductRequireList" id="tabs">
	</div>
	<div title="动态"   style="padding:10px">
	</div>
	<div title="计划"   style="padding:10px">
	</div>
	<div title="发布"   style="padding:10px">
	</div>
	<div title="路线图"   style="padding:10px">
	</div>
	<div title="文档"   style="padding:10px">
	</div>
	<div title="迭代"   style="padding:10px">
	</div>
	<div title="模块"   style="padding:10px">
	</div>
	<div title="产品">
	</div>
	<div title="报表">
	</div>
</div>

<div id="tab-tools">
	<a href="#" class="easyui-menubutton" data-options="menu:'#mm2'" id="title">aaaa</a>
	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="InsertProduct()">添加产品</a>
	<a href="#" class="easyui-linkbutton" data-options="plain:true" onclick="checkProduct()">所有产品</a>
</div>


<div id="mm2" class="easyui-menu" style="width:120px;">   
	<c:forEach items="${proList}" var="pro">
		<div id='${pro.id}' data-options="name:'${pro.name}'">${pro.name}</div>
	</c:forEach>
</div> 



<script type="text/javascript">
	id=4;

	$('#mm2').menu({    
	    onClick:function(item){    
		    $("#title").text("");
		    $("#title").text(item.name);
		    id=item.id;
		    var tab=$("#item_tt").tabs('getTab','需求'); 
		    tab.panel('refresh', "<%=request.getContextPath()%>/"+tab.attr("name")+".action?id="+id);
		    $("#item_tt").tabs('resize');

	    }    
	}); 

	$("#item_tt").tabs({
		onSelect:function(title,index){
			var pro_tabs=$("#item_tt").tabs('getTab',title);
			if(pro_tabs.attr("name")!=null&&pro_tabs.attr("name")!=""){
	    		$("#item_tt").tabs("update",{
				tab:pro_tabs,
				options:{
					//content:"<iframe src='<%=request.getContextPath()%>/"+pro_tabs.attr("name")+".action?id='+id frameborder='0' height='100%' width='100%'></iframe>"
					href:"<%=request.getContextPath()%>/"+pro_tabs.attr("name")+".action?id="+id,
				}
			});
	    	}
		}
	});
	
	function insertRequire(){
		var pro_tabs=$("#item_tt").tabs('getTab',"产品");
		$('#item_tt').tabs('update', {
			tab: pro_tabs,
			options: {
				href: '',  // 新内容的URL
				content:'<iframe src="<%=request.getContextPath()%>/product/toInsertRequire.action" width="100%" height="100%" frameborder="0"></iframe>'
			}
		});
		pro_tabs.panel('refresh');
		$("#item_tt").tabs('select',"产品");
	}
	
	function requireReport(){
		var pro_tabs=$("#item_tt").tabs('getTab',"报表");
		$('#item_tt').tabs('update', {
			tab: pro_tabs,
			options: {
				href: '',  // 新内容的URL
				content:'<iframe src="<%=request.getContextPath()%>/product/toRequireReport.action" width="100%" height="100%" frameborder="0"></iframe>'
			}
		});
		pro_tabs.panel('refresh');
		$("#item_tt").tabs('select',"报表");
	}
	
</script>

</body>
</html>