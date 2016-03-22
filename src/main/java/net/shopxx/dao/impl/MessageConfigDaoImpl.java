/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao.impl;

import javax.persistence.NoResultException;

import net.shopxx.dao.MessageConfigDao;
import net.shopxx.entity.MessageConfig;

import org.springframework.stereotype.Repository;

/**
 * Dao - 消息配置
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Repository("messageConfigDaoImpl")
public class MessageConfigDaoImpl extends BaseDaoImpl<MessageConfig, Long> implements MessageConfigDao {

	public MessageConfig find(MessageConfig.Type type) {
		if (type == null) {
			return null;
		}
		try {
			String jpql = "select messageConfig from MessageConfig messageConfig where messageConfig.type = :type";
			return entityManager.createQuery(jpql, MessageConfig.class).setParameter("type", type).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

}