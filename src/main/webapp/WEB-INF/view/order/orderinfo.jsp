<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WELCOME DELIVERY WEB!</title>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

    <!-- 제이쿼리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="../css/delivery.css" rel="stylesheet">
    <link href="../css/order.css" rel="stylesheet">
</head>
<body>
<!-- 헤더 -->
<!-- 삼항연산자를 사용하여 로그인 전후 표현  -->
    <nav class="navbar navbar-light bg-danger position-fixed">
        <div class="container-md">
        
        
		 <div>
		    <a class="navbar-brand" href="/">
		        <img src="no-photo.png" width="30" height="30">
		    </a>
		    <!-- 로그인 상태에 따른 내용 표시 -->
		    <% boolean isLoggedIn = session.getAttribute("isLoggedIn") != null && (Boolean)session.getAttribute("isLoggedIn"); %>
		    <div>
		        <%= !isLoggedIn ? "<button type='button' class='btn btn-light'>로그인</button>" : "" %>
		    </div>
		
		    <!-- 로그인 후 내용 -->
		    <div>
		        <%= isLoggedIn ? "<a href='#' class='btn btn-danger'><i class='bi bi-shop' style='font-size: 1.5rem;'></i></a>"
		                        + "<a href='#' class='btn btn-danger position-relative'><i class='bi bi-cart' style='font-size: 1.5rem;'></i></a>"
		                        + "<a href='#' class='btn btn-danger'><i class='bi bi-person-fill' style='font-size: 1.5rem;'></i></a>"
		                        + "<button type='button' class='btn btn-light'>로그아웃</button>" : "" %>
		    </div>
		</div>
           
       </div>
   </nav>
	
    <!-- 컨텐츠 -->
    <div class="contents">
        <div class="container-md">
            <div class="orderlist-box">
            
                <form action="/order" method="post" class="text-align">
                    <input type="hidden" name="o_number" value="${o_number}">
                    <input type="hidden" name="r_id" value="${r_id}">
                    
                    <h4>주문서</h4>

                    <hr>
                    <input type="hidden" name="r_id" value="r_id">
                    <input type="hidden" name="u_id" value="u_id">

                     <!-- 가게 정보 -->
                    <div class="row">
                        <label class="col-md-3 col-sm-12 col-form-label"><b> 주문정보 </b></label>
                        <div class="col-md-9 col-sm-12">
                            <div class="card">
                                <div class="row g-0">
                                    
                                    <div class="col-2">
                                        <div class="image-box">
                                            <img src="no-photo.png" class="img-fluid rounded-start">
                                        </div>
                                    </div>

                                    <div class="col-10">
                                        <div class="card-body">
                                            <h5 class="card-title"><a href="#" class="text-decoration-none text-dark"></a></h5>
                                            <p class="card-text"><i class="bi bi-star-fill text-warning"></i>&nbsp; </p>
                                            <p class="card-text">결제방식 | 최소주문금액</p>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 가게 정보 -->
					<input type="text" value="${orderMenu.o_number}" class="form-control border-0 bg-white" readonly>
                    
                    <!-- 메뉴 정보 -->
                    <div class="row">
                        <label class="col-4 col-form-label"><b>메뉴</b></label>
                        <label class="col-4 col-form-label"><b>수량</b></label>
                        <label class="col-4 col-form-label"><b>가격</b></label>
                    </div>

                    <!-- 메뉴 목록 -->
					<c:forEach var="orderMenu" items="${orderMenuList}">
					    <div class="row">
					        <div class="col-4">
					            <input type="text" value="${orderMenu.m_name}" class="form-control border-0 bg-white" readonly>
					        </div>
					        <div class="col-4">
					            <input type="text" value="${orderMenu.m_num}" class="form-control border-0 bg-white" readonly>
					        </div>
					        <div class="col-4">
					            <input type="text" value="${orderMenu.m_price}" class="form-control border-0 bg-white" readonly>
					        </div>
					    </div>
					    <c:set var="totalSum" value="${totalSum + (orderMenu.m_num * orderMenu.m_price)}" />
					</c:forEach>
					
                    <!-- 메뉴 정보 -->
                    <div class="row">
                        <label class="col-4 col-form-label"><b>메뉴</b></label>
                        <label class="col-4 col-form-label"><b>수량</b></label>
                        <label class="col-4 col-form-label"><b>가격</b></label>
                    </div>
                    <div class="row">
					    <div class="col-8">
					        <b>합계</b>>
					    </div>
					    <div class="col-4">
					        <input type="text" name="o_tprice" value="${totalSum}" class="form-control border-0 bg-white" readonly>
					    </div>
					</div> 

				</form>
				
				
				<form action="/orderInfo" method="post" class="text-align">
                    <h4>주문정보</h4>

                    <hr>

                    <!-- 배달지 주소 -->
                    <div class="row">
                        <label for="o_addr" class="col-3 col-form-label"><b>배달지 주소</b></label>
                        <div class="col-9">
                            <select class="form-select" id="o_addr">
                                <option value="1">주소1</option>
                            </select>
                        </div>
                    </div>
                    <!-- 배달지 주소 -->

                    <!-- ê²°ì  ë°©ì -->
                    <div class="row">
                        <label for="p_code" class="col-3 col-form-label"><b>결제방식</b></label>
                        <div class="col-9">
                            <select class="form-select" id="p_code">
                                <option value="1">결제방식1/option>
                            </select>
                        </div>
                    </div>
                    <!-- 결제 방식 -->

                    <!-- 주문 방식 -->
                    <div class="row">
                        <label for="t_code" class="col-3 col-form-label"><b>주문방식</b></label>
                        <div class="col-9">
                            <select class="form-select" id="t_code">
                                <option value="1">주문방식1</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <label for="m_intro" class="col-3 col-form-label"><b>요청사항</b></label>
                        <div class="col-9">
                            <textarea type=o_req id="m_intro" class="form-control"></textarea>
                        </div>
                    </div>
                    <!-- 요청 사항 -->

                    <!-- 주문 상태 -->
                    <div class="row">
                        <div class="col-9">
                            <!-- 주문시에는 value 무조건 1로 고정 수정할 필요없음 -->
                            <input type="hidden" name="s_code" value="1">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary">주문하기</button>
                            <a href="/" class="btn btn-light">주문취소</a>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>
    </div>

    <!-- 푸터 시작 -->
    <div class="footer bg-light position-relative bottom-0">
        <div class="container-md">
            <div class="p-3">
                <h4>DELIVERY WEB</h4>
                <hr>
                <p>개발: 김기덕, 노현서, 박종민, 정진성</p>
            </div>
        </div>
    </div>
    <!-- 푸터 끝 -->

    <script src="/js/delivery.js"></script>
    <script>
	$(document).ready(function() {
	    $("#submitOrder").click(function(e) {
	        e.preventDefault(); 
	
	        // 주문 데이터 수집
	        var orderData = {
	            "oNumber": $("#o_number").val(),
	            "rId": $("#r_id").val(),
	            "oAddr": $("#o_addr").val(),
	            "pCode": $("#p_code").val(),
	            "tCode": $("#t_code").val(),
	            "oReq": $("#o_req").val(),
	            "orderMenus": []
	        };
	
	        // 메뉴 목록 수집
	        $(".menu-row").each(function() {
	            var menu = {
	                "mName": $(this).find(".m_name").val(),
	                "mNum": parseInt($(this).find(".m_num").val()),
	                "mPrice": parseFloat($(this).find(".m_price").val())
	            };
	            orderData.orderMenus.push(menu);
	        });
	
	        // AJAX 요청
	        $.ajax({
	            url: "/order/processOrder",
	            type: "POST",
	            contentType: "application/json",
	            data: JSON.stringify(orderData),
	            success: function(response) {
	                window.location.href = "/order/confirmation";
	            },
	            error: function(xhr, status, error) {
	                alert("오류 발생: " + error);
	            }
	        });
	    });
	});
	</script>
    
</body>
</html>