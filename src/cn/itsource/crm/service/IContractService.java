package cn.itsource.crm.service;

import java.math.BigDecimal;
import java.util.List;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.query.PageList;

public interface IContractService extends IBaseService<Contract> {
	//通过id来查找items
	PageList getItemsById(Long id);

	void updateContractAndItem(Contract contract);

	//将它的状态改为作废,此时应将相关联的订单和保修单全部作废
	void deleteContract(Long id);

	//根据合同生成保修单
	void newGuarantee(Contract contract);
	
	//根据客户id来查询客户所签订合同的总金额
	BigDecimal totalSum(Long id);

	//报表数据
	List<Object[]> getSellerView();



}