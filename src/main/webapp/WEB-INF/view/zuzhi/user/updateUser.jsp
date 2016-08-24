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
		var row=$('#dg_user_list').datagrid('getRows');
		//alert(row[iiiii].deptid);
		//alert(row[iiiii].name);
		var user = row[iiiii];
		$('#ff_update_user').form('load',row[iiiii]);
		
		
		/*$('#t2').textbox('setText',user.name);
		$('#t2').textbox('setValue',user.id);*/
		
		
		/*$('#ff_update_user').form('load', { 
            data:row[iiiii], 
            onBeforeLoad: function(){ 
            }, 
            onLoadSuccess:function(data){ 
                alert(321321); 
            } 
        });*/
	});
</script>

<center>
	<div style="padding:10px 60px 20px 60px">
	    <form id="ff_update_user" method="post">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>
	    				真实姓名:
	    				<input type="hidden" name="id" />
	    			</td>
	    			<td><input class="easyui-textbox" type="text" name="realname" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>用户名:</td>
	    			<td><input class="easyui-textbox" type="text" name="loginname" data-options="required:true,validType:'email'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td><input class="easyui-textbox" type="text" name="password" data-options="required:true,validType:'email'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>邮箱:</td>
	    			<td><input class="easyui-textbox" type="text" name="mail" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td>
	    				<input type="radio" checked="checked" name="sex" value="男" />男
	    				<input type="radio" name="sex" value="女" />女
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td><input class="easyui-textbox" type="text" name="tel" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>部门:</td>
	    			<td>
	    				<%--<select id="cc_dept_list" name="deptid" style="width:150px"></select>--%>
	    				<input class="easyui-textbox" name="deptid" id="t2" data-options="buttonIcon:'icon-large-chart',onClickButton:insert_dept">
	    				<div id="win_insert_user">
	    						<iframe src="<%=request.getContextPath()%>/user/toDeptZtreeList.action" width="100%" height="100%" frameborder="0"></iframe>
	    				</div> 
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm_update_user()">保存</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>
	    </div>
	 </div>
</center>
	<script>
	function insert_dept(){
		$('#win_insert_user').window('open');
	}

	$('#win_insert_user').window({    
	    width:200,    
	    height:350,    
	    modal:true,
	    minimizable:false,
	    collapsible:false,
	    maximizable:false,
	    title:"部门",
	    closed: true
	}); 

	
	function setDeptid(treeNode){
		$('#win_insert_user').window('close');
		$("#t2").textbox("setValue",treeNode.id);
		$("#t2").textbox("setText",treeNode.name);
		
	}
	
	
	
	
	
	
	
	
	
	
	
		function submitForm_update_user(){
			var url="<%=request.getContextPath()%>/user/updateUser.action";
			$.post(url,$("#ff_update_user").serialize(),function(flag){
				if(flag){
					$.messager.show({
						title:'温馨提示',
						msg:'数据修改成功',
						timeout:2000,
						showType:'slide'
					});
					$('#dd_insert_user').dialog({closed: true});
					$('#ff_update_user').form('clear');
					$("#dg_user_list").datagrid('reload');
				}else{
					$.messager.show({
						title:'温馨提示',
						msg:'数据修改失败',
						timeout:2000,
						showType:'slide'
					});
				}
			},'json');
		}
		function clearForm(){
			$('#ff_update_user').form('clear');
		}
	</script>
	
	
	
	<%--<div id="sp">
		<div style="padding:10px" id="treeDemo2" class="ztree">
			<script type="text/javascript">
				$(function(){
					var url="<%=request.getContextPath()%>/user/deptZtreeList.action";
					$.post(url,{},function(data){
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
						
						$(document).ready(function(){
							$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
						});
						
					},'json');
				})
			</script>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$('#cc_dept_list').combo({
				required:true,
				editable:false
			});
			$('#sp').appendTo($('#cc_dept_list').combo('panel'));
		});
		
		function zTreeOnClick(event, treeId, treeNode) {
			$('#cc_dept_list').combo('setValue', treeNode.id).combo('setText', treeNode.name).combo('hidePanel');
		};
	</script>--%>
</body>
</html>