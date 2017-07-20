package cn.itsource.crm.query;

import java.sql.Date;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 子类的查询条件
 * 
 * @author Arick
 *
 */
public class CustomerQuery extends BaseQuery {
	private Integer state;
	private Integer seller;
	private Integer maxAge;
	private Date inputTimes;
	private Integer jobId;
	private Integer salaryLevelId;	
	
	
	
	public Integer getMaxAge() {
		return maxAge;
	}
	public void setMaxAge(Integer maxAge) {
		this.maxAge = maxAge;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getInputTimes() {
		return inputTimes;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setInputTime(Date inputTimes) {
		this.inputTimes = inputTimes;
	}
	public Integer getJobId() {
		return jobId;
	}
	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}
	public Integer getSalaryLevelId() {
		return salaryLevelId;
	}
	public void setSalaryLevelId(Integer salaryLevelId) {
		this.salaryLevelId = salaryLevelId;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		
		this.state = state;
	}
	public Integer getSeller() {
		return seller;
	}
	public void setSeller(Integer seller) {
		this.seller = seller;
	}

	
	
	
}
