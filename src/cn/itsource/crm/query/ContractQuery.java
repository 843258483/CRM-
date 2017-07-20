package cn.itsource.crm.query;

import java.util.Date;

/**
 * 子类的查询条件
 * 
 * @author dcz
 *
 */
public class ContractQuery extends BaseQuery {
	private Long customerId;// 提供一个客户的id，可以通过这个id来查询合同
	private Long sellerId; // 提供一个营销员的id，以此来查询合同
	private Date beginTime;//提供一个时间来查询，这个是开始时间
	private Date endTime;//提供一个时间来查询，这个是结束时间
	private  Integer state;//状态0：正常， -1：请选择， 1：作废

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public Long getSellerId() {
		return sellerId;
	}

	public void setSellerId(Long sellerId) {
		this.sellerId = sellerId;
	}
}
