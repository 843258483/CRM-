package cn.itsource.crm.service;

import java.util.List;

import cn.itsource.crm.domain.CustomerTraceHistory;

public interface ICustomerTraceHistoryService extends IBaseService<CustomerTraceHistory> {

	List<Object[]> getSellerView();
	
}