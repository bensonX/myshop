/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao.impl;

import javax.persistence.NoResultException;

import net.shopxx.dao.PaymentLogDao;
import net.shopxx.entity.PaymentLog;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

/**
 * Dao - 支付记录
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Repository("paymentLogDaoImpl")
public class PaymentLogDaoImpl extends BaseDaoImpl<PaymentLog, Long> implements PaymentLogDao {

	public PaymentLog findBySn(String sn) {
		if (StringUtils.isEmpty(sn)) {
			return null;
		}
		String jpql = "select paymentLog from PaymentLog paymentLog where lower(paymentLog.sn) = lower(:sn)";
		try {
			return entityManager.createQuery(jpql, PaymentLog.class).setParameter("sn", sn).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

}