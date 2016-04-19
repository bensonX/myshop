package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.TaxRate;

/**
 * Dao - 税率
 * 
 * @author sunmaolin
 *
 */
public interface TaxRateDao extends BaseDao<TaxRate, Long> {

	/**
	 * 依据hsCode获取税率
	 * 
	 * @param hsCode
	 * @return 税率集合
	 */
	List<TaxRate> findListByHsCode(String hsCode);

}