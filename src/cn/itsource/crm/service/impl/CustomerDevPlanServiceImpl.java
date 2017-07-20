package cn.itsource.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.CustomerDevPlan;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.CustomerDevPlanMapper;
import cn.itsource.crm.service.ICustomerDevPlanService;

@Service
public class CustomerDevPlanServiceImpl extends BaseServiceImpl<CustomerDevPlan> implements ICustomerDevPlanService {
	@Autowired
	private CustomerDevPlanMapper customerDevPlanMapper;
	@Override
	protected BaseMapper<CustomerDevPlan> getBaseMapper() {
		return customerDevPlanMapper;
	}

}
