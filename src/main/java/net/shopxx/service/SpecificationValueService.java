/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.SpecificationItem;
import net.shopxx.entity.SpecificationValue;

/**
 * Service - 规格值
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface SpecificationValueService {

	/**
	 * 规格值验证
	 * 
	 * @param specificationItems
	 *            规格项
	 * @param specificationValues
	 *            规格值
	 * @return 验证结果
	 */
	boolean isValid(List<SpecificationItem> specificationItems, List<SpecificationValue> specificationValues);

}