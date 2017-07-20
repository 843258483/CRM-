package cn.itsource.crm.mapper;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.Order;

public interface OrderMapper extends BaseMapper<Order> {
	//改变他的state为作废
	@Delete("update t_order set state= 1 where id=#{id}")
	void deleteOrder(Long id);
}
