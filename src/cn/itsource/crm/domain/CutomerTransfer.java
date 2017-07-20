package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author Administrator
 *	客户移交记录 模型
 */
public class CutomerTransfer {
	private Long id;  //主键，系统自动生成	数据库自动生成	
	private String  transReason;  //移交原因	transReason		文本	
	private Date  transTime;  //移交时间	transTime		日期	是
	private Customer customer;  //客户对象	 必填  要移交的客户
	private Employee transUser;  //实行移交操作的管理人员	填必
	private Employee oldSeller; //客户上的原始市场人员	员工对象	必填
	private Employee newSeller; //客户上的原始市场人员	员工对象	必填
	
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTransReason() {
		return transReason;
	}
	public void setTransReason(String transReason) {
		this.transReason = transReason;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getTransTime() {
		return transTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setTransTime(Date transTime) {
		this.transTime = transTime;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Employee getTransUser() {
		return transUser;
	}
	public void setTransUser(Employee transUser) {
		this.transUser = transUser;
	}
	public Employee getOldSeller() {
		return oldSeller;
	}
	public void setOldSeller(Employee oldSeller) {
		this.oldSeller = oldSeller;
	}
	public Employee getNewSeller() {
		return newSeller;
	}
	public void setNewSeller(Employee newSeller) {
		this.newSeller = newSeller;
	}
}
