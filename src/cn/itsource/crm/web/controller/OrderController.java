package cn.itsource.crm.web.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Order;
import cn.itsource.crm.query.OrderQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IOrderService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/order")
public class OrderController extends BaseController{
	@Autowired
	IOrderService orderService;
	
	//展示页面
	@ResourceControlled(value = "订单页面")
	@RequestMapping("/list")
	public String list(){
		
		return "order";
	}
	//从order.jsp发出ajax获得json
	@ResourceControlled(value = "订单列表")
	@RequestMapping("/json")
	@ResponseBody
	public PageList json(OrderQuery baseQuery){
		return orderService.findByQuery(baseQuery);
	}
	//保存或者修改
	@ResourceControlled(value = "订单保存")
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Order order){
		try {
			if(order.getId()!=null){//在修改的时候，因为前台没有传sn和signTime，所以需要查询出来
				Order order2 = orderService.get(order.getId());
				order.setSn(order2.getSn());
				order.setSignTime(order2.getSignTime());
				orderService.update(order);
			}else {//在保存的时候生成编号和录入时间
				order.setSn(UUID.randomUUID().toString().substring(0, 6));
				orderService.save(order);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常"+e.getMessage());
		}
	}
	//删除方法
	@ResourceControlled(value = "订单作废")
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		
		try {
//			orderService.delete(id);
			orderService.deleteOrder(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除出现异常"+e.getMessage());
		}
	}
	//将订单升级为合同
	@ResourceControlled(value = "订单升级成合同")
	@RequestMapping("/newContract")
	@ResponseBody
	public AjaxResult newContract(Long id){
		try {
			//在orderSerivce中定义一个方法，来讲对应订单id的订单升级为合同
			
			orderService.newContract(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("由订单升级为合同出现异常"+e.getMessage());
		}
	}
}
