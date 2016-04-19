package net.shopxx.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.shopxx.dao.TaxRateDao;
import net.shopxx.entity.TaxRate;
import net.shopxx.service.TaxRateService;

/**
 * Service - 税率
 * 
 * @author sunmaolin
 */
@Service("taxRateServiceImpl")
public class TaxRateServiceImpl extends BaseServiceImpl<TaxRate, Long>implements TaxRateService {

	@Resource(name = "taxRateDaoImpl")
	private TaxRateDao taxRateDao;

	@Override
	public List<TaxRate> findListByHsCode(String hsCode) {
		return taxRateDao.findListByHsCode(hsCode);
	}

}