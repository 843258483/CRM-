package cn.itsource.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.itsource.crm.domain.Menu;

public interface MenuMapper extends BaseMapper<Menu> {

	Long findMenuIdByName(String menuName);

	@Select("select * from t_menu where parent_id is null")
	List<Menu> findParentMenu();

	@Select("select count(*) from t_menu where parent_id is null")
	int findCountParentMenu();

}
