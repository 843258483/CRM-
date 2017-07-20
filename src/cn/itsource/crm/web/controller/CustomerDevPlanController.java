package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.CustomerDevPlan;
import cn.itsource.crm.query.CustomerDevPlanQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICustomerDevPlanService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;


@Controller
@RequestMapping("/customerDevPlan")
public class CustomerDevPlanController extends BaseController {
	@Autowired
	ICustomerDevPlanService customerDevPlanService;

	// 访问入口：http://localhost/department/list
	// 显示easyui+jsp页面
	@RequestMapping("/list")
	@ResourceControlled(value = "潜在客户开发计划页面")
	public String list() {
		return "customerDevPlan";
	}

	// 不直接访问：由department.jsp发出ajax请求返回json数据
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "潜在客户开发计划列表")
	public PageList json(CustomerDevPlanQuery customerDevPlanQuery) {
		return customerDevPlanService.findByQuery(customerDevPlanQuery);
		
	}

	// ajax删除
	// http://localhost:8080/department/delete?id=333
	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value = "潜在客户开发计划删除")
	public AjaxResult delete(Long id) {
		try {
			customerDevPlanService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除出现异常：" + e.getMessage());
		}
	}

	// 新增或者修改后保存
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "潜在客户开发计划保存")
	public AjaxResult save(CustomerDevPlan customerDevPlan) {
		try {
			if (customerDevPlan.getId() == null) {
				customerDevPlanService.save(customerDevPlan);
			} else {
				customerDevPlanService.update(customerDevPlan);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常：" + e.getMessage());
		}
	}
}
