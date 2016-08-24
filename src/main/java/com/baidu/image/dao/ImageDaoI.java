package com.baidu.image.dao;

import java.util.List;
import java.util.Map;

import com.baidu.image.entity.Image;
import com.baidu.image.entity.JsonData;
import com.baidu.product.entity.Require;

public interface ImageDaoI {

	void insertImage(Image image);

	List checkImage(int require_id);

	Image imageListById(Integer image_id);

	List<Map> getComments();

	List<Map> getRequire();

	List<Map> getPro();

	List<Map> getPromodel();

	List<Map> getPlan();

	List<Map> getFrom();

	List<Map> getExamuser();

	List<Image> getImageListByReqid(Integer require_id);

	List<Map> getRequireList();

	int getImageSize();

	int insertCopyReq(Require require);

	int insertAllReq(List<Require> requireList);

	List checkProData();

	List checkFrom();

	List checkPlan();

}
