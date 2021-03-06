/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao.impl;

import javax.persistence.NoResultException;

import net.shopxx.dao.DeliveryCenterDao;
import net.shopxx.entity.DeliveryCenter;

import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

/**
 * Dao - 发货点
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Repository("deliveryCenterDaoImpl")
public class DeliveryCenterDaoImpl extends BaseDaoImpl<DeliveryCenter, Long> implements DeliveryCenterDao {

	public DeliveryCenter findDefault() {
		try {
			String jpql = "select deliveryCenter from DeliveryCenter deliveryCenter where deliveryCenter.isDefault = true";
			return entityManager.createQuery(jpql, DeliveryCenter.class).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

	public void setDefault(DeliveryCenter deliveryCenter) {
		Assert.notNull(deliveryCenter);

		deliveryCenter.setIsDefault(true);
		if (deliveryCenter.isNew()) {
			String jpql = "update DeliveryCenter deliveryCenter set deliveryCenter.isDefault = false where deliveryCenter.isDefault = true";
			entityManager.createQuery(jpql).executeUpdate();
		} else {
			String jpql = "update DeliveryCenter deliveryCenter set deliveryCenter.isDefault = false where deliveryCenter.isDefault = true and deliveryCenter != :deliveryCenter";
			entityManager.createQuery(jpql).setParameter("deliveryCenter", deliveryCenter).executeUpdate();
		}
	}

}