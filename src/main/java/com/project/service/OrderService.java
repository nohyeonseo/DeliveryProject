package com.project.service;

import com.project.domain.OrderAddDTO;
import com.project.domain.OrderInfoDTO;
import com.project.domain.OrderMenuDTO;

import java.util.List;

public interface OrderService 
{
	long generateOrderNumber(); // 주문 번호 생성
    
    void addOrderMenu(List<OrderMenuDTO> orderMenus);
    void addOrderAdd(List<OrderAddDTO> orderAdds);
    
	
    List<OrderMenuDTO> getOrderMenus(long o_number);
    List<OrderAddDTO> getOrderAdds(long o_number);
    
    void addOrderInfo(OrderInfoDTO orderInfo);
}