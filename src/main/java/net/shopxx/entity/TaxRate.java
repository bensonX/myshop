/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.entity;

import java.math.BigDecimal;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity - 税率
 * 
 * @author JSHOP sunmaolin
 *
 */
@Entity
@Table(name = "xx_tax_rate")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "seq_tax_rate")
public class TaxRate extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5880185661691281403L;

	/**
	 * 商品税率Code
	 */
	private String hsCode;
	/**
	 * 商品种类
	 */
	private String categrory;
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
	@JsonIgnore
	private Set<Goods> goods;

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
	 * 获取商品种类
	 * 
	 * @return
	 */
	@Column(nullable = false)
	public String getCategrory() {
		return categrory;
	}

	/**
	 * 设置商品种类
	 * 
	 * @param categrory
	 *            商品种类
	 */
	public void setCategrory(String categrory) {
		this.categrory = categrory;
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
	 * 获取所有货品
	 * 
	 * @return
	 */
	@OneToMany(mappedBy = "taxRate", fetch = FetchType.LAZY, cascade = { CascadeType.DETACH })
	public Set<Goods> getGoods() {
		return goods;
	}

	/**
	 * 设置所有货品
	 * 
	 * @param goods
	 */
	public void setGoods(Set<Goods> goods) {
		this.goods = goods;
	}

	/**
	 * 添加商品
	 * 
	 * @param goods
	 *            商品
	 * @return 是否成功
	 */
	@Transient
	public boolean addGoods(Goods goods) {
		return this.goods.add(goods);
	}

	/**
	 * 移除商品
	 * 
	 * @param goods
	 *            商品
	 * @return 是否成功
	 */
	@Transient
	public boolean removeGoods(Goods goods) {
		return this.goods.remove(goods);
	}

}
