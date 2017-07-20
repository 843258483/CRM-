package cn.itsource.crm.service;

import cn.itsource.crm.domain.Permission;
import cn.itsource.crm.query.PageList;

public interface IPermissionService extends IBaseService<Permission> {
	
	// 通过角色ID查询它的权限
	PageList findByRoleId(Long roleId);
	
}