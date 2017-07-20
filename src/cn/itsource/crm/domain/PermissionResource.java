package cn.itsource.crm.domain;

public class PermissionResource {
	private Long permissionId;
	private Long resourceId;

	public PermissionResource() {

	}

	public PermissionResource(Long permissionId, Long resourceId) {
		this.permissionId = permissionId;
		this.resourceId = resourceId;
	}

	public Long getResourceId() {
		return resourceId;
	}

	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
	}

	public Long getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Long permissionId) {
		this.permissionId = permissionId;
	}

	@Override
	public String toString() {
		return "PermissionResource [resourceId=" + resourceId + ", permissionId=" + permissionId + "]";
	}

}
