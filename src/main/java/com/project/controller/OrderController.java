package com.project.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.MenuItemDTO;
import com.project.domain.OrderAddDTO;
import com.project.domain.OrderInfoDTO;
import com.project.domain.OrderMenuDTO;
import com.project.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/order")
public class OrderController 
{
    private OrderService service;
    
    //세션을 디비에 저장
    @Transactional
    @PostMapping("/confirm")
    public ResponseEntity<?> confirmOrder(HttpSession session) 
    {
        List<MenuItemDTO> cart = (List<MenuItemDTO>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            // 클라이언트에게 응답으로 오류 메시지를 보냅니다.
            return ResponseEntity.badRequest().body("장바구니가 비어 있습니다.");
        }
        
        //주문 번호 생성
        long o_number = service.generateOrderNumber();

        // OrderMenuDTO와 OrderAddDTO 리스트를 생성
        List<OrderMenuDTO> orderMenus = new ArrayList<>();
        List<OrderAddDTO> orderAdds = new ArrayList<>();

        //세션에 저장된 메뉴로 부터 OrderMenuDTO와 OrderAddDTO 객체 생성
        for (MenuItemDTO item : cart) 
        {
            OrderMenuDTO orderMenu = new OrderMenuDTO();
            orderMenu.setO_number(o_number);
            orderMenu.setM_id(item.getM_id());
            orderMenu.setM_num(item.getM_num());
            orderMenu.setM_price(item.getM_price());
            orderMenus.add(orderMenu);

            //추가 메뉴가 있는 경우
            if (item.getA_id() != null) 
            { 
                OrderAddDTO orderAdd = new OrderAddDTO();
                orderAdd.setO_number(o_number);
                orderAdd.setM_id(item.getM_id());
                orderAdd.setA_id(item.getA_id());
                orderAdd.setA_number(item.getA_quantity());
                orderAdd.setA_price(item.getA_price());
                orderAdds.add(orderAdd);
            }
        }

        // 데이터베이스에 저장
        service.addOrderMenu(orderMenus);
        service.addOrderAdd(orderAdds);

        OrderInfoDTO orderInfo = new OrderInfoDTO();
        
        orderInfo.setO_num(o_number);
        service.addOrderInfo(orderInfo);
        
        session.removeAttribute("cart"); 
        
        Map<String, Long> response = new HashMap<>();
        response.put("o_number", o_number);
        return ResponseEntity.ok(response);
    }
    
     @GetMapping("/viewOrder/{o_number}")
     public String getOrderMenus(@PathVariable long o_number, Model model)
     {
     	model.addAttribute("orderMenuList", service.getOrderMenus(o_number));
     	model.addAttribute("orderAddList", service.getOrderAdds(o_number));
     	return "ordeinfo";
     }

    
    
}