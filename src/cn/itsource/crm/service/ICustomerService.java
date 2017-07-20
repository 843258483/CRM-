package cn.itsource.crm.service;

import java.util.List;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.CustomerTraceHistory;
import cn.itsource.crm.domain.CutomerTransfer;

public interface ICustomerService extends IBaseService<Customer> {
	List<Customer> getAllCustomers();
	void ToCutomerTransfer(CutomerTransfer cutomerTransfer);
	void giveUp(Long id);
	//在  用户跟进之后需要 给 客户的状态进行改变 , 该为跟进状态 并且添加 销售员
	void cutomerFollowUp(CustomerTraceHistory customerTraceHistory);
	void toVIP(Long id);
}