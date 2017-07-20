package cn.itsource.crm.mapper;

import java.io.Serializable;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.Role;
import cn.itsource.crm.domain.RolePermission;

public interface RoleMapper extends BaseMapper<Role> {

	// 添加中间表的方法
	void saveRolePermission(RolePermission rolePermission);

	// 删除中间表的方法
	@Delete("delete from t_role_permission where role_id=#{roleId}")
	void deleteRolePermission(Serializable roleId);
}
