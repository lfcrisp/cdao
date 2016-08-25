package com.baidu.quartz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.image.entity.EcharData;
import com.baidu.quartz.dao.QtzDaoI;
@Service
public class QtzServiceImpl implements QtzServiceI {

	@Autowired
	private QtzDaoI dao;
	@Override
	public List<EcharData> checkPlan() {
		return dao.checkPlan();
	}

}
