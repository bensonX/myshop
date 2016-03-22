/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service.impl;

import javax.annotation.Resource;

import net.shopxx.dao.LogDao;
import net.shopxx.entity.Log;
import net.shopxx.service.LogService;

import org.springframework.stereotype.Service;

/**
 * Service - 日志
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Service("logServiceImpl")
public class LogServiceImpl extends BaseServiceImpl<Log, Long> implements LogService {

	@Resource(name = "logDaoImpl")
	private LogDao logDao;

	public void clear() {
		logDao.removeAll();
	}

}