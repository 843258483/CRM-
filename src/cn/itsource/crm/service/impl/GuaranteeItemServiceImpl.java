package cn.itsource.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.domain.GuaranteeItem;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.GuaranteeItemMapper;
import cn.itsource.crm.service.IGuaranteeItemService;

@Service
public class GuaranteeItemServiceImpl extends BaseServiceImpl<GuaranteeItem> implements IGuaranteeItemService {
	@Autowired
	private GuaranteeItemMapper guaranteeItemMapper;

	@Override
	protected BaseMapper<GuaranteeItem> getBaseMapper() {
		return guaranteeItemMapper;
	}

	@Override
	public void saveItems(Guarantee guarantee) {
		List<GuaranteeItem> list = guarantee.getItems();
		for (GuaranteeItem item : list) {
			item.setGuarantee(guarantee);
//		保存保修单明细
			save(item);
		}
	}

	@Override
	public void deleteItems(Long id) {
		guaranteeItemMapper.deleteItems(id);		
	}
}
