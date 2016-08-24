package com.baidu.dept.entity;

import java.util.ArrayList;
import java.util.List;

public class Dept {
	private Integer id;
	private String name;
	private Integer pid;
	private String text;
	private Boolean open = true;
	
	
	public String getText() {
		return name;
	}
	public Boolean getOpen() {
		return open;
	}
	public void setOpen(Boolean open) {
		this.open = open;
	}
	public void setText(String text) {
		this.text = text;
	}



	private List children = new ArrayList();
	
	
	public List getChildren() {
		return children;
	}
	public void setChildren(List children) {
		this.children = children;
	}
	
	
	
	private String pname;
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
