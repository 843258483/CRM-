package cn.itsource.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
/**系统日志模型*/
public class SystemLog {
	//主键
	private Long id;
	//操作用户
	private String opUser;
	//操作时间
	private Date opTime;
	//登陆Ip
	private String opIp;
	//使用功能
	private String function;
	//操作信息
	private String params;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getOpUser() {
		return opUser;
	}
	public void setOpUser(String opUser) {
		this.opUser = opUser;
	}
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
	public Date getOpTime() {
		return opTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public String getOpIp() {
		return opIp;
	}
	public void setOpIp(String opIp) {
		this.opIp = opIp;
	}
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	@Override
	public String toString() {
		return "SystemLog [id=" + id + ", opUser=" + opUser + ", opTime=" + opTime + ", opIp=" + opIp + ", function="
				+ function + ", params=" + params + "]";
	}
	
	
	
	
	
	
	
}
