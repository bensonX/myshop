/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.SpecificationItem;

/**
 * Service - 规格项
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface SpecificationItemService {

	/**
	 * 规格项过滤
	 * 
	 * @param specificationItems
	 *            规格项
	 */
	void filter(List<SpecificationItem> specificationItems);

}