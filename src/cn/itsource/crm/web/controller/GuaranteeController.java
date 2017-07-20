package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.query.GuaranteeQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICustomerService;
import cn.itsource.crm.service.IGuaranteeItemService;
import cn.itsource.crm.service.IGuaranteeService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/guarantee")
public class GuaranteeController extends BaseController{
	@Autowired
	IGuaranteeService guaranteeService;
	@Autowired
	ICustomerService customerService;
	@Autowired
	IGuaranteeItemService guaranteeItemService;
	
	//展示页面
	@ResourceControlled(value = "保修单页面")
	@RequestMapping("/list")
	public String list(){
		
		return "guarantee";
	}
	//从guarantee.jsp发出ajax获得json
	@ResourceControlled(value = "合同列表")
	@RequestMapping("/json")
	@ResponseBody
	public PageList json(GuaranteeQuery baseQuery){
		return guaranteeService.findByQuery(baseQuery);
	}
	
	
	//修改
	@ResourceControlled(value = "保修单保存")
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Guarantee guarantee){
		
		try {
			guaranteeService.updateGuaranteeAndItem(guarantee);
			
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常"+e.getMessage());
		}
//		return new AjaxResult("测试。。。");
	}
	//删除方法
	@ResourceControlled(value = "保修单作废")
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		
		try {
			guaranteeService.deleteGuarantee(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("作废出现异常"+e.getMessage());
		}
	}
	
	//获取对应合同的id的合同明细
	@ResourceControlled(value = "获得保修单对应的保修单明细列表")
	@RequestMapping("/getItems")
	@ResponseBody
	public PageList getItems(Long id){
		return guaranteeService.getItemsById(id);
	}
	

}
