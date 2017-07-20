package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author Administrator
 *	潜在客户模型
 */
public class PotentialCustomer {
	private Long id;  //主键 id 无业务意义
	private String name;  //基本资料 姓名  必填
	private Integer successRate; // 	从0到100的数字	数字	必填
	private String remark;  //对潜在客户的简要备注	文本	必填
	private String linkMan;		//联系人 文本
	private String linkManTel;		//联系人 电话文本
	private Employee inputUser; //自动填入当前登录用户，用户不可更改	输入框只读	是
	private Date inputTime = new Date();
	//客户来源	customerSource		数据字典	
	private SystemDictionaryItem customerSource;
	
	
	
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getText() {
		return name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSuccessRate() {
		return successRate;
	}
	public void setSuccessRate(Integer successRate) {
		this.successRate = successRate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	public String getLinkManTel() {
		return linkManTel;
	}
	public void setLinkManTel(String linkManTel) {
		this.linkManTel = linkManTel;
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
	public SystemDictionaryItem getCustomerSource() {
		return customerSource;
	}
	public void setCustomerSource(SystemDictionaryItem customerSource) {
		this.customerSource = customerSource;
	}
	
	@Override
	public String toString() {
		return "PotentialCustomer [id=" + id + ", name=" + name + ", successRate=" + successRate + ", remark=" + remark
				+ ", linkMan=" + linkMan + ", linkManTel=" + linkManTel + ", inputTime=" + inputTime + "]";
	}
	

}
