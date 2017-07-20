package cn.itsource.crm.web.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Department;
import cn.itsource.crm.query.DepartmentQuery;
import cn.itsource.crm.service.IDepartmentService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/department")
public class DepartmentController extends BaseController{
	@Autowired
	IDepartmentService departmentService;
	
	//展示页面
	@ResourceControlled(value="部门页面")
	@RequestMapping("/list")
	
	public String list(){
		return "department";
	}
	//从department.jsp发出ajax获得json
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value="部门列表")
	public Object json(DepartmentQuery baseQuery){
		return departmentService.findByQuery(baseQuery);
	}
	//保存或者修改
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value="保存部门")
	public AjaxResult save(Department department){
		
		try {
			if(department.getId()!=null){
				departmentService.update(department);
			}else {
				departmentService.save(department);
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
	@ResourceControlled(value="部门停用")
	public AjaxResult delete(Long id){
		
		try {
			Department department = departmentService.get(id);
			if(department.getState()==1){
				return new AjaxResult("该状态已经为停用状态!");
			}
			department.setState(1);
			departmentService.updateState(department);
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
	//上级部门树
	@RequestMapping("/getParentTree")
	@ResponseBody
	@ResourceControlled(value="一级部门树")
	public List<Department> getParentTree(){
		
		return departmentService.getTreeByParent();
		
		
	}
	//销售部
	@RequestMapping("/getEmployeeBySaleJob")
	@ResponseBody
	@ResourceControlled(value="销售部数据")
	public List getEmployeeBySaleJob(){
		return departmentService.getEmployeeBySaleJob();
	}
}
