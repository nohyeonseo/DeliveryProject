package com.project.mapper;
import java.util.List;

import com.project.domain.OrderAddDTO;
import com.project.domain.OrderInfoDTO;
import com.project.domain.OrderMenuDTO;


public interface OrderMapper 
{
	//주문정보 삽입
	long getNewOrderNumber();
	void insertOrderInfo(OrderInfoDTO orderInfo);
	void insertOrderMenu(OrderMenuDTO orderMenu);
	
    List<OrderMenuDTO> selectOrderMenus(long o_number);
    List<OrderAddDTO> selectOrderAdds(long o_number);
	
	void insertOrderAddMenu(OrderAddDTO orderAdd);
	
}
