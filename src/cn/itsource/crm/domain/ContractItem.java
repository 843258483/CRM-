package cn.itsource.crm.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author dcz 合同的明细:
 *
 */
public class ContractItem {
	private Long id;
	private Date payTime;// 付款时间
	private BigDecimal money;// 付款金额
	private BigDecimal scale;// 明细中的金额占所有金额的百分比
	private Boolean isPayment;// 是否付款
	private Customer customer = new Customer(1L);
	private Contract contract;// 合同明细所对应的合同

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}
	@JsonFormat(pattern="yyyy-MM-dd")
	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public Boolean getIsPayment() {
		return isPayment;
	}

	public void setIsPayment(Boolean isPayment) {
		this.isPayment = isPayment;
	}

	public BigDecimal getScale() {
		return scale;
	}

	public void setScale(BigDecimal scale) {
		this.scale = scale;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

}
