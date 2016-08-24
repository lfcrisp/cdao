package com.baidu.product.entity;

import java.util.ArrayList;
import java.util.List;

public class ProDept {

	private String id;
	private String name;
	private String pid;
	
	
	private String text;
	
	private List children = new ArrayList();
	
	
	public List getChildren() {
		return children;
	}
	public void setChildren(List children) {
		this.children = children;
	}
	
	
	public String getText() {
		return name;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
}
