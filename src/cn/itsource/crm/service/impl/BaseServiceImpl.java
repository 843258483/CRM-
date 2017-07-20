package cn.itsource.crm.service.impl;

import java.io.Serializable;
import java.util.List;

import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.query.BaseQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IBaseService;

public abstract class BaseServiceImpl<T> implements IBaseService<T> {

	protected abstract BaseMapper<T> getBaseMapper();
	
	@Override
	public void save(T t) {
		getBaseMapper().save(t);
	}

	@Override
	public void update(T t) {
		getBaseMapper().update(t);
	}

	@Override
	public void delete(Serializable id) {
		getBaseMapper().delete(id);
	}

	@Override
	public T get(Serializable id) {
		return getBaseMapper().get(id);
	}

	@Override
	public List<T> getAll() {
		return getBaseMapper().getAll();
	}

	@Override
	public PageList findByQuery(BaseQuery baseQuery) {
		PageList pageList = new PageList();
		// 调用Mapper接口2个方法，封装到PageList对象返回
		int total = getBaseMapper().findCountByQuery(baseQuery);
		if (total == 0) {
			return pageList;
		}
		
		List list = getBaseMapper().findLimitByQuery(baseQuery);
		pageList.setRows(list);
		pageList.setTotal(total);
		return pageList;
	}

}
