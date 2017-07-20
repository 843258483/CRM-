package cn.itsource.crm.query;

/**
 * 子类的查询条件
 * 
 * @author Arick
 *
 */
public class PermissionQuery extends BaseQuery {

	private Long roleId;

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

}
