/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao;

import net.shopxx.entity.DeliveryCenter;

/**
 * Dao - 发货点
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface DeliveryCenterDao extends BaseDao<DeliveryCenter, Long> {

	/**
	 * 查找默认发货点
	 * 
	 * @return 默认发货点，若不存在则返回null
	 */
	DeliveryCenter findDefault();

	/**
	 * 设置默认发货点
	 * 
	 * @param deliveryCenter
	 *            发货点
	 */
	void setDefault(DeliveryCenter deliveryCenter);

}