package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author Administrator
 * 客户跟进历史模型
 */
public class CustomerTraceHistory {
	private Long id; //主键，系统自动生成	数据库自动生成
	private Customer customer; //跟进的哪一个客户	客户对象	必填
	private Employee traceUser; //员工对象	必填
	private SystemDictionaryItem traceType; //跟进方式 必填
	
	
	private Date traceTime; //日期	是必填
	private Integer traceResult; //跟进效果	traceResult	优、中、差	数字	 1,0,-1 必填
	private String title; //跟进主题 QQ聊天 或是 其他
	private String remark; //跟进的细节，如：QQ聊天记录等	文本	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Employee getTraceUser() {
		return traceUser;
	}
	public void setTraceUser(Employee traceUser) {
		this.traceUser = traceUser;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getTraceTime() {
		return traceTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setTraceTime(Date traceTime) {
		this.traceTime = traceTime;
	}
	
	public SystemDictionaryItem getTraceType() {
		return traceType;
	}
	public void setTraceType(SystemDictionaryItem traceType) {
		this.traceType = traceType;
	}
	public Integer getTraceResult() {
		return traceResult;
	}
	public void setTraceResult(Integer traceResult) {
		this.traceResult = traceResult;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
}
