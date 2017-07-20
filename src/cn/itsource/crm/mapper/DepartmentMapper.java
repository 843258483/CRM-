package cn.itsource.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.itsource.crm.domain.Department;
import cn.itsource.crm.domain.Employee;

public interface DepartmentMapper extends BaseMapper<Department> {
	//修改状态
	void updateState(Department department);
	
	// 上级部门，包含下级部门
	List<Department> getParentTreeData();
	//只拿上级部门
	List<Department>  getTreeByParent();
	//提供的方法来拿销售部的员工
	@Select("select e.* from t_employee e left join t_department d on e.department_id=d.id where d.name='销售部' and e.state=0")
	List<Employee> getEmployeeBySaleJob();

}
