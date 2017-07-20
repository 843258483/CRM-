package cn.itsource.crm.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import cn.itsource.crm.domain.Department;
import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.EmployeeRole;
import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.domain.Role;


public interface EmployeeMapper extends BaseMapper<Employee> {
	// 上级部门，包含下级部门
		List<Department> getParentTreeData();
		@Select("select * from t_employee where username=#{username}")
		Employee findUserByName(String username);
		//处理员工离职
		@Update("update t_employee set state=1 where id=#{id}")
		void   leaveJob(Long id);
		
		List<Menu> findMenusByLoginUserId(Long loginUserId);
		
		@Select("delete from t_employee_role where employee_id=#{employeeId}")
		void deleteRoleByEmployeeId(Serializable id);
		
		void saveRole(EmployeeRole employeeRole);
		
		@Select("select r.url from t_resource r")
		List<String> getAllPermissionResouce();
		
		List<String> findPermissionResouceByLoginUserId(Long loginUserId);
		
		List<String> checkPermission(Long loginUserId);
		
		
		List<Role> findByEmployeeRoles(Long loginUserId);
		

}
