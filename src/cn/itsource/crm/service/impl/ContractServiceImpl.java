package cn.itsource.crm.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.ContractMapper;
import cn.itsource.crm.query.ContractQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IContractItemService;
import cn.itsource.crm.service.IContractService;
import cn.itsource.crm.service.IEmployeeService;
import cn.itsource.crm.service.IGuaranteeService;
import cn.itsource.crm.service.IOrderService;

@Service
public class ContractServiceImpl extends BaseServiceImpl<Contract> implements IContractService {
	@Autowired
	private ContractMapper contractMapper;

	@Autowired
	private IContractItemService contractItemService;
	
	@Autowired
	private IGuaranteeService guaranteeService;
	
	@Autowired
	private IOrderService orderService;
	
	@Autowired
	private IEmployeeService employeeService;
	
	@Override
	protected BaseMapper<Contract> getBaseMapper() {
		return contractMapper;
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageList getItemsById(Long id) {
		
		PageList list = findByQuery(new ContractQuery());
		PageList items = new PageList();
		List<Contract> rows = list.getRows();
		for (Contract contract : rows) {
			if (contract.getId() == id) {
				items.setRows(contract.getItems());
				items.setTotal(contract.getItems().size());
			}
		}
		return items;
	}

	@Override
	public void updateContractAndItem(Contract contract) {
		contract.setSn(contractMapper.get(contract.getId()).getSn());
	
		contractItemService.deleteItems(contract.getId());
		contractItemService.saveItems(contract);
	
		update(contract);
	}
	//在作废合同的时候要将订单和保修单一起作废
	@Override
	public void deleteContract(Long id) {
		contractMapper.deleteContract(id);
		orderService.deleteOrder(contractMapper.getOrderByContract(id));
		guaranteeService.deleteGuarantee(contractMapper.getGuaranteeByContract(id));
	}

	//根据合同生成保修单
	@Override
	public void newGuarantee(Contract contract) {
		Guarantee guarantee = new Guarantee();
		guarantee.setEndTime(DateUtils.addYears(contract.getSignTime(), 1));
		guarantee.setContract(contract);
		guarantee.setCustomer(contract.getCustomer());
//		System.out.println("保修单的状态："+guarantee.getState());
		guaranteeService.save(guarantee);
	}

	@Override
	public BigDecimal totalSum(Long id) {
		return contractMapper.totalSum(id);
	}

	@Override
	public List<Object[]> getSellerView() {
		//拿到所有有合同的销售人员的id
		List<Object[]> mydata = new ArrayList<>();
		List<Long> sellers = contractMapper.allSeller();
		for (Long long1 : sellers) {
			Employee employee = employeeService.get(long1);
			BigDecimal sum = contractMapper.totalSumBySeller(long1);
			Object[] objects = {employee.getRealName(), sum};
			mydata.add(objects);
		}
		return mydata;
	}

}
