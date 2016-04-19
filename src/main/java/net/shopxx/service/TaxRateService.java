package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.TaxRate;

/**
 * Service - 税率
 * 
 * @author sunmaolin
 * 
 */
public interface TaxRateService extends BaseService<TaxRate, Long> {

	/**
	 * 依据hsCode获取税率
	 * 
	 * @param hsCode
	 * @return 税率集合
	 */
	List<TaxRate> findListByHsCode(String hsCode);

}