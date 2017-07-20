package cn.itsource.crm.service;

import java.io.Serializable;
import java.util.List;

import cn.itsource.crm.query.BaseQuery;
import cn.itsource.crm.query.PageList;

public interface IBaseService<T> {
	void save(T t);

	void update(T t);

	void delete(Serializable id);

	T get(Serializable id);

	List<T> getAll();

	//高级查询
	PageList findByQuery(BaseQuery baseQuery);
}
