package com.project.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.domain.MenuAddDTO;
import com.project.domain.MenuDTO;
import com.project.domain.MenuItemDTO;

public interface MenuMapper {

	public void insertM(MenuDTO menu);

	public void insertAdd(MenuAddDTO menuAdd);

	public MenuDTO read(Long m_id);

	public MenuAddDTO readAdd(Long a_id);

	//가게의 메뉴리스트
	public ArrayList<MenuDTO> getList(Long r_id);

	public ArrayList<MenuDTO> getCatList(Long r_id);

//	public ArrayList<MenuAddDTO> getAddListM(Long m_id);

	public ArrayList<MenuAddDTO> getAddListR(Long r_id);

	public int update(MenuDTO menu);

	public int updateAdd(MenuAddDTO menuAdd);

	public int delete(Long m_id);

	public int deleteAdd(Long m_id);
	
	//추가메뉴 리스트
	public List<MenuAddDTO> getAddListM(@Param("m_id") Long m_id);
	
	
	public void insertMenuItem(MenuItemDTO menuItem);

}
