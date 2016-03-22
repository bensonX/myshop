/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao.impl;

import javax.persistence.NoResultException;

import net.shopxx.dao.SeoDao;
import net.shopxx.entity.Seo;

import org.springframework.stereotype.Repository;

/**
 * Dao - SEO设置
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Repository("seoDaoImpl")
public class SeoDaoImpl extends BaseDaoImpl<Seo, Long> implements SeoDao {

	public Seo find(Seo.Type type) {
		if (type == null) {
			return null;
		}
		try {
			String jpql = "select seo from Seo seo where seo.type = :type";
			return entityManager.createQuery(jpql, Seo.class).setParameter("type", type).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

}