package com.project.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.project.config.RootConfig.class,
		 						 com.project.config.SecurityConfig.class})
@Log4j
public class SecurityTest {
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
//	@Test
	public void encodeTest() {
		String password = "a1234";
		String encodedPW;
		
		encodedPW = encoder.encode(password);
		log.info(encodedPW);
		log.info(encoder.matches("a1235", encodedPW));
	}
	
	@Test
	public void loadUserByUsernameTest() {
		log.info(customUserDetailsService.loadUserByUsername("test_id9"));
	}
}
