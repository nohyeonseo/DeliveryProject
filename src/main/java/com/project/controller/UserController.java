package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.domain.UserDTO;
import com.project.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
//@RequestMapping("/user/*")
@RequiredArgsConstructor
public class UserController {
	private final UserService service;
	
	@GetMapping("/register")
	public String register() {
		return "user/register";
	}
	
	@GetMapping("/register/form")
	public String registerForm(@ModelAttribute("u_code") int u_code) {
		return "user/registerForm";
	}
	
	@PostMapping("/register")
	public String register(UserDTO user) {
		service.register(user);
		
		if(user.getU_code() == 1) {
			return "redirect:/";
		} else {
			return "/rest/restRegister";
		}
	}
	
//	@GetMapping("/login")
//	public String login() {
//		return "user/login";
//	}
//	
//	@GetMapping("/login/fail")
//	public String loginFailed(Model model) {
//		model.addAttribute("loginError", true);
//		return "user/login";
//	}
	@PostMapping("/login")
	public ResponseEntity<?> signIn(@RequestBody Map<String, String> loginInfo) {
	    try {
	        String userId = loginInfo.get("u_id");
	        String password = loginInfo.get("u_pw");
	        
	        UserVO user = userMapper.selectByUserId(userId, password);
	        if (user != null) {
	            return ResponseEntity.ok().body("로그인 성공");
	        } else {
	            return ResponseEntity.badRequest().body("아이디 또는 비밀번호가 잘못되었습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.internalServerError().body("로그인 처리 중 오류 발생");
	    }
	}
	
	
}














