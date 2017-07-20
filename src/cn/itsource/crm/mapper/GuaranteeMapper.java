package cn.itsource.crm.mapper;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.Guarantee;

public interface GuaranteeMapper extends BaseMapper<Guarantee> {
	//改变他的state为作废
	@Delete("update t_guarantee set state= 1 where id=#{id}")
	void deleteGuarantee(Long id);
}
