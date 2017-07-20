package cn.itsource.crm.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.CustomerTraceHistory;
import cn.itsource.crm.domain.SystemDictionaryItem;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.CustomerTraceHistoryMapper;
import cn.itsource.crm.service.ICustomerTraceHistoryService;
import cn.itsource.crm.service.ISystemDictionaryItemService;

@Service
public class CustomerTraceHistoryServiceImpl extends BaseServiceImpl<CustomerTraceHistory> implements ICustomerTraceHistoryService {
	@Autowired
	private CustomerTraceHistoryMapper customerTraceHistoryMapper;
	@Autowired
	private ISystemDictionaryItemService systemDictionaryItemService;
	@Override
	protected BaseMapper<CustomerTraceHistory> getBaseMapper() {
		return customerTraceHistoryMapper;
	}

	@Override
	public List<Object[]> getSellerView() {
		List<Object[]> mydata = new ArrayList<>();
		List<Long> typesId =  customerTraceHistoryMapper.getAllTypes();
		for (Long long1 : typesId) {
			SystemDictionaryItem systemDictionaryItem = systemDictionaryItemService.get(long1);
			String name = systemDictionaryItem.getName();
			List<Long> traceResults = customerTraceHistoryMapper.getStatsByType(long1);
			int i = 0;
			for (Long long2 : traceResults) {
				if (long2 == 1) {
					i++;
				}
			}
			Double result = (double)i/traceResults.size();
			if (result>0.5) {
			}
		}
	
		return mydata;
	}


	
}
