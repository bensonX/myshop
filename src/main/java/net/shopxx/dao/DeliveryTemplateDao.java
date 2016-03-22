/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao;

import net.shopxx.entity.DeliveryTemplate;

/**
 * Dao - 快递单模板
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface DeliveryTemplateDao extends BaseDao<DeliveryTemplate, Long> {

	/**
	 * 查找默认快递单模板
	 * 
	 * @return 默认快递单模板，若不存在则返回null
	 */
	DeliveryTemplate findDefault();

	/**
	 * 设置默认快递单模板
	 * 
	 * @param deliveryTemplate
	 *            快递单模板
	 */
	void setDefault(DeliveryTemplate deliveryTemplate);

}