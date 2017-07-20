package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author Administrator
 * 潜在用户 开发计划
 */
public class CustomerDevPlan {
	private Long id;   //系统自动生成 输入框只读	
	private Date planTime; // 计划时间 日期
	private String planSubject; // 计划 必填
	private String planDetails; // 计划的详细内容 必填
	private Date inputTime = new Date(); //当前系统时间	输入框只读	必填
	
	private PotentialCustomer potentialCustomer; //潜在客户对象	
	private Employee inputUser; //自动填入当前登录用户，用户不可更改	输入框只读	必填
	//计划实施方式	planType	计划采用如电话、邀约上门等	数据字典	是
	private SystemDictionaryItem planType;
	
	
	
	
	public SystemDictionaryItem getPlanType() {
		return planType;
	}
	public void setPlanType(SystemDictionaryItem planType) {
		this.planType = planType;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getPlanTime() {
		return planTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}
	public String getPlanSubject() {
		return planSubject;
	}
	public void setPlanSubject(String planSubject) {
		this.planSubject = planSubject;
	}
	public String getPlanDetails() {
		return planDetails;
	}
	public void setPlanDetails(String planDetails) {
		this.planDetails = planDetails;
	}
	public PotentialCustomer getPotentialCustomer() {
		return potentialCustomer;
	}
	public void setPotentialCustomer(PotentialCustomer potentialCustomer) {
		this.potentialCustomer = potentialCustomer;
	}
	public Employee getInputUser() {
		return inputUser;
	}
	public void setInputUser(Employee inputUser) {
		this.inputUser = inputUser;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getInputTime() {
		return inputTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}
	
}
