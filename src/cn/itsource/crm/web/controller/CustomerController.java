package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.CustomerTraceHistory;
import cn.itsource.crm.domain.CutomerTransfer;
import cn.itsource.crm.query.CustomerQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICustomerService;
import cn.itsource.crm.service.ICustomerTraceHistoryService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;


@Controller
@RequestMapping("/customer")
public class CustomerController extends BaseController {
	@Autowired
	ICustomerService customerService;
	@Autowired
	ICustomerTraceHistoryService customerTraceHistoryService;
	// 访问入口：http://localhost/department/list
	// 显示easyui+jsp页面
	@RequestMapping("/list")
	@ResourceControlled(value = "客户页面")
	public String list() {
		return "customer";
	}

	// 不直接访问：由department.jsp发出ajax请求返回json数据
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "客户列表")
	public PageList json(CustomerQuery customerQuery) {
		return customerService.findByQuery(customerQuery);
		
	}

	// ajax删除
	// http://localhost:8080/department/delete?id=333
	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value = "客户删除")
	public AjaxResult delete(Long id) {
		try {
			customerService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
//			這個異常最好注釋掉，因爲會在控制臺 打印出異常信息
//			e.printStackTrace();
			return new AjaxResult("删除出现异常：" + e.getMessage());
		}
	}
	
	@RequestMapping("/toVIP")
	@ResponseBody
	@ResourceControlled(value = "客户升级")
	public AjaxResult toVIP(Long id) {
		System.out.println(id);
		try {
			customerService.toVIP(id);
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("升级出现异常：" + e.getMessage());
		}
	}

	// 新增或者修改后保存
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "客户保存")
	public AjaxResult save(Customer customer) {
		System.out.println(customer);
		try {
			if (customer.getId()!= null) {
				System.out.println("进方法");
				customerService.update(customer);
			} else {
				customerService.save(customer);
			}
			return new AjaxResult();
		} catch (Exception e) {
//			e.printStackTrace();
			return new AjaxResult("保存出现异常：" + e.getMessage());
		}
	}
	//移交用户
	@RequestMapping("/cutomerTransfer")
	@ResponseBody
	@ResourceControlled(value = "客户移交")
	public AjaxResult cutomerTransfer(CutomerTransfer cutomerTransfer) {
		try {
			customerService.ToCutomerTransfer(cutomerTransfer);
			return new AjaxResult();
		} catch (Exception e) {
//			e.printStackTrace();
			return new AjaxResult("删除出现异常：" + e.getMessage());
		}
	}
	//跟进用户
	@RequestMapping("/cutomerFollowUp")
	@ResponseBody
	@ResourceControlled(value = "客户跟进")
	public AjaxResult cutomerFollowUp(CustomerTraceHistory customerTraceHistory) {
		try {
			customerTraceHistoryService.save(customerTraceHistory);
			customerService.cutomerFollowUp(customerTraceHistory);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("跟进出现异常：" + e.getMessage());
		}
	}
	
	//将客户放到资源池中并且   解除关系
		@RequestMapping("/giveUp")
		@ResponseBody
		@ResourceControlled(value = "客户放入资源池")
		public AjaxResult giveUp(Long id) {
			try {
				System.out.println("要操作的客户id"+id);
				customerService.giveUp(id);
				return new AjaxResult();
			} catch (Exception e) {
				e.printStackTrace();
				return new AjaxResult("放入资源池出现异常：" + e.getMessage());
			}
		}
	
}
