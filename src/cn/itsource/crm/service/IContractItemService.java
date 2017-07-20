package cn.itsource.crm.service;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.ContractItem;

public interface IContractItemService extends IBaseService<ContractItem> {
//	提供一个方法来保存模型的明细   time:尾款明细的个数
	void saveItems(Contract contract);

	void deleteItems(Long id);
}