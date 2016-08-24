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
<script type="text/javascript">
	$(function(){
		$("#item_tt").tabs({
			tools:'#tab-tools',
			toolPosition:'left'
		});
	});
</script>
</head>
<body>
	<h1 style="font-family:'楷体'">Demo项目管理系统</h1>
	<div class="easyui-tabs" data-options="fit:true" id="main_tabs">
		<div title="我的地盘" >
			<div class="easyui-tabs" data-options="fit:true" >
				<div title="首页"   style="padding:10px">
				</div>
				<div title="待办"   style="padding:10px">
				</div>
				<div title="需求"   style="padding:10px">
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
		<div title="产品">
			<div class="easyui-tabs" id="item_tt" data-options="fit:true">
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
				<div title="产品"  id="pro_tabs" >
				</div>
			</div>
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
				<div title="用户" style="padding:10px" href="user/toUserList.action">
				</div>
				<div title="部门" style="padding:10px" href="dept/toDeptList.action">
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
	
	
	<div id="tab-tools">
		<a href="#" class="easyui-menubutton" data-options="menu:'#mm1'">About</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="InsertProduct()">添加产品</a>
		<a href="#" class="easyui-linkbutton" data-options="plain:true">所有产品</a>
	</div>
	<div id="mm1" class="menu-content" style="background:#f0f0f0;padding:10px;text-align:left">
		<img src="http://www.jeasyui.com/images/logo1.png" style="width:150px;height:50px">
		<p style="font-size:14px;color:#444;">Try jQuery EasyUI to build your modern, interactive, javascript applications.</p>
	</div>
	
<script type="text/javascript">
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
</script>
	

	
</body>
</html>