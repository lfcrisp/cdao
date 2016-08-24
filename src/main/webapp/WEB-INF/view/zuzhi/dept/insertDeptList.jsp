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
		$('#dg_insert_dept_list').datagrid({  
			fitColumns:true,
			fit:true,
			onClickCell:onClickCell,
			iconCls: 'icon-edit',
			rownumbers: true,
			singleSelect: false,
		    columns:[[    
		        {field:'name',title:'部门名称',width:100, 
		        	editor:{
	                    type:"textbox",
	                    options:{
	                        required:true
	                    }
	                }
				},    
		        {field:'pid',title:'所属部门',width:100,
					editor:'textbo'		
		        },    
		    ]],
		    onClickCell:function(index, row){
		    	dept_insert_index=index
		    },
		    toolbar: []
		});
	})
	
	//编辑单元格函数
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
       if(editIndex==undefined){
          $("#dg_insert_dept_list").datagrid("editCell",{index:index,field:field});
          editIndex=index;
       } else {
           $("#dg_insert_dept_list").datagrid("endEdit", editIndex);
           $("#dg_insert_dept_list").datagrid("editCell",{index:index,field:field});
           editIndex=index;
       }
    }
	
	
	/*$.extend($.fn.datagrid.defaults.editors, {    
	    text: {    
	        init: function(container, options){    
	            var input = $('.cc').appendTo(container);    
	            return input;    
	        },    
	        getValue: function(target){ 
	        	var hh=$(target).children("select").combo('getText');
	        	$(target).children("select").combo('clear');
	        	alert(hh)
	            return hh;    
	        },    
	        setValue: function(target, value){   
	        	alert(value)
	            $(target).val(value);    
	        },    
	        resize: function(target, width){    
	            var input = $(target);    
	            if ($.boxModel == true){    
	                input.width(width - (input.outerWidth() - input.width()));    
	            } else {    
	                input.width(width);    
	            }    
	        }    
	    }    
	}); */
	
	
	  
    //自定义textbox编辑器
    $.extend($.fn.datagrid.defaults.editors, {    
		    textbo: {    
		        init: function(container, options){    
		            var text = $("<input class='t2' />").appendTo(container);
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
<table id="dg_insert_dept_list"></table> 
<div id="win_insert_dept">
		<iframe src="<%=request.getContextPath()%>/user/toDeptZtreeList.action" width="100%" height="100%" frameborder="0"></iframe>
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
		$(".t2").textbox("setValue",treeNode.id);
		$(".t2").textbox("setText",treeNode.name);
		
	}
</script>




<%--<div  class="cc">
	<select id="cc_dept_list" class="cc_dept_list" name="deptid" style="width: 320px"></select>
</div>


<div id="sp" class="sp">
	<div style="padding:10px" id="treeDemo_dept" class="ztree">
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
						$.fn.zTree.init($("#treeDemo_dept"), setting, zNodes);
					});
					
				},'json');
			})
		</script>
	</div>
</div>
	<script type="text/javascript">
		$(function(){
			$('.cc_dept_list').combo({
				editable:false
			});
			$('.sp').appendTo($('.cc_dept_list').combo('panel'));
		});
		
		function zTreeOnClick(event, treeId, treeNode) {
			$('.cc_dept_list').combo('setValue', treeNode.id).combo('setText', treeNode.name).combo('hidePanel');
		};
	</script>--%>
</body>
</html>