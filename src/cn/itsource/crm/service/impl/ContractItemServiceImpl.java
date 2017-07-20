package cn.itsource.crm.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.ContractItem;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.ContractItemMapper;
import cn.itsource.crm.service.IContractItemService;

@Service
public class ContractItemServiceImpl extends BaseServiceImpl<ContractItem> implements IContractItemService {
	@Autowired
	private ContractItemMapper contractItemMapper;

	@Override
	protected BaseMapper<ContractItem> getBaseMapper() {
		return contractItemMapper;
	}
	
//	提供一个方法来保存模型的明细
	@Override
	public void saveItems(Contract contract) {
		List<ContractItem> list = contract.getItems();
		for (ContractItem item : list) {
			item.setScale(item.getMoney().divide(contract.getSum(), 4, BigDecimal.ROUND_HALF_EVEN));
			item.setCustomer(contract.getCustomer());
			item.setContract(contract);
//		保存订单明细
			save(item);
		}
	}

	@Override
	public void deleteItems(Long id) {
		contractItemMapper.deleteItems(id);
	}
}
