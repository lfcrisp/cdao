<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			});
			
		},'json');
		
		
		function zTreeOnClick(event, treeId, treeNode) {
		    $("#dg_user_list").datagrid('reload',{'pid':treeNode.id});
		};

		
		
		$("#dg_user_list").datagrid({
			url:'<%=request.getContextPath()%>/user/userList.action',
			fitColumns:true,
			fit:true,
			singleSelect:true,
			columns:[[
				{field:'id',title:'ID',width:100},    
				{field:'realname',title:'真实姓名',width:100},    
				{field:'loginname',title:'用户名',width:100}, 
				{field:'name',title:'部门',width:100}, 
				{field:'mail',title:'邮箱',width:100}, 
				{field:'sex',title:'性别',width:100}, 
				{field:'tel',title:'电话',width:100}, 
				{field:'adddate',title:'入职日期',width:100},
				{field:'xxx',title:'操作', width:100,
					formatter: function(value,row,index){
						var btn = '<a class="editcls" onClick=updateUser('+index+')  href="javascript:void(0)">修改</a><a class="delcls" onClick=deleteUser('+row.id+')  href="javascript:void(0)">删除</a>';
						return btn;
					}
				}
			]],
			 onLoadSuccess:function(data){
		    	$('.editcls').linkbutton({ iconCls: 'icon-edit',text:'修改' ,plain:true});  
				$('.delcls').linkbutton({ iconCls: 'icon-remove',text:'删除' ,plain:true});
		    },
	    	toolbar: [{
	    		iconCls: 'icon-add',
	    		text : '添加用户',
	    		handler: function(){
	    			$('#dd_insert_user').dialog({    
	    			    title: '添加用户',    
	    			    href:'<%=request.getContextPath()%>/user/toInsertUserList.action'
	    			});  
	    			$('#dd_insert_user').dialog('open');
	    		}
	    	}]
		});
	})
	
	
	$('#dd_insert_user').dialog({    
	    width: 430,    
	    height: 400,    
	    closed: true,    
	});  
	
	
	function updateUser(index){
		iiiii = index;
		var row=$('#dg_user_list').datagrid('getRows');
		$('#dd_insert_user').dialog({
			title:'修改页面',
			href:"<%=request.getContextPath()%>/user/toUpdateUserList.action"
		});
		$('#dd_insert_user').dialog('open');
	}
	
	function deleteUser(id){
		var url="<%=request.getContextPath()%>/user/deleteUser.action";
		$.post(url,{id:id},function(flag){
			if(flag){
				$.messager.show({
					title:'温馨提示',
					msg:'数据删除成功',
					timeout:2000,
					showType:'slide'
				});
				$("#dg_user_list").datagrid('reload');
			}else{
				$.messager.show({
					title:'温馨提示',
					msg:'数据删除失败',
					timeout:2000,
					showType:'slide'
				});
			}
		},'json');
	}
	
</script>


	<div class="easyui-layout"  fit='true'>
		<div data-options="region:'west',split:true" title="部门结构" style="width:200px;">
			<div id="treeDemo" class="ztree"></div>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok'" style="width: 90%">
			<table id="dg_user_list"></table>  
			<div id="dd_insert_user"></div>  
			
			<%--<table id='dept_list' class="easyui-datagrid" title="" fit=true
					data-options="singleSelect:true,collapsible:true,url:'<%=request.getContextPath()%>/user/userList.action',method:'get'">
				<thead>
					<tr>
						<th data-options="field:'id',width:30">ID</th>
						<th data-options="field:'realname',width:50">真实姓名</th>
						<th data-options="field:'loginname',width:50">用户名</th>
						<th data-options="field:'name',width:50">职位</th>
						<th data-options="field:'mail',width:50">邮箱</th>
						<th data-options="field:'sex',width:50">性别</th>
						<th data-options="field:'tel',width:50">电话</th>
						<th data-options="field:'adddate',width:50">入职日期</th>
					</tr>
				</thead>
			</table>
		--%></div>
	</div>
