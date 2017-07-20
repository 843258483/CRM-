package cn.itsource.crm.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Department;
import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.Role;
import cn.itsource.crm.query.EmployeeQuery;
import cn.itsource.crm.service.IDepartmentService;
import cn.itsource.crm.service.IEmployeeService;
import cn.itsource.crm.service.IRoleService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
import cn.itsource.crm.util.UserContext;
@Controller
@RequestMapping("/employee")
public class EmployeeController extends BaseController{
	@Autowired
	IEmployeeService employeeService;
	@Autowired
	IDepartmentService departmentService;
	@Autowired
	IRoleService roleService;
	//展示页面
	@RequestMapping("/list")
	@ResourceControlled(value="员工页面")
	public String list(){
		return "employee";
	}
	//从employee.jsp发出ajax获得json
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value="员工列表")
	public Object json(EmployeeQuery baseQuery){
		HttpSession httpSession = UserContext.getSession();
		Employee employee = UserContext.getEmployee(httpSession);
		List<Role> roles = employee.getRoles();
		List<Role> list = employeeService.findByEmployeeRoles(employee.getId());
		return employeeService.findByQuery(baseQuery);
	}
	//保存或者修改
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value="保存员工")
	public AjaxResult save(Employee employee){
		
		try {
			if(employee.getId()!=null){
				employeeService.update(employee);
			}else {
				employeeService.save(employee);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常"+e.getMessage());
		}
	}
	//删除方法
	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value="删除员工")
	public AjaxResult delete(Long id){
		
		try {
			employeeService.delete(id);;
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除出现异常"+e.getMessage());
		}
		
		
	}
	//部门树
		@RequestMapping("/getParentTreeData")
		@ResponseBody
		@ResourceControlled(value="部门树")
		public List<Department> getParentTreeData(){
			
			return departmentService.getParentTreeData();
			
			
		}
		//处理员工离职
		@RequestMapping("/leaveJob")
		@ResponseBody
		@ResourceControlled(value="离职员工")
		public AjaxResult leaveJob(Long id){
			try {
				employeeService.leaveJob(id);
				return new  AjaxResult();
			} catch (RuntimeException e) {
				// TODO: handle exception
				e.printStackTrace();
				return new  AjaxResult(e.getMessage());
			}
		}
		//拿到所有的角色列表
		@RequestMapping("/RoleAll")
		@ResponseBody
		@ResourceControlled(value="员工角色列表")
		public List<Role> getRoleAll(){
			return roleService.getAll();
		}
		
		//保存或者修改
		@RequestMapping("/saveRole")
		@ResponseBody
		@ResourceControlled("员工角色保存")
		public AjaxResult saveRole(Employee employee){
			try {
				employeeService.saveRole(employee);
				return new AjaxResult();
			} catch (Exception e) {
				e.printStackTrace();
				return new AjaxResult("保存出现异常"+e.getMessage());
			}
		}
		
}
