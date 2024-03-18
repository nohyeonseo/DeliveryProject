package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
    
    @Autowired
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

	@Override
    public void processOrder(Map<String, Object> orderData) {
        // 주문 데이터 삽입
		mapper.insertOrder(orderData);

        // 주문 메뉴 데이터 처리
        List<Map<String, Object>> orderMenus = (List<Map<String, Object>>) orderData.get("orderMenus");
        for (Map<String, Object> menuData : orderMenus) {
            menuData.put("oNumber", orderData.get("oNumber")); // 주문 번호를 메뉴 데이터에 추가
            mapper.insertOrderMenu(menuData);
        }
    }
    
}