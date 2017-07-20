package cn.itsource.crm.service;

import cn.itsource.crm.domain.Order;

public interface IOrderService extends IBaseService<Order> {
	//将对应id的订单升级为合同
	void newContract(Long id);

//	将它的状态改为作废，假删除
	void deleteOrder(Long id);
	
}