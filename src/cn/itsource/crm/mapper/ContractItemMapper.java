package cn.itsource.crm.mapper;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.ContractItem;

public interface ContractItemMapper extends BaseMapper<ContractItem> {
	@Delete("delete from t_contract_item where contract_id = #{id} ")
	void deleteItems(Long id);
}
