package cn.itsource.crm.service;

import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.domain.GuaranteeItem;

public interface IGuaranteeItemService extends IBaseService<GuaranteeItem> {

	//保存所有的明细
	void saveItems(Guarantee guarantee);

	//删除所有的明细
	void deleteItems(Long id);

}