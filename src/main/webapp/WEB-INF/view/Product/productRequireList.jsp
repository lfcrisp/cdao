<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	$(function(){
		var url="<%=request.getContextPath()%>/product/productPromodelList.action";
		$.post(url,{},function(data){
			var setting = {
				data: {
					simpleData: {
						enable: true,
						pIdKey: "pid",
					}
				}
			};
			
			var zNodes =data;
			
			$(document).ready(function(){
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			});
			
		},'json');
		
		$("#dg_productRequireList").datagrid({
			url:'<%=request.getContextPath()%>/product/checkProductRequire.action',
			fitColumns:true,
			fit:true,
			singleSelect:true,
			columns:[[
				{field:'id',title:'ID',width:100},    
				{field:'name',title:'需求名称',width:100},
				{field:'proname',title:'所属产品',width:100},   
				{field:'modelname',title:'所属模块',width:100},   
				{field:'planname',title:'所属计划',width:100},   
				{field:'fromname',title:'需求来源',width:100},   
				{field:'exname',title:'由谁评审',width:100},   
				{field:'levels',title:'优先级',width:100},   
				{field:'contents',title:'需求描述',width:100},   
			]],
			onDblClickRow: function(index,row){
				require_id=row.id;
				$('#productRequire').dialog({
				    href: '<%=request.getContextPath()%>/checkImage.action?require_id='+require_id
			    });
				$('#productRequire').dialog('open');
			}
		});
	})
	
	$('#productRequire').dialog({    
	    title: '图片附件',    
	    width: 400,    
	    height: 400,    
	    closed: true,    
	    modal: true,
	});
	
	

	function tijiao(){
		$("#tijiao_form").ajaxSubmit({
			type:"post",
			url:"<%=request.getContextPath()%>/impExcel.action",
			dataType:"json",
		    success: function(flag){
		     	alert(flag)
			}
		});
	}
</script>
<div class="easyui-layout" fit='true' >
	<div data-options="region:'north'"  style="height:33px;width: 1883px" >
		<a href="#" onclick="insertRequire()" class="easyui-menubutton" data-options="iconCls:'icon-add',hasDownArrow:false,menuAlign:'right'">提需求</a>
		<a href="#" class="easyui-menubutton" data-options="menu:'#daochu'">导出文件</a>
		<a href="#" class="easyui-menubutton" data-options="menu:'#daoru'">导入文件</a>
		<a href="#" onclick="requireReport()" class="easyui-menubutton" data-options="iconCls:'icon-large-chart',hasDownArrow:false,menuAlign:'right'">报表</a>
	</div>
	<div data-options="region:'west',split:true" title="功能模块" style="width:200px;">
		<div id="treeDemo" class="ztree"></div>
	</div>
	<div data-options="region:'center',iconCls:'icon-ok'" style="width: 1683px;">
		<table id="dg_productRequireList"></table> 
		<div id="productRequire"></div>   
		<div id="dd_impExcel" class="easyui-dialog"  data-options="closed:true,title:'导入文件'" style="width:400;height:100;padding:10px">
		  <form id="tijiao_form" method="post" enctype="multipart/form-data">
		  <center>
			<table>
				<tr>
		   			<td>上传文件:</td>
		   			<td><input type="file" name="myFile"  style="width:300px"></td>
		   		</tr>
		   		<tr>
		   			<td>
		   				<button onclick="tijiao()">提交</button>
		   			</td>
		   		</tr>
			</table>
			</center>
		  </form>
		</div>
	</div>
</div>
<div id="daochu" class="easyui-menu" style="width:120px;">   
	<div><a href="#" onclick="exportExcel()" class="easyui-menubutton" data-options="iconCls:'icon-redo',hasDownArrow:false,menuAlign:'right'">导出Excel</a></div>
	<div><a href="#" onclick="exportPdf()" class="easyui-menubutton" data-options="iconCls:'icon-redo',hasDownArrow:false,menuAlign:'right'">导出Pdf</a></div>
	<div><a href="#" onclick="exportWord()" class="easyui-menubutton" data-options="iconCls:'icon-redo',hasDownArrow:false,menuAlign:'right'">导出Word</a></div>
</div> 
<div id="daoru" class="easyui-menu" style="width:120px;">   
	<div onclick="impExcel()">导入Excel</div>
</div> 
<script type="text/javascript">
	function exportExcel(){
		alert("倒出excel表格");
		//location.href="<%=request.getContextPath()%>/exportExcel.action";   
        $.ajax({
             url:"<%=request.getContextPath()%>/exportExcel.action",
             type:"post",
        });
	}
	
	function exportPdf(){
		alert("倒出pdf");
		 $.ajax({
             url:"<%=request.getContextPath()%>/exportPdf.action",
             type:"post",
        });
	}
	
	function exportWord(){
		location.href="<%=request.getContextPath()%>/exportWord.action";
		
	}
	
	function impExcel(){
		$('#dd_impExcel').dialog('open'); 
	}
</script>
</body>
</html>