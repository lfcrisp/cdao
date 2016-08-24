package com.baidu.dept.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.dept.entity.Dept;
import com.baidu.dept.service.DeptServiceI;

@Controller
@RequestMapping("dept")
public class DeptController {

	@Autowired
	private DeptServiceI service;
	
	@RequestMapping("dept_list")
	@ResponseBody
	public List dept_list(){
		List list = service.dept_list();
		return list;
	}
	
	@RequestMapping("toDeptList")
	public String toDeptList(){
		return "zuzhi/dept/deptList";
	}
	
	@RequestMapping("toInsertDeptList")
	public String toInsertDeptList(){
		return "zuzhi/dept/insertDeptList";
	}
	
	
	 @RequestMapping("update_dept")
     @ResponseBody
     public boolean update_dept(@RequestBody List<Dept> rowsString){
		/* for (Dept dept : rowsString) {
			System.out.println(dept.getId()+dept.getName()+dept.getPname()+dept.getPid());
		}
		return true;*/
    	
    	int i=0; 
    	for (Dept dept : rowsString) {
			i = service.update_dept(dept);
		}
    	if(i>0){
    		return true;
    	}
    	return false;
     }
	 
	 
	 @RequestMapping("insert_dept")
     @ResponseBody
     public boolean insert_dept(@RequestBody List<Dept> rowsString){
    	
    	int i=0; 
    	for (Dept dept : rowsString) {
			i = service.insert_dept(dept);
		}
    	if(i>0){
    		return true;
    	}
    	return false;
     }
	 
	 @RequestMapping("delete_dept")
     @ResponseBody
     public boolean delete_dept(@RequestBody List<Dept> rowsString){
    	
    	int i=0; 
    	for (Dept dept : rowsString) {
			i = service.delete_dept(dept);
		}
    	if(i>0){
    		return true;
    	}
    	return false;
     }
	    
	
	
}
