package com.project.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.project.config.RootConfig.class,
								 com.project.config.SecurityConfig.class})
@Log4j
//BoardMapper 인터페이스의 메서드들을 테스트하는 목적의 테스트 클래스
public class MenuMapperTest {
	
//	BoardMapper 인터페이스의 구현체가 mapper 필드에 자동으로 주입되도록 하기 위한 것
	//@Setter(onMethod_ = @Autowired)
	@Autowired
	private MenuMapper mapper;
	
	@Test 
	public void testAddListMenuList() {
		mapper.getAddListM(1L).forEach(menu -> log.info(menu));
	}
	
}