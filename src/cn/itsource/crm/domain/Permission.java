package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 权限模型 ：不同的角色拥有的权限不同
 * 
 * @author Arick
 *
 */
public class Permission {
	private Long id;
	private String name;// 权限名称
	List<Resource> resources = new ArrayList<Resource>();// 一个权限对应多个资源
//	List<Role> roles = new ArrayList<Role>();// 一个权限对应多个角色

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

	public List<Resource> getResources() {
		return resources;
	}

	public void setResources(List<Resource> resources) {
		this.resources = resources;
	}

//	public List<Role> getRoles() {
//		return roles;
//	}
//
//	public void setRoles(List<Role> roles) {
//		this.roles = roles;
//	}

}
