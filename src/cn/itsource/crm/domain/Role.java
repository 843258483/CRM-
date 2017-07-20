package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色模型
 * 
 * @author Arick
 *
 */
public class Role {
	private Long id;
	private String name;// 角色名称
	private List<Permission> permissions = new ArrayList<Permission>();

	// 专门处理中间表的对象
	public List<Map<String, Long>> getPermissionMap() {
		List<Map<String, Long>> list = new ArrayList<Map<String, Long>>();
		for (Permission permission : getPermissions()) {
			Map<String, Long> map = new HashMap<String, Long>();// 就是一个类似于RolePermission,domain对象
			map.put("roleId", getId());
			map.put("permissionId", permission.getId());
			list.add(map);
		}
		return list;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	@Override
	public String toString() {
		return "Role [id=" + id + ", name=" + name + "]";
	}
	

}
