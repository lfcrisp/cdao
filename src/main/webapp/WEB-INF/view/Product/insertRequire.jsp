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
	<div data-options="region:'center',title:'新增需求',iconCls:'icon-ok'" style="width: 700px;">
		<center>
		    <form id="ff_insert_Require" method="post" >
		    	<table cellpadding="5">
		    		<tr>
		    			<td>
			    			所属产品:
			    			<input id="cc_pro" class="easyui-combobox" style="width: 300px" name="proid" data-options="valueField:'id',textField:'name',url:'<%=request.getContextPath()%>/product/checkPro.action',panelHeight:'auto'" />  
			    		</td>
		    			<td>
			    			所属模块:
			    			<input id="cc_promodel" style="width: 300px" name="modelid" >  
			    		</td>
		    		</tr>
		    		<tr>
		    			<td>
			    			所属计划:
							<input id="cc_plan" style="width: 300px" name="planid">			    		
						</td>
		    			<td>
			    			需求来源:
			    			<input class="easyui-combobox" style="width: 300px" name="fromid" data-options="valueField:'id',textField:'name',url:'<%=request.getContextPath()%>/product/checkPlanList.action',panelHeight:'auto'" />  
			    		</td>
		    		</tr>
		    		<tr>
		    			<td>
			    			由谁评审:
			    			<select  name="examuser" id="checkUser" style="width: 300px" class="easyui-combotree" style="width:200px;" data-options="url:'<%=request.getContextPath()%>/product/getUserDeptList.action',onSelect:insert_examuser" ></select>
		    			</td>
		    			<td>
		    				<input id="sb" style="width:200px;height:30px"> 
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				需求名称:
			    			<input class="easyui-textbox" style="width: 300px" type="text" name="name" data-options="required:true"></input>
		    			</td>
		    			<td>
		    				优先级:
		    				<a href="#" id="levels_menubutton"  class="easyui-menubutton" data-options="menu:'#levels'">
		    					<img alt="" src="<%=request.getContextPath() %>/priority/0.png"></img>
		    				</a>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="2" >
		    				<div>
		    					<div style="float: left;">需求描述:</div>
		    					<div style="float: right;"><textarea name="contents"  cols="100" rows="8" style="width: 800px;height: 100px;visibility:hidden;"></textarea></div>
		    				</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="2" >
		    				<div>
		    					<div style="float: left;">上传附件:</div>
		    					<div style="float: right;">
		    						<iframe id="image_iframe" src="<%=request.getContextPath() %>/fileupload.jsp" width="800px"></iframe>
		    					</div>
		    				</div>
		    			</td>
		    		</tr>
		    	</table>
		    </form>
		    <div style="text-align:center;padding:5px">
			    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm_insert_Require()">提交</a>
			    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>
			</div>
	    </center>
	</div>
</div>

<div id="levels" class="easyui-menu" style="width:120px;">   
	<div><img alt="" src="<%=request.getContextPath() %>/priority/0.png"></img><input type="hidden" name="levels" value="" /></div>
	<div><img alt="" src="<%=request.getContextPath() %>/priority/1.png"></img><input type="hidden" name="levels" value="1"/></div>
	<div><img alt="" src="<%=request.getContextPath() %>/priority/2.png"></img><input type="hidden" name="levels" value="2"/></div>
	<div><img alt="" src="<%=request.getContextPath() %>/priority/3.png"></img><input type="hidden" name="levels" value="3"/></div>
	<div><img alt="" src="<%=request.getContextPath() %>/priority/4.png"></img><input type="hidden" name="levels" value="4"/></div>
</div> 

<script>

	function success(){
		$.messager.show({
			title:'温馨提示',
			msg:'数据添加成功',
			timeout:2000,
			showType:'slide'
		});
	}

	function submitForm_insert_Require(){
		alert("添加需求")
		var param=$("#ff_insert_Require").serialize();
		var data=param+editor.text();
		var url="<%=request.getContextPath()%>/product/insertRequire.action";
		$.post(url,data,function(flag){
			if(flag){  
				$("#image_iframe").contents().find("#tj").click();
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
	
	 $(function(){ 
	    $('#sb').switchbutton({ 
	      width:100,
	      checked: false, 
	      onChange: function(checked){ 
	    	  if(checked){
	    		  $('#checkUser').combotree({    
	  	        	disabled:true  
	  	       	 });  
	    	  }else{
	    		  $('#checkUser').combotree({    
	  	        	disabled:false 
	  	       	 }); 
	    	  }
	      } 
	    }) 
	 }) 
	
	 
	 function insert_examuser(node){
		var id=node.id;
		if(id.length>=6){
			$.messager.alert('温馨提示','请勿选择用户!');
			$("#cc_insert_Product_prouser").ComboTree('clear');
		}
	}

</script>


<script>
	KindEditor.ready(function(K) {
	    editor = K.create('textarea[name="contents"]');
		prettyPrint();
	});
	
	$('#levels').menu({    
	    onClick:function(item){    
	       $("#levels_menubutton").html(item.text);
	    }    
	}); 
	
	
	$(function(){

		$('#cc_pro').combobox({
			onSelect: function(record){
				proid=record.id;
				$('#cc_promodel').combobox('reload','<%=request.getContextPath()%>/product/checkPromodel.action?proid='+proid);
				$('#cc_plan').combobox('reload','<%=request.getContextPath()%>/product/checkPlan.action?proid='+proid);
			}
		});

		
		$('#cc_promodel').combobox({    
		    valueField:'id',    
		    textField:'name',
		    panelHeight:'auto'
		}); 
		
		$('#cc_plan').combobox({    
		    valueField:'id',    
		    textField:'name',
		    panelHeight:'auto'
		}); 
		
		
	})
	
</script>


  
</body>
</html>