package cn.itsource.crm.mapper;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.GuaranteeItem;

public interface GuaranteeItemMapper extends BaseMapper<GuaranteeItem> {
	@Delete("delete from t_guarantee_item where guarantee_id = #{id} ")
	void deleteItems(Long id);

}
