package cn.itsource.crm.mapper;

import java.io.Serializable;
import java.util.List;

import cn.itsource.crm.query.BaseQuery;

public interface BaseMapper<T> {
	void save(T t);

	void update(T t);

	void delete(Serializable id);

	T get(Serializable id);

	List<T> getAll();

	// count查询
	Integer findCountByQuery(BaseQuery baseQuery);

	// limit查询
	List findLimitByQuery(BaseQuery baseQuery);
}
