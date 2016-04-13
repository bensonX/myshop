/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;

/**
 * Entity - 税率
 * 
 * @author JSHOP sunmaolin
 *
 */
@Entity
@Table(name = "xx_tax_rates")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "seq_tax_rates")
public class TaxRates extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5880185661691281403L;

	/**
	 * 商品税率Code
	 */
	private String hsCode;
	/**
	 * 关税税率
	 */
	private BigDecimal tariffRate;
	/**
	 * 消费税税率
	 */
	private BigDecimal consumptionTaxRate;
	/**
	 * 增值税税率
	 */
	private BigDecimal vatRate;
	/**
	 * 综合税税率
	 */
	private BigDecimal comprehensiveTaxRate;
	/**
	 * 货品
	 */
	private Goods goods;

	/**
	 * 获取商品税率Code
	 * 
	 * @return 商品税率Code
	 */
	@Column(nullable = false)
	public String getHsCode() {
		return hsCode;
	}

	/**
	 * 设置商品税率Code
	 * 
	 * @param hsCode
	 *            商品税率Code
	 */
	public void setHsCode(String hsCode) {
		this.hsCode = hsCode;
	}

	/**
	 * 获取关税税率
	 * 
	 * @return 关税税率
	 */
	@Min(0)
	@Digits(integer = 11, fraction = 4)
	@Column(nullable = false)
	public BigDecimal getTariffRate() {
		return tariffRate;
	}

	/**
	 * 设置关税税率
	 * 
	 * @param tariffRate
	 *            关税税率
	 */
	public void setTariffRate(BigDecimal tariffRate) {
		this.tariffRate = tariffRate;
	}

	/**
	 * 获取消费税税率
	 * 
	 * @return 消费税税率
	 */
	@Min(0)
	@Digits(integer = 11, fraction = 4)
	@Column(nullable = false)
	public BigDecimal getConsumptionTaxRate() {
		return consumptionTaxRate;
	}

	/**
	 * 设置消费税税率
	 * 
	 * @param consumptionTaxRate
	 *            消费税税率
	 */
	public void setConsumptionTaxRate(BigDecimal consumptionTaxRate) {
		this.consumptionTaxRate = consumptionTaxRate;
	}

	/**
	 * 获取增值税税率
	 * 
	 * @return 增值税税率
	 */
	@Min(0)
	@Digits(integer = 11, fraction = 4)
	@Column(nullable = false)
	public BigDecimal getVatRate() {
		return vatRate;
	}

	/**
	 * 设置增值税税率
	 * 
	 * @param vatRate
	 *            增值税税率
	 */
	public void setVatRate(BigDecimal vatRate) {
		this.vatRate = vatRate;
	}

	/**
	 * 获取综合税税率
	 * 
	 * @return 综合税税率
	 */
	@Min(0)
	@Digits(integer = 11, fraction = 4)
	@Column(nullable = false)
	public BigDecimal getComprehensiveTaxRate() {
		return comprehensiveTaxRate;
	}

	/**
	 * 设置综合税税率
	 * 
	 * @param comprehensiveTaxRate
	 *            综合税税率
	 */
	public void setComprehensiveTaxRate(BigDecimal comprehensiveTaxRate) {
		this.comprehensiveTaxRate = comprehensiveTaxRate;
	}

	/**
	 * 获取货品
	 * 
	 * @return 货品
	 */
	@OneToOne(fetch = FetchType.LAZY)
	public Goods getGoods() {
		return goods;
	}

	/**
	 * 设置货品
	 * 
	 * @param goods
	 *            货品
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

}
