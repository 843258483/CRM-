package cn.itsource.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.GuaranteeMapper;
import cn.itsource.crm.query.GuaranteeQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IGuaranteeItemService;
import cn.itsource.crm.service.IGuaranteeService;

@Service
public class GuaranteeServiceImpl extends BaseServiceImpl<Guarantee> implements IGuaranteeService {
	@Autowired
	private GuaranteeMapper guaranteeMapper;
	@Autowired
	private IGuaranteeItemService guaranteeItemService;

	@Override
	protected BaseMapper<Guarantee> getBaseMapper() {
		return guaranteeMapper;
	}
	
	//通过id来拿到保修单的明细
	@SuppressWarnings("unchecked")
	@Override
	public PageList getItemsById(Long id) {
		PageList list = findByQuery(new GuaranteeQuery());
		PageList items = new PageList();
		List<Guarantee> rows = list.getRows();
		for (Guarantee guarantee : rows) {
			if (guarantee.getId() == id) {
				items.setRows(guarantee.getItems());
				items.setTotal(guarantee.getItems().size());
			}
		}
		return items;
	}

	
	//更新保修单
	@Override
	public void updateGuaranteeAndItem(Guarantee guarantee) {
		guarantee.setSn(guaranteeMapper.get(guarantee.getId()).getSn());
		
		guaranteeItemService.deleteItems(guarantee.getId());
		guaranteeItemService.saveItems(guarantee);
	
		update(guarantee);		
	}

	@Override
	public void deleteGuarantee(Long id) {
		guaranteeMapper.deleteGuarantee(id);
	}
}
