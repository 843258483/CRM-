package cn.itsource.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.CustomerTraceHistory;
import cn.itsource.crm.query.CustomerTraceHistoryQuery;
import cn.itsource.crm.service.ICustomerTraceHistoryService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/customerTraceHistory")
public class CustomerTraceHistoryController extends BaseController{
	@Autowired
	ICustomerTraceHistoryService customerTraceHistoryService;

	//展示页面
	@RequestMapping("/list")
	@ResourceControlled(value = "客户跟进历史页面")
	public String list(){
		return "customerTraceHistory";
	}
	//从customerTraceHistory.jsp发出ajax获得json
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "客户跟进历史列表")
	public Object json(CustomerTraceHistoryQuery baseQuery){
		return customerTraceHistoryService.findByQuery(baseQuery);
	}
	//保存或者修改
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "客户跟进历史保存")
	public AjaxResult save(CustomerTraceHistory customerTraceHistory){
		
		try {
			if(customerTraceHistory.getId()!=null){
				customerTraceHistoryService.update(customerTraceHistory);
			}else {
				customerTraceHistoryService.save(customerTraceHistory);
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
	@ResourceControlled(value = "客户跟进历史删除")
	public AjaxResult delete(Long id){
		try {
			customerTraceHistoryService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除出现异常"+e.getMessage());
		}
	}
	
	
	//报表页面：
		@RequestMapping("/view")
		@ResponseBody
		public List<Object[]> view(){
			return customerTraceHistoryService.getSellerView();
		}
}
