package cn.itsource.crm.service.impl;


import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.EmployeeRole;
import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.domain.Role;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.EmployeeMapper;
import cn.itsource.crm.service.IEmployeeService;

@Service
public class EmployeeServiceImpl extends BaseServiceImpl<Employee> implements IEmployeeService {
	@Autowired
	private EmployeeMapper employeeMapper;

	@Override
	protected BaseMapper<Employee> getBaseMapper() {
		return employeeMapper;
	}

	@Override
	public Employee findByLoginUser(String username, String password) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.findUserByName(username);
		if(employee==null){
			throw new RuntimeException("用户名不存在");
		}
		if (!employee.getPassword().equals(password)) {
			throw new RuntimeException("密码不正确");
		}
		if (employee.getState()==1) {
			throw new RuntimeException("该用户已停用!");
		}
		return employee;
	}

	@Override
	public void leaveJob(Long id) {
		Employee employee = employeeMapper.get(id);
		if(employee==null){
			throw new RuntimeException("该用户不存在或者传入的ID错误!");
		}
		if(employee.getState()==1||employee.getState()!=0){
			throw new RuntimeException("该用户已经离职!");
		}
		employeeMapper.leaveJob(id);
	}

	@Override
	public List<Menu> findMenusByLoginUser(Employee employee) {
		return employeeMapper.findMenusByLoginUserId(employee.getId());
	}

	@Override
	public void saveRole(Employee employee) {
			Long employeeId = employee.getId();
			List<Role> roles = employee.getRoles();
			//先删除中间表所有数据
			employeeMapper.deleteRoleByEmployeeId(employeeId);
			//添加数据到中间表
			for (Role role : roles) {
				Long roleId = role.getId();
				EmployeeRole employeeRole = new EmployeeRole(employeeId, roleId);
				employeeMapper.saveRole(employeeRole);
			}
	}
	
	@Override
	public void delete(Serializable id) {
		//先删除中间表所有数据
		employeeMapper.deleteRoleByEmployeeId(id);
		employeeMapper.delete(id);
	}

	@Override
	public boolean checkPermission(Long id, String permissionName, String permissionName1) {
		List<String> list = employeeMapper.checkPermission(id);
		if (list.contains(permissionName)||list.contains(permissionName1)) {
			return true;
		}
		return false;
	}
	

	@Override
	public List<String> getAllPermissionResouce() {
		return employeeMapper.getAllPermissionResouce();
	}

	@Override
	public List<String> findPermissionResouceByLoginUser(Employee employee) {
		return employeeMapper.findPermissionResouceByLoginUserId(employee.getId());
	}

	@Override
	public List<Role> findByEmployeeRoles(Long loginUserId) {
		// TODO Auto-generated method stub
		return employeeMapper.findByEmployeeRoles(loginUserId);
	}
}
