package cn.itsource.crm.domain;

/**
 * 封装中间表的数据(role_permission)
 * 
 * @author Arick
 *
 */
public class RolePermission {
	private Long roleId;// role的ID
	private Long permissionId;// permission的ID

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Long permissionId) {
		this.permissionId = permissionId;
	}

	public RolePermission() {

	}

	public RolePermission(Long roleId, Long permissionId) {
		this.roleId = roleId;
		this.permissionId = permissionId;
	}

	@Override
	public String toString() {
		return "RolePermission [roleId=" + roleId + ", permissionId=" + permissionId + "]";
	}

}
