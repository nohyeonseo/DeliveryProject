package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.OrderAddDTO;
import com.project.domain.OrderInfoDTO;
import com.project.domain.OrderMenuDTO;
import com.project.mapper.OrderMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
    
    private final OrderMapper mapper;

    @Override
    public long generateOrderNumber() 
    {
        return mapper.getNewOrderNumber();
    }

	@Override
	public void addOrderMenu(List<OrderMenuDTO> orderMenus) {
		//주문 메뉴 데이터 저장
		for (OrderMenuDTO orderMenu : orderMenus) {
			mapper.insertOrderMenu(orderMenu);
		}
		log.info(orderMenus);
		
	}

	@Override
	public void addOrderAdd(List<OrderAddDTO> orderAdds) {
		//추가 메뉴 데이터 저장
		for(OrderAddDTO orderAdd : orderAdds) {
			mapper.insertOrderAddMenu(orderAdd);
		}
		log.info(orderAdds);
		
	}

	@Override
	public List<OrderMenuDTO> getOrderMenus(long o_number) {
		return mapper.selectOrderMenus(o_number);
	}

	@Override
	public List<OrderAddDTO> getOrderAdds(long o_number) {
		return mapper.selectOrderAdds(o_number);
	}


	@Override
	public void addOrderInfo(OrderInfoDTO orderInfo) {
		// TODO Auto-generated method stub
		
	}


    
}