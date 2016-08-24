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
		//加载ztree
		var url="<%=request.getContextPath()%>/user/deptZtreeList.action";
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
			
				$.fn.zTree.init($("#Dept_tree"), setting, zNodes);
			
		},'json');
	})
	
	
	
	
	//显示列表
	$('#dg_dept_list').datagrid({  
		url:'dept/dept_list.action', 
		fitColumns:true,
		fit:true,
		rownumbers: true,
		singleSelect: false,
		 onClickCell:onClickCell,
		 columns:[[   
					{field:'ck',checkbox:true			
					},
      		        {field:'name',title:'部门名称',width:100, 
      		        	editor:{
      	                    type:"textbox",
      	                    options:{
      	                        required:true
      	                    }
      	                }
      				},    
      		        {field:'pname',title:'所属部门',width:100,
      					editor:'textbo'				
      		        }    
	      		 ]],
	    toolbar: [{
	   		iconCls: 'icon-add',
	   		text : '新增行',
	   		handler: function(){
	   			$('#dg_dept_list').datagrid('appendRow',{
	   				name: '',
	   				pname: ''
	   			});
	   		}
	   	},"-",
	          {
	              text:"删除行",
	              iconCls:"icon-save",
	              handler:function(){
	              	$('#dg_dept_list').datagrid('deleteRow',dg_dept_list_index);
	              }
	           },"-",
	          {
	              text:"批量保存",
	              iconCls:"icon-save",
	              handler:function(){
	              	insertAllDept();
	              }
	           },"-",
	          {
	              text:"批量修改",
	              iconCls:"icon-edit",
	              handler:function(){
	              	updateAllDept();
	              }
	           },"-",
	           {
	               text:"批量删除",
	               iconCls:"icon-remove",
	               handler:function(){
	                   deleteAllDept();
	               }
	            }]
	});
		
	
	
	
	 //编辑单元格
     $.extend($.fn.datagrid.methods, {
		editCell: function(jq,param){
			return jq.each(function(){
				var opts = $(this).datagrid('options');
				var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
				for(var i=0; i<fields.length; i++){
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor1 = col.editor;
					if (fields[i] != param.field){
						col.editor = null;
					}
				}
				$(this).datagrid('beginEdit', param.index);
                   var ed = $(this).datagrid('getEditor', param);
                   if (ed){
                       if ($(ed.target).hasClass('textbox-f')){
                           $(ed.target).textbox('textbox').focus();
                       } else {
                           $(ed.target).focus();
                       }
                   }
				for(var i=0; i<fields.length; i++){
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor = col.editor1;
				}
			});
		}
	});
        
    var editIndex=undefined;
    function onClickCell(index, field, value){
    	dg_dept_list_index=index;
        if(editIndex==undefined){
           $("#dg_dept_list").datagrid("editCell",{index:index,field:field});
           editIndex=index;
        } else {
            $("#dg_dept_list").datagrid("endEdit", editIndex);
            $("#dg_dept_list").datagrid("editCell",{index:index,field:field});
            editIndex=index;
        }
    }
        
        
        
        
     //批量修改
     function updateAllDept(){
         $("#dg_dept_list").datagrid("endEdit", editIndex);
         editIndex=undefined;
         
         var rows = $("#dg_dept_list").datagrid("getChanges");
         console.table(rows)
         var rowsString = JSON.stringify(rows);
         $.ajax({
              url:"dept/update_dept.action",
              type:"post",
              data:rowsString,
              success:function(obj){
                   if(obj){
                     $("#dg_dept_list").datagrid("reload");
                  $.messager.show({
			title:"我的消息",
			msg:"数据修改成功",
		    timeout:2000
			}); 
                  } else {
                       $.messager.alert("我的消息","操作失败！","info");
                  }
              },
              dataType:"json",
              contentType:"application/json"
         });
         
     }
        
        
        
        
    //批量添加
    function insertAllDept(){
        $("#dg_dept_list").datagrid("endEdit", editIndex);
        editIndex=undefined;
        
        var rows = $("#dg_dept_list").datagrid("getChanges");
        console.table(rows)
        var rowsString = JSON.stringify(rows);
        $.ajax({
             url:"dept/insert_dept.action",
             type:"post",
             data:rowsString,
             success:function(obj){
                  if(obj){
                    $("#dg_dept_list").datagrid("reload");
                 $.messager.show({
		title:"我的消息",
		msg:"数据添加成功",
	    timeout:2000
		}); 
                 } else {
                      $.messager.alert("我的消息","操作失败！","info");
                 }
             },
             dataType:"json",
             contentType:"application/json"
        });
        
    }
      
     //批量删除
     function deleteAllDept(){
          var rows = $("#dg_dept_list").datagrid("getChecked");
          console.table(rows)
          var rowsString = JSON.stringify(rows);
          $.ajax({
               url:"dept/delete_dept.action",
               type:"post",
               data:rowsString,
               success:function(obj){
                    if(obj){
                      $("#dg_dept_list").datagrid("reload");
                   $.messager.show({
				title:"我的消息",
				msg:"数据删除成功",
			    timeout:2000
				}); 
                   } else {
                        $.messager.alert("我的消息","操作失败！","info");
                   }
               },
               dataType:"json",
               contentType:"application/json"
          });
          
      }
      
</script>
<div class="easyui-layout"  fit='true'>
		<div data-options="region:'west',split:true" title="部门结构" style="width:200px;">
			<div id="Dept_tree" class="ztree"></div>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok'" style="width: 90%">
			<table id="dg_dept_list"></table>  
			<div id="win_insert_dept">
					<iframe src="<%=request.getContextPath()%>/user/toDeptZtreeList.action" width="100%" height="100%" frameborder="0"></iframe>
			</div> 
		</div>
</div>	
<script type="text/javascript">
	function insert_dept(){
		$('#win_insert_dept').window('open');
	}
	
	$('#win_insert_dept').window({    
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
		$('#win_insert_dept').window('close');
		$("#t2").textbox("setValue",treeNode.id);
		$("#t2").textbox("setText",treeNode.name);
	}
</script>

<script type="text/javascript">
//自定义textbox编辑器
$.extend($.fn.datagrid.defaults.editors, {    
	    textbo: {    
	        init: function(container, options){    
	            var text = $("<input class='easyui-textbox' name='pname' id='t2' />").appendTo(container);
	            text.textbox({
	                 icons:[{
	                    iconCls:"icon-large-chart",
	                    handler:function(){
	                    	insert_dept();
	                     //  $("#i").textbox("setValue","ddd");
	                     //  $("#i").textbox("setText","123");
	                     //  alert( $("#i").textbox('getValue'))
	                    }
                   }]
	           });
	   //         text.textbox(options);    
	            return text;    
	        },    
	        getValue: function(target){    
	            return $(target).textbox("getValue");    
	        },    
	        setValue: function(target, value){    
	            $(target).textbox("setValue", value);    
	        },    
	        resize: function(target, width){    
	            var text =   $(target);
	            text.textbox("resize", width);
	        } ,
	        destroy: function(target){
	            $(target).textbox("destroy");
	        }   
	    }    
});  
</script>
</body>
</html>