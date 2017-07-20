package cn.itsource.crm.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Permission;
import cn.itsource.crm.domain.PermissionResource;
import cn.itsource.crm.domain.Resource;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.PermissionMapper;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IPermissionService;

@Service
public class PermissionServiceImpl extends BaseServiceImpl<Permission> implements IPermissionService {
	@Autowired
	private PermissionMapper permissionMapper;

	@Override
	protected BaseMapper<Permission> getBaseMapper() {
		return permissionMapper;
	}

	@Override
	public PageList findByRoleId(Long roleId) {
		PageList pageList = new PageList();
		int total = permissionMapper.findCountByRoleId(roleId);
		if (total == 0) {
			return pageList;
		}
		List<Permission> list = permissionMapper.findByRoleId(roleId);
		pageList.setRows(list);
		pageList.setTotal(total);
		return pageList;
	}

	// 抽取保存中间表的方法
	private void savePermissionResource(Permission permission) {
		List<Resource> resources = permission.getResources();
		// 拿到角色的权限判断是否赋予了权限，添加中间表的数据
		if (resources.size() > 0) {
			for (Resource resource : resources) {
				// 拿到resourceId和permissionId
				Long permissionId = permission.getId();
				Long resourceId = resource.getId();
				// 封装对象
				PermissionResource permissionResource = new PermissionResource(permissionId, resourceId);
				permissionMapper.savePermissionResource(permissionResource);
			}
		}
	}

	@Override
	public void save(Permission permission) {
		permissionMapper.save(permission);
		// 保存中间表
		savePermissionResource(permission);
	}

	// @Override
	// public void save(Permission permission) {
	// permissionMapper.save(permission);
	// // 保存中间表
	// savePermissionResource(permission);
	// }

	@Override
	public void update(Permission permission) {
		// 1.删除中间表
		permissionMapper.deletePermissionResource(permission.getId());
		// 2.修改角色
		permissionMapper.update(permission);
		// 3.保存中间表
		savePermissionResource(permission);
	}

	@Override
	public void delete(Serializable id) {
		// 1.先删除中间表
		permissionMapper.deletePermissionResource(id);
		// 2.删除角色
		permissionMapper.delete(id);
	}
}
