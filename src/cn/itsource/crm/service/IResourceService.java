package cn.itsource.crm.service;

import cn.itsource.crm.domain.Resource;
import cn.itsource.crm.query.PageList;

public interface IResourceService extends IBaseService<Resource> {

	PageList findByPermissionId(Long permissionId);

	void loadResource();// 启动服务器时自动扫描资源

	PageList findChildrenMenu();
}