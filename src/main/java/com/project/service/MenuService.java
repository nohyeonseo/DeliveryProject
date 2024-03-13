package com.project.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.domain.MenuAddDTO;
import com.project.domain.MenuDTO;
import com.project.domain.MenuItemDTO;

public interface MenuService {
//	public void register (MenuDTO menu, ArrayList<MenuAddDTO> maDTOList);
	public void register (MenuDTO menu);
	
	public MenuDTO get(Long m_id);
	public MenuDTO get1(Long m_id);
	public MenuDTO get2(Long m_id);
	
	public MenuAddDTO getAdd(Long a_id);
	
//	public ArrayList<MenuAddDTO> getAddListM(Long m_id,Long r_id);

	public ArrayList<MenuAddDTO> getAddListR(Long r_id);
	
	//가게메뉴들을 리스트로
	public ArrayList<MenuDTO> getList(Long r_id);

	public ArrayList<MenuDTO> getCatList(Long r_id);
	
	public boolean modify (MenuDTO menu);
	
	public boolean remove (Long m_id);
	
	//추가메뉴리스트로 
	public List<MenuAddDTO> getAddListM(@Param("m_id") Long m_id);
	
	public void createMenuItems(List<MenuItemDTO> menuItems);
}
