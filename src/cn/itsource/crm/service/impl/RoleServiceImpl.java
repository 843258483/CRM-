package cn.itsource.crm.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Permission;
import cn.itsource.crm.domain.Role;
import cn.itsource.crm.domain.RolePermission;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.RoleMapper;
import cn.itsource.crm.service.IRoleService;

@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {
	@Autowired
	private RoleMapper roleMapper;

	@Override
	protected BaseMapper<Role> getBaseMapper() {
		return roleMapper;
	}

	// 抽取保存中间表的方法
	@SuppressWarnings("unused")
	private void saveRolePermission(Role role) {
		List<Permission> permissions = role.getPermissions();
		// 拿到角色的权限判断是否赋予了权限，添加中间表的数据
		if (permissions.size() > 0) {
			for (Permission permission : permissions) {
				// 拿到roleId和permissionId
				Long permissionId = permission.getId();
				Long roleId = role.getId();
				// 封装对象
				RolePermission rolePermission = new RolePermission(roleId, permissionId);
				roleMapper.saveRolePermission(rolePermission);
			}
		}
	}

	@Override
	public void save(Role role) {
		roleMapper.save(role);
		// 保存中间表
		saveRolePermission(role);
	}

	@Override
	public void update(Role role) {
		// 1.删除中间表
		roleMapper.deleteRolePermission(role.getId());
		// 2.修改角色
		roleMapper.update(role);
		// 3.保存中间表
		saveRolePermission(role);
	}

	@Override
	public void delete(Serializable id) {
		// 1.先删除中间表
		roleMapper.deleteRolePermission(id);
		// 2.删除角色
		roleMapper.delete(id);
	}
}
