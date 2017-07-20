package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 保修单模型：在合同保存的时候自动生成一张保修单
 * 
 * @author Arick
 *
 */
public class Guarantee {
	private Long id;
	// 保修单号：给它一个默认值（ 保修单的时候自动生成保修单号）
	private String sn = UUID.randomUUID().toString().substring(0, 6);
	private Integer state = 0;// 保修单的状态,默认为0	 0：正常， 1：过期
	private Date endTime;// 保修到期时间(合同生成的时间+1年)
	private Customer customer;// 保修客户
	private Contract contract;// 保修单对应的合同
	private List<GuaranteeItem> items = new ArrayList<GuaranteeItem>();// 保修单明细

	public Long getId() {
		return id;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
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

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getEndTime() {
		return endTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public List<GuaranteeItem> getItems() {
		return items;
	}

	public void setItems(List<GuaranteeItem> items) {
		this.items = items;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Guarantee [id=" + id + ", sn=" + sn + ", state=" + state + ", endTime=" + endTime + ", customer="
				+ customer + ", contract=" + contract + ", items=" + items + "]";
	}

}
