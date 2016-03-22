/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service.impl;

import java.util.List;

import net.shopxx.entity.SpecificationItem;
import net.shopxx.entity.SpecificationValue;
import net.shopxx.service.SpecificationValueService;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

/**
 * Service - 规格值
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Service("specificationValueServiceImpl")
public class SpecificationValueServiceImpl implements SpecificationValueService {

	public boolean isValid(List<SpecificationItem> specificationItems, List<SpecificationValue> specificationValues) {
		Assert.notEmpty(specificationItems);
		Assert.notEmpty(specificationValues);

		if (specificationValues.size() != specificationValues.size()) {
			return false;
		}
		for (int i = 0; i < specificationValues.size(); i++) {
			SpecificationItem specificationItem = specificationItems.get(i);
			SpecificationValue specificationValue = specificationValues.get(i);
			if (specificationItem == null || specificationValue == null || !specificationItem.isValid(specificationValue)) {
				return false;
			}
		}
		return true;
	}

}