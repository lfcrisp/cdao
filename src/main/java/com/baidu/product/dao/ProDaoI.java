package com.baidu.product.dao;

import java.util.List;

import com.baidu.product.entity.Plan;
import com.baidu.product.entity.Pro;
import com.baidu.product.entity.Promodel;
import com.baidu.product.entity.Require;

public interface ProDaoI {

	List getUserDeptList();

	List getProTypeList();

	int insertProduct(Pro pro);

	List checkProductList();

	List getProName();

	List productPromodelList(int id);

	List checkPromodel(Promodel promodel);

	List checkPlan(Plan plan);

	List checkPlanList();

	int insertRequire(Require require);

	List checkProductRequire(int id);

}
