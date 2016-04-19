package net.shopxx.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.shopxx.entity.TaxRate;
import net.shopxx.service.TaxRateService;
import net.shopxx.util.JsonUtils;

/**
 * Controller - 税率
 * 
 * @author sunmaolin
 *
 */
@Controller("taxRateController")
@RequestMapping("/admin/taxRate")
public class TaxRateController extends BaseController {

	@Resource(name = "taxRateServiceImpl")
	private TaxRateService taxRateService;

	/**
	 * 获取税率
	 * 
	 * @param hsCode
	 * @return
	 */
	@RequestMapping(value = "/findTaxRate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findTaxRate(String hsCode) {
		Map<String, Object> data = new HashMap<String, Object>();
		List<TaxRate> taxRates = taxRateService.findListByHsCode(hsCode);
		data.put("result", taxRates);
		return data;
	}

	/**
	 * 获取税率
	 * 
	 * @param hsCode
	 * @return
	 */
	@RequestMapping(value = "/getTaxRate", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getTaxRate(String hsCode) {
		Map<String, Object> data = new HashMap<String, Object>();
		List<TaxRate> taxRates = taxRateService.findListByHsCode(hsCode);
		data.put("result", JsonUtils.toJson(taxRates));
		return data;
	}

}