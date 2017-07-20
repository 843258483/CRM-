package cn.itsource.crm.mapper;

import cn.itsource.crm.domain.Customer;

public interface CustomerMapper extends BaseMapper<Customer> {
	void turnOver(Customer customer);
	void giveUp(Customer customer);
	void toVIP(Long id);
	
}
