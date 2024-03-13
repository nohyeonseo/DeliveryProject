package com.project.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.domain.MenuAddDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.project.config.RootConfig.class,
		 						 com.project.config.SecurityConfig.class})
@Log4j
public class MenuServiceTest 
{
	@Autowired
	private MenuService service;
	
	@Test
	public void getAddListMTest() 
	{
	    Long m_id = 1L; 
		
		List<MenuAddDTO> menuAddList = service.getAddListM(m_id);
		
		log.info(menuAddList);
		
	}
}
