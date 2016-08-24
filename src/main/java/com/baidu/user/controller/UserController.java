package com.baidu.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.dept.entity.Dept;
import com.baidu.user.entity.User;
import com.baidu.user.service.UserServiceI;




@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	private UserServiceI service;
	
	@RequestMapping("toUserList")
	public String toUserList(){
		return "zuzhi/user/userList";
	}
	
	@RequestMapping("deptZtreeList")
	@ResponseBody
	public List deptZtreeList(){
		List list=service.deptZtreeList();
		return list;
	}
	
	@RequestMapping("userList")
	@ResponseBody
	public List userList(Dept dept){
		List list=service.userList(dept);
		return list;
	}
	
	@RequestMapping("deleteUser")
	@ResponseBody
	public boolean deleteUser(User user){
		boolean flag=service.deleteUser(user);
		return flag;
	}
	
	@RequestMapping("toInsertUserList")
	public String toInsertUserList(){
		return "zuzhi/user/insertUser";
	}
	
	@RequestMapping("toDeptZtreeList")
	public String toDeptZtreeList(){
		return "zuzhi/user/deptZtreeList";
	}
	
	@RequestMapping("insertUser")
	@ResponseBody
	public boolean insertUser(User user){
		boolean flag=service.insertUser(user);
		return flag;
	}
	
	@RequestMapping("toUpdateUserList")
	public String toUpdateUserList(){
		return "zuzhi/user/updateUser";
	}
	
	@RequestMapping("updateUser")
	@ResponseBody
	public boolean updateUser(User user){
		boolean flag=service.updateUser(user);
		return flag;
	}
}
