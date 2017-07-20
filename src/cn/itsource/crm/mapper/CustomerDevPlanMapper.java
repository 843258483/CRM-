package cn.itsource.crm.mapper;

import cn.itsource.crm.domain.CustomerDevPlan;

public interface CustomerDevPlanMapper extends BaseMapper<CustomerDevPlan> {
	void deletePlan(Long id);
}
