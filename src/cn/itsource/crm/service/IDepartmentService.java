package cn.itsource.crm.service;

import java.util.List;

import cn.itsource.crm.domain.Department;

public interface IDepartmentService extends IBaseService<Department> {
	void updateState(Department department);
	
	// 上级部门，包含下级部门
		List<Department> getParentTreeData();
		// 上级部门
		List<Department> getTreeByParent();
		//销售部
		List getEmployeeBySaleJob();
}