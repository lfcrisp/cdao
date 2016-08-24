package com.baidu.product.service;

import java.util.List;

import com.baidu.product.entity.Plan;
import com.baidu.product.entity.Pro;
import com.baidu.product.entity.Promodel;
import com.baidu.product.entity.Require;

public interface ProServiceI {

	List getUserDeptList();

	List getProTypeList();

	boolean insertProduct(Pro pro);

	List checkProductList();

	List getProName();

	List productPromodelList(int id);

	List checkPromodel(Promodel promodel);

	List checkPlan(Plan plan);

	List checkPlanList();

	boolean insertRequire(Require require);

	List checkProductRequire(int id);

}
