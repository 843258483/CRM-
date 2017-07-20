package cn.itsource.crm.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.CustomerTraceHistory;
import cn.itsource.crm.domain.CutomerTransfer;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.CustomerMapper;
import cn.itsource.crm.mapper.CutomerTransferMapper;
import cn.itsource.crm.service.IContractService;
import cn.itsource.crm.service.ICustomerService;

@Service
public class CustomerServiceImpl extends BaseServiceImpl<Customer> implements ICustomerService {
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private CutomerTransferMapper cutomerTransferMapper;
	@Autowired
	private IContractService contractService;
	@Override
	protected BaseMapper<Customer> getBaseMapper() {
		return customerMapper;
	}
	@Override
	public List<Customer> getAllCustomers() {
		return customerMapper.getAll();
	}
	@Override
	public void ToCutomerTransfer(CutomerTransfer cutomerTransfer) {
		Long id = cutomerTransfer.getNewSeller().getId();
		Customer customer = cutomerTransfer.getCustomer();
		customer.setSeller(cutomerTransfer.getNewSeller());
		cutomerTransferMapper.save(cutomerTransfer);
		customerMapper.turnOver(customer);
	}
	
	//解除和客户的关系 并且把客户放在资源池中
	@Override
	public void giveUp(Long id) {
		Customer customer = customerMapper.get(id);
		customer.setState(-1);
		customer.setSeller(null);
		customerMapper.giveUp(customer);
	}
	
	//在这里完成  对客户对象的状态的修改 和 销售人员的 添加 
	@Override
	public void cutomerFollowUp(CustomerTraceHistory customerTraceHistory) {
		Customer customer = customerTraceHistory.getCustomer();
		customer.setSeller(customerTraceHistory.getTraceUser());
		customer.setState(0);
		customerMapper.giveUp(customer);
	}
	@Override
	public void toVIP(Long id) {
		BigDecimal totalSum = contractService.totalSum(id);
		if(totalSum!=null){
			int intValue = totalSum.intValue();
			if(intValue>10000){
				customerMapper.toVIP(id);
			}else{
				throw new RuntimeException("该用户还需要完成"+(10000-intValue)+"金额的合同才能升级");
			}
		}else{
			throw new RuntimeException("该用户还需要完成"+10000+"金额的合同才能升级");
		}
	}
}
