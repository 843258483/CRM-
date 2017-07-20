package cn.itsource.crm.service.impl;

import java.math.BigDecimal;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.ContractItem;
import cn.itsource.crm.domain.Order;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.OrderMapper;
import cn.itsource.crm.service.IContractItemService;
import cn.itsource.crm.service.IContractService;
import cn.itsource.crm.service.IOrderService;

@Service
public class OrderServiceImpl extends BaseServiceImpl<Order> implements IOrderService {
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private IContractService contractService;
	@Autowired
	private IContractItemService contractItemService;
	

	@Override
	protected BaseMapper<Order> getBaseMapper() {
		return orderMapper;
	}

	@Override
	public void newContract(Long id) {//将对应id的订单升级为合同
		Order order = get(id);
		//生成合同
		Contract contract = new Contract();
		contract.setSignTime(order.getSignTime());
		contract.setSum(order.getSum());
		contract.setSn(UUID.randomUUID().toString().substring(0, 6));
		contract.setIntro("此合同是由订单生成");
		contract.setSeller(order.getSeller());
		contract.setCustomer(order.getCustomer());
		
		contractService.save(contract);
		
		//生成合同明细
		ContractItem item = new ContractItem();
		item.setContract(contract);
		item.setIsPayment(true);
		item.setMoney(order.getSum());
		item.setPayTime(order.getSignTime());
		item.setScale(new BigDecimal(1));
		contractItemService.save(item);
		
		//关联合同和订单
		order.setContract(contract);
		update(order);
		
		//生成保修单
		contractService.newGuarantee(contract);
	}

	@Override
	public void deleteOrder(Long id) {
		orderMapper.deleteOrder(id);
	}
}
