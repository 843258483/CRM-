package cn.itsource.crm.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 员工模型
 * 
 * @author Arick
 *
 */
public class Employee {
	private Long id;
	private String username;// 员工账号,非空
	private String realName;// 真实姓名,非空
	private String password;// 密码，非空
	private String tel;// 电话,非空
	private String email;// 邮箱
	private Date inputTime = new Date();// 录用时间
	private Integer state = 0;// 状态：0--》正常(默认为0) 1--》离职
	private Department department;// 所属部门
	//角色
	private List<Role> roles = new ArrayList<Role>();
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getInputTime() {
		return inputTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", username=" + username + "]";
	}
	

	

	
	
	


}
