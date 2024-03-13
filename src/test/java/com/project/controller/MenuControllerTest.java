package com.project.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.ArrayList;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.project.domain.MenuAddDTO;
import com.project.service.MenuService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {com.project.config.RootConfig.class,
								 com.project.config.ServletConfig.class,
								 com.project.config.SecurityConfig.class})
@Log4j
public class MenuControllerTest {
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
    public void testGetMenuAdd() throws Exception {
        mockMvc.perform(get("/menu/menuAddList")
                .param("m_id", "1"))
                .andExpect(status().isOk())
                .andExpect(view().name("menu/menuAddList"))
                .andExpect(model().attributeExists("menuAddList"))
        		.andDo(print());
                // .andExpect(model().attributeExists("menuAddList")) // 모델에 해당 속성이 있는지 확인
                // .andExpect(model().attribute("menuAddList", expectedValue)) // 모델의 속성 값 검증
    }
	
}
