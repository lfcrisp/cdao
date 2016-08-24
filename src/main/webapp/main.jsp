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
		<div title="我的地盘">
			<div class="easyui-tabs" data-options="fit:true" >
				<div title="首页"   style="padding:10px">
				</div>
				<div title="待办"   style="padding:10px">
				</div>
				<div title="需求">
				</div>
				<div title="BUG"   style="padding:10px">
				</div>
				<div title="测试"   style="padding:10px">
				</div>
				<div title="项目"   style="padding:10px">
				</div>
				<div title="任务"   style="padding:10px">
				</div>
				<div title="动态"   style="padding:10px">
				</div>
				<div title="档案"   style="padding:10px">
				</div>
				<div title="联系人"   style="padding:10px">
				</div>
			</div>
		</div>
		<div title="产品" name="product/toProductMain" >
			<%--<div class="easyui-tabs"  data-options="fit:true">
				<div title="概况"   style="padding:10px">
				</div>
				<div title="需求"   style="padding:10px">
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
				<div title="产品"   style="padding:10px" id="pro_tabs" >
				</div>
			</div>--%>
		</div>
		<div title="项目" style="padding:10px">
		</div>
		<div title="测试" style="padding:10px">
		</div>
		<div title="文档" style="padding:10px">
		</div>
		<div title="统计" style="padding:10px">
		</div>
		<div title="组织">
			<div class="easyui-tabs" data-options="fit:true" >
				<div title="用户" href="user/toUserList.action">
				</div>
				<div title="部门" href="dept/toDeptList.action">
				</div>
				<div title="权限" style="padding:10px">
				</div>
				<div title="公司" style="padding:10px">
				</div>
				<div title="动态" style="padding:10px">
				</div>
			</div>
		</div>
		<div title="后台" style="padding:10px">
		</div>
	</div>
	
	
	
	
<%--<script type="text/javascript">
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
</script>--%>


<script type="text/javascript">
	$("#main_tabs").tabs({
		onSelect:function(title,index){
			main_tabs=$("#main_tabs").tabs('getTab',title);
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