package com.baidu.image.service;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.image.dao.ImageDaoI;
import com.baidu.image.entity.Chart;
import com.baidu.image.entity.Image;
import com.baidu.image.entity.JsonData;
import com.baidu.product.entity.Require;

@Service
public class ImageServiceImpl implements ImageServiceI{

	@Autowired
	private ImageDaoI dao;

	@Override
	public void insertImage(Image image) {
		dao.insertImage(image);
	}

	@Override
	public List checkImage(int require_id) {
		return dao.checkImage(require_id);
	}

	@Override
	public Image imageListById(Integer image_id) {
		return dao.imageListById(image_id);
	}

	@Override
	public List<Map> getComments() {
		return dao.getComments();
	}

	@Override
	public List<Map> getRequire() {
		return dao.getRequire();
	}

	@Override
	public List<Map> getPro() {
		return dao.getPro();
	}

	@Override
	public List<Map> getPromodel() {
		return dao.getPromodel();
	}

	@Override
	public List<Map> getPlan() {
		return dao.getPlan();
	}

	@Override
	public List<Map> getFrom() {
		return dao.getFrom();
	}

	@Override
	public List<Map> getExamuser() {
		return dao.getExamuser();
	}

	@Override
	public List<Image> getImageListByReqid(Integer require_id) {
		return dao.getImageListByReqid(require_id);
	}

	@Override
	public List<Map> getRequireList() {
		return dao.getRequireList();
	}

	@Override
	public int getImageSize() {
		return dao.getImageSize();
	}

	@Override
	public int insertCopyReq(Require require) {
		return dao.insertCopyReq(require);
	}

	@Override
	public int insertAllReq(List<Require> requireList) {
		return dao.insertAllReq(requireList);
	}

	@Override
	public JsonData checkProData() {
		List checkProData = dao.checkProData();
		Chart chart = new Chart();
		JsonData jsonData = new JsonData();
		jsonData.setData(checkProData);
		jsonData.setChart(chart);
		return jsonData;
	}

	@Override
	public List checkFrom() {
		return dao.checkFrom();
	}

	@Override
	public List checkPlan() {
		return dao.checkPlan();
	}

	
}
