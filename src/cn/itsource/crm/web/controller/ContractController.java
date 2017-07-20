package cn.itsource.crm.web.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.query.ContractQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IContractItemService;
import cn.itsource.crm.service.IContractService;
import cn.itsource.crm.service.ICustomerService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/contract")
public class ContractController extends BaseController{
	@Autowired
	IContractService contractService;
	@Autowired
	ICustomerService customerService;
	@Autowired
	IContractItemService contractItemService;
	
	//展示页面
	@ResourceControlled(value = "合同页面")
	@RequestMapping("/list")
	public String list(){
		
		return "contract";
	}
	//从contract.jsp发出ajax获得json
	@ResourceControlled(value = "合同列表")
	@RequestMapping("/json")
	@ResponseBody
	public PageList json(ContractQuery baseQuery){
		return contractService.findByQuery(baseQuery);
	}
	
	
	//保存或者修改
	@ResourceControlled(value = "合同保存")
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Contract contract){
		
		try {
			if (contract.getId() != null) {
				contractService.updateContractAndItem(contract);
				
			} else {
				contract.setSn(UUID.randomUUID().toString().substring(0, 6));
				contractService.save(contract);
				contractItemService.saveItems(contract);
				contractService.newGuarantee(contract);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常"+e.getMessage());
		}
	}
	//删除方法
	@ResourceControlled(value = "合同作废")
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		
		try {
//			contractItemService.deleteItems(id);
//			contractService.delete(id);
			contractService.deleteContract(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("操作出现异常"+e.getMessage());
		}
	}
	
	
	//获取对应合同的id的合同明细
	@ResourceControlled(value = "获得合同对应的合同明细列表")
	@RequestMapping("/getItems")
	@ResponseBody
	public PageList getItems(Long id){
		return contractService.getItemsById(id);
	}
	
	//报表页面：
	@RequestMapping("/view")
	@ResponseBody
	public List<Object[]> view(){
		return contractService.getSellerView();
	}
	
}
