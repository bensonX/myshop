/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao.impl;

import net.shopxx.dao.OrderLogDao;
import net.shopxx.entity.OrderLog;

import org.springframework.stereotype.Repository;

/**
 * Dao - 订单记录
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Repository("orderLogDaoImpl")
public class OrderLogDaoImpl extends BaseDaoImpl<OrderLog, Long> implements OrderLogDao {

}