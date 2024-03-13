<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<body>
	<div class="modal fade" id="menuAddModal" tabindex="-1" aria-labelledby="menuAddModalLabel" aria-hidden="true" id="moda1">
		<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<h5 class="modal-title" id="menuAddModalLabel">추가 메뉴</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">x</button>
	     		</div>
		      	<div class="modal-body">
			        
			        <ul>
			        	<c:forEach var="menuAdd" items="${menuAddList}">
			            	<li>
			            		<input type="checkbox" name="menuAdd" value="${menuAdd.a_id}" data-price="${menuAdd.a_price}">
			            		${menuAdd.a_name}: ${menuAdd.a_price}원
								수량설정
								수량: 
				                <select name="addnumber" id="addMenuNum${status.index}">
				                    <c:forEach begin="1" end="5" var="i">
				                        <option value="${i}"> ${i} </option>
				                    </c:forEach>
				                </select>
			            	</li>
		          		</c:forEach>
			        </ul>
			        
		      	</div>
	   			<div class="modal-footer">
	   			
					<!--세션에 담겨야하는 컨트롤러를 구현 --> 	   				
	   				<button onclick="addToCart(${menu.m_id})">담기</button>

		      	</div>
    		</div>
   		</div>
	</div>
	
</body>
</html>