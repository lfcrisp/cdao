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
<link rel="stylesheet" href="<%=request.getContextPath()%>/3rd-party/plugin/themes/default/default.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/3rd-party/plugin/plugins/code/prettify.css" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/plugin/kindeditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/plugin/lang/zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/3rd-party/plugin/plugins/code/prettify.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',title:'新增产品',iconCls:'icon-ok'">
		<center>
			
		    <form id="ff_insert_Product" method="post">
		    	<table cellpadding="5">
		    		<tr>
		    			<td>产品名称:</td>
		    			<td><input class="easyui-textbox" style="width: 300px" type="text" name="name" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>产品代号:</td>
		    			<td><input class="easyui-textbox" style="width: 300px" type="text" name="version" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td>产品负责任人:</td>
		    			<td><select id="cc_insert_Product_prouser" name="prouser" class="easyui-combotree" style="width:200px;" data-options="url:'<%=request.getContextPath()%>/product/getUserDeptList.action',onSelect:insert_Product_prouser" ></select></td>
		    		</tr>
		    		<tr>
		    			<td>测试负责人:</td>
		    			<td><select id="cc_insert_Product_testuser" name="testuser" class="easyui-combotree" style="width:200px;" data-options="url:'<%=request.getContextPath()%>/product/getUserDeptList.action',onSelect:insert_Product_testuser" ></select></td>
		    		</tr>
		    		<tr>
		    			<td>发布负责人:</td>
		    			<td><select id="cc_insert_Product_pubuser" name="pubuser" class="easyui-combotree" style="width:200px;" data-options="url:'<%=request.getContextPath()%>/product/getUserDeptList.action',onSelect:insert_Product_pubuser" ></select></td>
		    		</tr>
		    		<tr>
		    			<td>产品类型:</td>
		    			<td><input id="cc_insert_protype" class="easyui-combobox" name="protype" data-options="valueField:'id',textField:'name',url:'<%=request.getContextPath()%>/product/getProTypeList.action',panelHeight:'auto'" /> </td>
		    		</tr>
		    		<tr>
		    			<td>产品描述:</td>
		    			<td>
							<textarea name="content" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"></textarea>
		    			</td>
		    		</tr>
		    	</table>
		    </form>
		    <div style="text-align:center;padding:5px">
			    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm_insert_Product()">提交</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>
			</div>
	    </center>
	</div>
</div>



<script>
	function submitForm_insert_Product(){
		var param=$("#ff_insert_Product").serialize();
		var data=param+editor.text();
		var url="<%=request.getContextPath()%>/product/insertProduct.action";
		$.post(url,data,function(flag){
			if(flag){  
				$.messager.show({
					title:'温馨提示',
					msg:'数据添加成功',
					timeout:2000,
					showType:'slide'
				});
				$('#ff_insert_Product').form('clear');
			}else{
				$.messager.show({
					title:'温馨提示',
					msg:'数据添加失败',
					timeout:2000,
					showType:'slide'
				});
			}
		},'json');
	}
	function clearForm(){
		$('#ff_insert_Product').form('clear');
	}
	
	
	function insert_Product_prouser(node){
		var id=node.id;
		if(id.length>=6){
			$.messager.alert('温馨提示','请勿选择用户!');
			$("#cc_insert_Product_prouser").ComboTree('clear');
		}
	}
	
	function insert_Product_testuser(node){
		var id=node.id;
		if(id.length>=6){
			$.messager.alert('温馨提示','请勿选择用户!');
			$("#cc_insert_Product_testuser").ComboTree('clear');
		}
	}
	
	function insert_Product_pubuser(node){
		var id=node.id;
		if(id.length>=6){
			$.messager.alert('温馨提示','请勿选择用户!');
			$("#cc_insert_Product_pubuser").ComboTree('clear');
		}
	}

</script>


<script>
	KindEditor.ready(function(K) {
	    editor = K.create('textarea[name="content"]');
		prettyPrint();
	});
</script>


  
</body>
</html>