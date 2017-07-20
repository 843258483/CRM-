package cn.itsource.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Department;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.DepartmentMapper;
import cn.itsource.crm.service.IDepartmentService;

@Service
public class DepartmentServiceImpl extends BaseServiceImpl<Department> implements IDepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;

	@Override
	protected BaseMapper<Department> getBaseMapper() {
		return departmentMapper;
	}

	@Override
	public void updateState(Department department) {
		departmentMapper.updateState(department);
	}

	@Override
	public List<Department> getParentTreeData() {
		return departmentMapper.getParentTreeData();
	}

	@Override
	public List<Department> getTreeByParent() {
		return departmentMapper.getTreeByParent();
	}

	@Override
	public List getEmployeeBySaleJob() {
		
		
		return departmentMapper.getEmployeeBySaleJob();
	}

	

}
