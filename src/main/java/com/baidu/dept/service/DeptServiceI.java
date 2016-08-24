package com.baidu.dept.service;

import java.util.List;

import com.baidu.dept.entity.Dept;

public interface DeptServiceI {

	List dept_list();

	int update_dept(Dept dept);

	int insert_dept(Dept dept);

	int delete_dept(Dept dept);

}
