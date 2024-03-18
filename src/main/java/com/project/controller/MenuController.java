package com.project.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.MenuAddDTO;
import com.project.domain.MenuDTO;
import com.project.domain.MenuItemDTO;
import com.project.service.MenuService;
import com.project.service.RestService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/menu")
@AllArgsConstructor
public class MenuController {
	
	private MenuService service;
	private RestService service2;
	
	@GetMapping("/menuList") // 메뉴 목록 조회
	public void list(@RequestParam("r_id") Long r_id, Model model) 
	{
//		log.info("list");
		model.addAttribute("list", service.getList(r_id));
	}
	
	@PostMapping("/menuRegister") //메뉴 입력
//	public String register(MenuDTO menu, ArrayList<MenuAddDTO> maDTOList, RedirectAttributes rttr) {
	public String register(MenuDTO menu, RedirectAttributes rttr) 
	{
		log.info("register: " + menu);
//		service.register(menu,maDTOList);
		service.register(menu);
		rttr.addFlashAttribute("result", menu.getM_id());
		return "redirect:/menu/menuList";
	}
	
	@GetMapping({"/menuGet", "/menuModify"}) // 메뉴 1개 조회 (그리고 메뉴 1개 정보 수정창 출력)
	public void get(@RequestParam("r_id") Long r_id, Model model) {
		log.info("/get");
		model.addAttribute("rest", service2.get(r_id));
		model.addAttribute("menuList", service.getList(r_id));
		model.addAttribute("menuCatList", service.getCatList(r_id));
		model.addAttribute("menuAddR", service.getAddListR(r_id));
	}
	
	@GetMapping("/menuRegister")  
	public void getList(@RequestParam("r_id") Long r_id, Model model) {
		log.info("/get");
		model.addAttribute("rest", service2.get(r_id));
		model.addAttribute("menuList", service.getList(r_id));
		model.addAttribute("menuCatList", service.getCatList(r_id));
		model.addAttribute("menuAddR", service.getAddListR(r_id));
	}
	
	@PostMapping("/menuModify") // 메뉴 1개 수정
	public String modify (MenuDTO menu, RedirectAttributes rttr) {
		log.info("modify: "+menu);
		if(service.modify(menu)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/menu/menuList";
	}
	
	@RequestMapping(value="/menuRemove" , method= {RequestMethod.GET,RequestMethod.POST})
	public String remove(@RequestParam("m_id") Long m_id, RedirectAttributes rttr) 
	{
		log.info("remove...."+m_id);
		if(service.remove(m_id)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/menu/menuList";
	}
	//모달
	@GetMapping("/menuAddList")
	public ResponseEntity<List<MenuAddDTO>> getMenuAdd(@RequestParam("m_id") Long m_id) 
	{
		List<MenuAddDTO> menuAddList = service.getAddListM(m_id);
		log.info(menuAddList.toString());
		return ResponseEntity.ok(menuAddList);
	}
	
	//세션을 담는 컨트롤러
	@PostMapping("/sessionCart")
	public String addToSessionCart(HttpSession session,
								            @RequestParam("m_id") String m_id,
								            @RequestParam("m_quantity") int m_quantity,
								            @RequestParam("m_price") double m_price) {
		// 세션에서 장바구니 가져오기 (없으면 새로 생성)
			List<MenuItemDTO> cart = (List<MenuItemDTO>) session.getAttribute("cart");
			if (cart == null) {
				cart = new ArrayList<>();
			}
			
			// 새 메뉴 아이템 생성 및 추가
			MenuItemDTO menuItem = new MenuItemDTO();
			menuItem.setM_id(m_id);
			menuItem.setM_quantity(m_quantity);
			menuItem.setM_price(m_price);
			cart.add(menuItem);
			
			// 장바구니를 세션에 다시 저장
			session.setAttribute("cart", cart);
			
			return "장바구니에 추가되었습니다.";
		}
	//세션에 저장된 주문을 디비로 저장
	@PostMapping("/menusave")
    public ResponseEntity<String> saveSessionToDb(HttpSession session) {
        
		List<MenuItemDTO> cart = (List<MenuItemDTO>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST) // 400 Bad Request
                    .body("장바구니가 비어있습니다.");
        }

        try {
            service.createMenuItems(cart);
            session.removeAttribute("cart"); // 저장 후 세션에서 장바구니 제거
            return ResponseEntity.ok("장바구니 항목이 성공적으로 저장되었습니다.");
        } catch (e) {
            return ResponseEntity.internalServerError().body("데이터베이스 저장 중 오류 발생");
        }
    }
	
	
	
}

