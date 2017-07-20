package cn.itsource.crm.service;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.PotentialCustomer;

public interface IPotentialCustomerService extends IBaseService<PotentialCustomer> {
	//将潜在客户升级为客户的业务方法
	Long toCustomer(Long id);

	void upToCustomer(Customer customer);
}