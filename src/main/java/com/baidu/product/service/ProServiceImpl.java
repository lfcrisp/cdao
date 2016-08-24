package com.baidu.product.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.product.dao.ProDaoI;
import com.baidu.product.entity.Plan;
import com.baidu.product.entity.Pro;
import com.baidu.product.entity.ProDept;
import com.baidu.product.entity.Promodel;
import com.baidu.product.entity.Require;


@Service
public class ProServiceImpl implements ProServiceI {

	@Autowired
	private ProDaoI dao;

	public List getUserDeptList() {
		//平面的集合
		List list = dao.getUserDeptList();
		//空集合
		List list2 = new ArrayList();
		this.treeList(list,list2);
		//返回有嵌套关系的集合
		return list2;
	}
	
		public void treeList(List<ProDept> list,List<ProDept> list2){
			if(list2.size()==0){
				for (ProDept dept : list) {
					//查找根节点
					if(dept.getPid().equals("0")){
						list2.add(dept);
					}
				}
				this.treeList(list, list2);
			}else{
				for (ProDept dept2 : list2) {
					
					for (ProDept dept : list) {
						if(dept.getPid().equals(dept2.getId())){
							List li = dept2.getChildren();
							li.add(dept);
						}
					}
					if(dept2.getChildren().size()>0){
						this.treeList(list, dept2.getChildren());
					}
					
				}
			}
		}

		public List getProTypeList() {
			return dao.getProTypeList();
		}

		public boolean insertProduct(Pro pro) {
			int i=dao.insertProduct(pro);
			return i>0;
		}

		public List checkProductList() {
			return dao.checkProductList();
		}

		public List getProName() {
			return dao.getProName();
		}

		public List productPromodelList(int id) {
			return dao.productPromodelList(id);
		}

		public List checkPromodel(Promodel promodel) {
			return dao.checkPromodel(promodel);
		}

		public List checkPlan(Plan plan) {
			return dao.checkPlan(plan);
		}

		public List checkPlanList() {
			return dao.checkPlanList();
		}

		public boolean insertRequire(Require require) {
			int i=dao.insertRequire(require);
			return i>0;
		}

		public List checkProductRequire(int id) {
			return dao.checkProductRequire(id);
		}
}
