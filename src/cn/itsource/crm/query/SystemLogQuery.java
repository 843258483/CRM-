package cn.itsource.crm.query;

import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.jdbc.datasource.init.DatabasePopulatorUtils;

/**
 * 子类的查询条件
 * 
 * @author 
 *
 */
public class SystemLogQuery extends BaseQuery {

	//开始时间
	private Date opTimeBegin;
	//截止时间
	private Date opTimeEnd;
	//按操作人员来查询
	private Long id;
	
	public Date getOpTimeBegin() {
		return opTimeBegin;
	}
	public void setOpTimeBegin(Date opTimeBegin) {
		this.opTimeBegin = opTimeBegin;
	}
	public Date getOpTimeEnd() {
		return opTimeEnd;
	}
	public void setOpTimeEnd(Date opTimeEnd) {
		//控制查询时间分界线为凌晨0时
		if(opTimeEnd != null){
			opTimeEnd = DateUtils.addDays(opTimeEnd, 1);
		}
		this.opTimeEnd = opTimeEnd;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
}
