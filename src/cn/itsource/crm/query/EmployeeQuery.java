package cn.itsource.crm.query;

import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;




/**
 * 子类的查询条件
 * 
 * @author Arick
 *
 */
public class EmployeeQuery extends BaseQuery {
	//状态
	private  Integer state;
	//最小日期
	private Date minDate;
	//最大日期
	private Date maxDate;
	//部门名称
	private Long departmentId;
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Date getMinDate() {
		return minDate;
	}
	public void setMinDate(Date minDate) {
		
		this.minDate = minDate;
	}
	public Date getMaxDate() {
		return maxDate;
	}
	public void setMaxDate(Date maxDate) {
		if(maxDate!=null){
			
			maxDate = DateUtils.addDays(maxDate, 1);
		}
		this.maxDate = maxDate;
	}
	public Long getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}
	
	
}
