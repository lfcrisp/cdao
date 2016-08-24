package com.baidu.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.product.entity.Plan;
import com.baidu.product.entity.Pro;
import com.baidu.product.entity.Promodel;
import com.baidu.product.entity.Require;
import com.baidu.product.service.ProServiceI;


@Controller
@RequestMapping("product")
public class ProController {

	@Autowired
	private ProServiceI service;
	
	//产品编号
	private int id;
	
	@RequestMapping("toProductMain")
	public String toProductMain(HttpServletRequest request){
		List list=service.getProName();
		request.setAttribute("proList", list);
		return "Product/productMain";
	}
	
	@RequestMapping("toInsertProduct")
	public String toInsertProject(){
		return "Product/insertProduct";
	}
	
	@RequestMapping("toRequireReport")
	public String toRequireReport(){
		return "Product/requireReport";
	}
	
	@RequestMapping("getUserDeptList")
	@ResponseBody
	public List getUserDeptList(){
		List list = service.getUserDeptList();
		return list;
	} 
	
	@RequestMapping("getProTypeList")
	@ResponseBody
	public List getProTypeList(){
		List list = service.getProTypeList();
		return list;
	}
	
	@RequestMapping("insertProduct")
	@ResponseBody
	public boolean insertProduct(Pro pro){
		boolean flag=service.insertProduct(pro);
		return flag;
	} 
	
	@RequestMapping("toCheckProductList")
	public String toCheckProductList(){
		return "Product/checkProductList";
	}
	
	@RequestMapping("checkProductList")
	@ResponseBody
	public List checkProductList(){
		List list = service.checkProductList();
		return list;
	}
	
	@RequestMapping("toCheckProduct")
	public String toCheckProduct(){
		return "Product/productList";
	}
	
	@RequestMapping("toProductRequireList")
	public String toProductRequireList(int id){
		this.id=id;
		return "Product/productRequireList";
	}
	
	@RequestMapping("productPromodelList")
	@ResponseBody
	public List productPromodelList(){
		List list=service.productPromodelList(id);
		return list;
	}
	
	@RequestMapping("toInsertRequire")
	public String toInsertRequire(){
		return "Product/insertRequire";
	}
	
	@RequestMapping("checkPro")
	@ResponseBody
	public List checkPro(){
		List list=service.getProName();
		return list;
	}
	
	@RequestMapping("checkPromodel")
	@ResponseBody
	public List checkPromodel(Promodel promodel){
		List list=service.checkPromodel(promodel);
		return list;
	}
	
	@RequestMapping("checkPlan")
	@ResponseBody
	public List checkPlan(Plan plan){
		List list=service.checkPlan(plan);
		return list;
	}
	
	@RequestMapping("checkPlanList")
	@ResponseBody
	public List checkPlanList(){
		List list=service.checkPlanList();
		return list;
	}
	
	@RequestMapping("insertRequire")
	@ResponseBody
	public boolean insertRequire(Require require,HttpServletRequest request){
		boolean flag=service.insertRequire(require);
		System.out.println(require.getId());
		request.getSession().setAttribute("require_id", require.getId());
		return flag;
	} 
	
	@RequestMapping("checkProductRequire")
	@ResponseBody
	public List checkProductRequire(){
		List list=service.checkProductRequire(id);
		return list;
	}
	
	
	//上传图片
	
	
}
