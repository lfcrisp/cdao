package com.baidu.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.dept.dao.DeptDaoI;
import com.baidu.dept.entity.Dept;

@Service
public class DeptServiceImpl implements DeptServiceI {

	@Autowired
	private DeptDaoI dao;

	public List dept_list() {
		// TODO Auto-generated method stub
		return dao.dept_list();
	}

	public int update_dept(Dept dept) {
		// TODO Auto-generated method stub
		return dao.update_dept(dept);
	}

	public int insert_dept(Dept dept) {
		// TODO Auto-generated method stub
		return dao.insert_dept(dept);
	}

	public int delete_dept(Dept dept) {
		// TODO Auto-generated method stub
		return dao.delete_dept(dept);
	}


}
