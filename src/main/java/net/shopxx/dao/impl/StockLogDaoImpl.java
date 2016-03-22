/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao.impl;

import net.shopxx.dao.StockLogDao;
import net.shopxx.entity.StockLog;

import org.springframework.stereotype.Repository;

/**
 * Dao - 库存记录
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Repository("stockLogDaoImpl")
public class StockLogDaoImpl extends BaseDaoImpl<StockLog, Long> implements StockLogDao {

}