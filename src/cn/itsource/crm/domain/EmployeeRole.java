package cn.itsource.crm.domain;

public class EmployeeRole {
	//
	private Long employeeId;
	private Long roleId;

	public EmployeeRole() {

	}

	public EmployeeRole(Long employeeId, Long roleId) {
		this.employeeId = employeeId;
		this.roleId = roleId;
	}

	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	@Override
	public String toString() {
		return "EmployeeRole [employeeId=" + employeeId + ", roleId=" + roleId + "]";
	}

}
