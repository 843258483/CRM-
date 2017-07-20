package cn.itsource.crm.service;

import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.query.PageList;

public interface IGuaranteeService extends IBaseService<Guarantee> {
	//通过id来拿到保修单的明细
	PageList getItemsById(Long id);

	//更新保修单
	void updateGuaranteeAndItem(Guarantee guarantee);

	//作废保修单
	void deleteGuarantee(Long id);

}