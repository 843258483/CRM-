package cn.itsource.crm.service;

import java.util.List;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.domain.Role;

public interface IEmployeeService extends IBaseService<Employee> {
	
	//登录
	Employee findByLoginUser(String username, String password);
	//离职
	void   leaveJob(Long id);
	//菜单
	List<Menu> findMenusByLoginUser(Employee employee);
	//保存角色
	void saveRole(Employee employee);
	
	//检查权限
	boolean checkPermission(Long id,String permissionName,String permissionName1);
	//查询全部的权限资源
	List<String> getAllPermissionResouce();
	//拿到当前用户的权限管理
	List<String> findPermissionResouceByLoginUser(Employee employee);
	//通过员工ID当前的所有角色
	List<Role> findByEmployeeRoles(Long loginUserId);
}