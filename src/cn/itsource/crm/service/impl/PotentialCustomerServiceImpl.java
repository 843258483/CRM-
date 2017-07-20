package cn.itsource.crm.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.Order;
import cn.itsource.crm.domain.PotentialCustomer;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.CustomerDevPlanMapper;
import cn.itsource.crm.mapper.CustomerMapper;
import cn.itsource.crm.mapper.OrderMapper;
import cn.itsource.crm.mapper.PotentialCustomerMapper;
import cn.itsource.crm.service.IPotentialCustomerService;

@Service
public class PotentialCustomerServiceImpl extends BaseServiceImpl<PotentialCustomer> implements IPotentialCustomerService {
	@Autowired
	private PotentialCustomerMapper potentialCustomerMapper;
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private CustomerDevPlanMapper customerDevPlanMapper;
	@Override
	protected BaseMapper<PotentialCustomer> getBaseMapper() {
		return potentialCustomerMapper;
	}
	
	//将潜在客户 交定金的方式升级为 客户
	@Override
	public Long toCustomer(Long id) {
		try {
			Customer customer = new Customer();
			PotentialCustomer potentialCustomer = potentialCustomerMapper.get(id);
			customer.setName(potentialCustomer.getName());
			customer.setGender(1);
			customer.setAge(18);
			customer.setTel(potentialCustomer.getLinkManTel());
			customer.setEmail(null);
			customer.setState(0);
			//设置客户的 录入人员应该是当前登录用户
			//customer.setInputUser(potentialCustomer.);
			potentialCustomerMapper.delete(id);
			customerMapper.save(customer);
			return customer.getId();
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}

	
	//需要完成下面 几个操作  拿到客户对象的id ,state 它们是前台封装  潜在客户ID 和订单金额的 
	@Override
	public void upToCustomer(Customer customer) {
		customerDevPlanMapper.deletePlan(customer.getId());
		potentialCustomerMapper.delete(customer.getId());
		Integer state = customer.getState();
		customer.setId(null);
		customer.setState(0);
		customerMapper.save(customer);
		Order order = new Order();
		order.setSum(new BigDecimal(state));
		order.setSignTime(new Date());
		order.setSn(UUID.randomUUID().toString().substring(0, 6));
		order.setCustomer(customer);
		order.setSeller(customer.getSeller());
		orderMapper.save(order);
		
		
	}

}
