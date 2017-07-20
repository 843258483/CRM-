package cn.itsource.crm.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.Permission;
import cn.itsource.crm.domain.PermissionResource;

public interface PermissionMapper extends BaseMapper<Permission> {

	// 通过角色ID查询它的权限
	List<Permission> findByRoleId(Long roleId);

	// 通过角色ID查询拥有的权限的条数
	int findCountByRoleId(Long roleId);

	// 保存中间表
	void savePermissionResource(PermissionResource permissionResource);

	// 删除中间表
	@Delete("delete from t_permission_resource where permission_id=#{permissionId}")
	void deletePermissionResource(Serializable permissionId);
}
