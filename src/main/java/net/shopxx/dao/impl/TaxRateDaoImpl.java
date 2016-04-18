package net.shopxx.dao.impl;

import java.util.Collections;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.dao.TaxRateDao;
import net.shopxx.entity.TaxRate;

/**
 * Dao - 税率
 * 
 * @author sunmaolin
 *
 */
@Repository("taxRateDaoImpl")
public class TaxRateDaoImpl extends BaseDaoImpl<TaxRate, Long>implements TaxRateDao {

	@Override
	public List<TaxRate> findListByHsCode(String hsCode) {
		if (StringUtils.isEmpty(hsCode)) { return Collections.emptyList(); }
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<TaxRate> criteriaQuery = criteriaBuilder.createQuery(TaxRate.class);
		Root<TaxRate> root = criteriaQuery.from(TaxRate.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		restrictions = criteriaBuilder.like(root.<String> get("hsCode"), hsCode + "%");
		criteriaQuery.where(restrictions);
		return findList(criteriaQuery, null, 5, null, null);
	}

}