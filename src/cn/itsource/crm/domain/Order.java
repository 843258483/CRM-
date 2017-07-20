package cn.itsource.crm.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author dcz
 * 订单模型：
 *
 */
public class Order {
	private Long id;
	private String sn;//订单编号，自动生成，使用uuid的前6位
	private Date signTime;//订单签订的时间
	private BigDecimal sum;//定金金额， 在添加的时候自动创建一个合同及其明细，将定金放入明细中
	private Integer state = 0;//值可以为0：正常， 1：作废， -1：请选择
	private Contract contract;//将订单关联到合同，一个订单对应一个合同
	private Customer customer;//签订订单的客户
	private Employee seller;//此客户的营销人员
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+8")
	public Date getSignTime() {
		return signTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}

	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Employee getSeller() {
		return seller;
	}
	public void setSeller(Employee seller) {
		this.seller = seller;
	}
	public BigDecimal getSum() {
		return sum;
	}
	public void setSum(BigDecimal sum) {
		this.sum = sum;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Contract getContract() {
		return contract;
	}
	public void setContract(Contract contract) {
		this.contract = contract;
	}

	
	
}
