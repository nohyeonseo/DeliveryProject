<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
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

    <link href="/resources/css/delivery.css" rel="stylesheet">
    <link href="/resources/css/restaurant.css" rel="stylesheet">
    <style>
		#review-box { 
				display: none; 
		} 
		#info-box {
				display: none;
		}
	</style>
</head>
<body>
	<script>
		$(document).ready(function(){
			$('input[type=radio][name=btnradio]').on('click', function(){
				var chkValue = $('input[type=radio][name=btnradio]:checked').val();
				
				if(chkValue == 'menu'){
					$('#menu-box').css('display', 'block');
					$('#review-box').css('display', 'none');
					$('#info-box').css('display', 'none');
				}
				
				else if(chkValue == 'review'){
					$('#menu-box').css('display', 'none');
					$('#review-box').css('display', 'block');
					$('#info-box').css('display', 'none');
				}
				
				else if(chkValue == 'info'){
					$('#menu-box').css('display', 'none');
					$('#review-box').css('display', 'none');
					$('#info-box').css('display', 'block');
				}
			});
		});
		//모달창
        function loadMenuAddList(m_id, m_num, m_price) {
		    // 모달창의 입력 필드에 값을 설정
		    $('#m_id_input').val(m_id);
		    $('#m_num_input').val(m_num);
		    $('#m_price_input').val(m_price);
		
		    // 수량 선택 드롭다운을 생성
		    var quantityOptions = '';
		    for (var i = 1; i <= 3; i++) { // 최대 3개까지만 선택 가능
		        quantityOptions += `<option value="${i}">${i}</option>`;
		    }
		    $('#menu-quantity-select').html(quantityOptions);
		
		    // 모달창 표시
		    $("#menuModal").modal('show');
		}
		</script>
	<!-- 헤더 -->
    <nav class="navbar navbar-light bg-danger position-fixed">
        <div class="container-md">
            <div>
                <a class="navbar-brand" href="/">
                    <img src="/resources/img/no-img.png">
                </a>

            </div>

            <!-- 로그인 전 -->
            <div>
                <button type="button" class="btn btn-light">로그인</button>
            </div>
		</div>
    </nav>

    <!-- 컨텐츠 -->
    <c:set var="rest" value="${rest}"/>
    <div class="contents">
        <div class="container-md">
            <div class="restaurant-box">
                <div class="titleimg-box">
                    <img src="/resources/upload/${rest.r_img}" class="img-fluid">
                </div>

                <!-- JS 이용해 라디오 버튼의 체크에 따라 해당 탭 보여줌 (부트스트랩 visually-hidden 클래스 넣고 빼는식) -->
                <div class="title-box pt-4">
<!--                     <h2>가게이름</h2> -->
                    <h2>${rest.r_lname}</h2>
                    <p><i class="bi bi-star-fill text-warning"></i>&nbsp;${rest.avg}</p>

                    <div class="row">
                        <div class="col-12 btn-group" role="group" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check" name="btnradio" id="btnradio1" value="menu" checked>
                            <label class="btn btn-outline-danger rounded-0 border-0" for="btnradio1">메뉴</label>

                            <input type="radio" class="btn-check" name="btnradio" id="btnradio2" value="review">
                            <label class="btn btn-outline-danger rounded-0 border-0" for="btnradio2">리뷰</label>

                            <input type="radio" class="btn-check" name="btnradio" id="btnradio3" value="info">
                            <label class="btn btn-outline-danger rounded-0 border-0" for="btnradio3">정보</label>
                        </div>
                    </div>
                </div>

                <!-- 메뉴 탭 -->
                <div class="menu-box" id="menu-box">
                	<c:forEach items="${menuCatList}" var="menuCat">
                    <!-- 메뉴 카테고리 -->
	                    <div class="menucat-box d-grid">
	                        <input type="checkbox" class="btn-check" id="btncheck1">
	                        <label class="btn btn-light rounded-0 fw-bold fs-5" for="btncheck1">${menuCat.m_cat}</label>   
	                        
	                        <!-- 메뉴 목록 1, ${menu.m_price}-->
	                        <div class="menulist-box d-grid">
								<c:forEach items="${menuList}" var="menu">
								    <c:if test="${menu.m_cat eq menuCat.m_cat}">
								        <button type="button" onclick="loadMenuAddList(${menu.m_id},1, ${menu.m_price})" class="menuitem-box p-1 bg-white border-0">
								            <div class="card rounded-0 border-0">
			                                    <div class="row g-0">
			                                        
			                                        
			                                        <div class="col-2">
			                                            <div class="image-box">
			                                                <img src="${menu.m_img}" class="img-fluid rounded-start">
			                                            </div>
			                                        </div>
			    
			                                        <div class="col-10">
			                                            <div class="card-body">
			                                                <h5 class="card-title">${menu.m_name}</h5>
			                                                <p class="card-text">${menu.m_intro}</p> 
			                                                <div class="menuprice-box">
			                                                    <p class="card-text fw-bold">가격: ${menu.m_price}원</p>
			                                                </div>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                            </button>
		                            </c:if>
	                            </c:forEach>
	                        </div>
	                    </div>
                    </c:forEach>
                </div>
                <!-- 메뉴 탭 -->

                <!-- 리뷰 탭 -->
                <div class="review-box" id="review-box">
                    <!-- 단일 리뷰 -->
                    <div class="reviewitem-box d-grid">
                        <div class="card p-1 rounded-0 border-0">
                            <div class="row g-0">
                                <div class="col-2">
                                    <div class="image-box position-relative">
                                        <img src="no-photo.png" class="img-fluid rounded-start">
                                        <button class="bg-white bg-opacity-10 border-0 position-absolute bottom-0 end-0"><i class="bi bi-plus"></i></button>
                                    </div>
                                </div>

                                <div class="col-10">
                                    <div class="card-body position-relative">
                                        <div class="row reviewtop-box card-title">
                                            <span class="col-4 fw-bold">닉네임(10글자 까지)</span>
                                            <span class="col-2"><i class="bi bi-star-fill text-warning"></i>&nbsp;0.0</span>
                                            <span class="col-6 reviewdate">날짜</span>
                                        </div>
                                        
                                        <!-- 리뷰내용 두줄 넘어가면 안됨(카드 이상해짐) -->
                                        <p class="card-text">리뷰내용(2줄까지)</p>

                                        <button class="bg-white border-0 position-absolute bottom-0 end-0"><span class="badge bg-light text-dark">더보기</span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- 리뷰 탭 -->

                <!-- 정보 탭 -->
                <div class="info-box p-3" id="info-box">
                    <div class="infonotice-box">
                        <span class="fw-bold"><i class="bi bi-info-lg"></i>&nbsp;알림사항</span>

                        <p class="p-2 pb-4">${rest.r_intro}</p>
                    </div>

                    <hr>

                    <div class="infoshop-box">
                        <span class="fw-bold"><i class="bi bi-shop"></i>&nbsp;가게정보</span>
						
                        <div class="row p-2">
                            <!-- 영업시간 -->
							<div class="col-3">
                                <p>영업시간</p>
                            </div>
                            <c:set value="${restOpen}" var="open"/>
							<fmt:formatDate value="${open.r_opent}" pattern="HH:mm" var ="opent"/>
							<fmt:formatDate value="${open.r_closet}" pattern="HH:mm" var="closet"/>
	                            <div class="col-9">
	                                <p><b> ${opent} ~ ${closet}</b></p>
	                            </div>
                            <!-- 휴무일 -->
                            <div class="col-3">
                                <p>휴무일</p>
                            </div>
                            <c:set value="${restClosed}" var="closed"/>
	                            <div class="col-9">
	                                <p><b>${closed.w_cname}요일</b></p>
	                            </div>
                            <!-- 주소 -->
                            <div class="col-3">
                                <p>주소</p>
                            </div>

                            <div class="col-9">
                                <p><b>${rest.r_addr}</b><b>${rest.r_dtad}</b></p>
                            </div>
                        </div>
                    </div>
				
                    <hr>

                    <div class="infopay-box">
                        <span class="fw-bold"><i class="bi bi-credit-card-2-back"></i>&nbsp;결제정보</span>
                        
                        <div class="row p-2">
                            <!-- 최소주문금액 -->
                            <div class="col-3">
                                <p>최소주문금액</p>
                            </div>

                            <div class="col-9">
                                <p><b>${rest.r_minprice }</b></p>
                            </div>

                            <!-- 결제수단 -->
                            <div class="col-3">
                                <p>결제수단</p>
                            </div>

                            <div class="col-9">
                                <p>
									<c:forEach items="${restMethod}" var="method">
										<b>${method.p_cname}</b>
									</c:forEach>
								</p>
                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="infolicense-box">
                        <span class="fw-bold"><i class="bi bi-person-vcard"></i>&nbsp;사업자정보</span>
                        
                        <div class="row p-2">
                            <!-- 사업자등록번호 -->
                            <div class="col-3">
                                <p>사업자등록번호</p>
                            </div>

                            <div class="col-9">
                                <p><b>${rest.r_licnum}</b></p>
                            </div>

                            <!-- 결제수단 -->
                            <div class="col-3">
                                <p>상호명</p>
                            </div>

                            <div class="col-9">
                                <p><b>${rest.r_lname}</b></p>
                            </div>
                        </div>
                    </div>
                    
                    
                </div>
                <!-- 정보 탭 -->
            </div>
        </div>
    </div>
    <!-- 모달 -->
	<div class="modal fade" id="menuModal" tabindex="-1" aria-labelledby="menuAddModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="menuAddModalLabel">메뉴 선택</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <input type="hidden" id="m_id_input" value="">
	                <input type="hidden" id="m_num_input" value="1">
	                <input type="hidden" id="m_price_input" value="">
	
	                수량 선택: <select id="menu-quantity-select"></select>
	            </div>
	            <div class="modal-footer">
	                <button type="button" id="add-to-cart-btn" class="btn btn-primary">담기</button>
	            </div>
	        </div>
	    </div>
	</div>
    <!--모달 -->
	
	<!-- 주문서 작성 -->
	<button id="menusave"> 장바구니 저장</button>
	<button id="orderDetail">주문서 이동</button>
	<!-- 주문서 작성 -->    
	
	<script>
		//세션 푸시 -> 컨트롤러 만들기 아직임
		$('#add-to-cart-btn').click(function() {
		    var m_id = $('#m_id_input').val();
		    var m_quantity = $('#menu-quantity-select').val();
		    var m_price = $('#m_price_input').val();
	
		    // 서버로 메뉴 ID와 수량을 전송
		    $.ajax({
		        url: "/menu/sessionCart",
		        type: "POST",
		        data: {
		            m_id: m_id,
		            m_quantity: m_quantity,
		            m_price: m_price
		        },
		        success: function(response) {
		            alert("메뉴가 저장되었습니다.");
		            $("#menuModal").modal('hide');
		        },
		        error: function(error) {
		            alert("오류가 발생했습니다. 다시 시도해주세요.");
		        }
		    });
		});
		('#menusave').click(function() {
		    $.ajax({
		        url: "/menu/menusave", // 서버 측 URL로 변경해야 합니다.
		        type: "POST",
		        success: function(response) {
		            alert("장바구니가 성공적으로 저장되었습니다.");
		            // 필요한 추가 로직 (예: 페이지 리다이렉션)
		        },
		        error: function(error) {
		            alert("저장 과정에서 오류가 발생했습니다. 다시 시도해주세요.");
		        }
		    });
		});
		
		
		
        //세션에 푸쉬
/*         function addToCart(m_id, m_num, m_price)
        {	
        	var m_id = $('#m_id_input').val();
        	var m_num = $('#m_num_input').val();
        	var m_price = $('#m_price_input').val();
        	
            var selectedItems = [];
            
            $('.menu-add-checkbox:checked').each(function()
            {
            	var a_id = $(this).data("a-id");    
            	var a_name = $(this).data("a-name");
            	var a_price = $(this).data("a-price");
            	var a_quantity = $(this).closest("li").find(".menu-add-quantity").val();
            	
            	var MenuItem = 
            	{
          			m_id: m_id,
                   	m_num: m_num,
                    m_price: m_price,
                    a_id: a_id,
                    a_name: a_name,
                    a_price: a_price,
                    a_quantity: a_quantity
                };            
                selectedItems.push(MenuItem);
            });
            console.log("Selected items:", selectedItems);
            
            $.ajax({
            url: "/menu/sessionCart",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(selectedItems),
            success: function(response) 
            {
                console.log("메뉴가 담겼습니다.:", response);
                alert("성공적으로 담겼습니다.!");
                $("#menuModal").modal('hide');
            },
            error: function(error) {
                console.error("메뉴를 담는데 실패하였습니다.", error);
                alert("메뉴를 담는데 실패");
            }
        });
        }
         */
        
        //디비 저장고 조회 이부분은 다시 
//         $("#orderDetail").click(function() {
// 		    $.ajax({
// 		        url: "/order/confirm",
// 		        type: "POST",
// 		        success: function(response) 
// 		        {
// 		            alert("주문이 완료되었습니다.");
// 		            location.href= "/order/viewOrder/" + response.o_number; 
// 		        },
// 		        error: function(xhr, status, error) {
// 		            console.error("메뉴를 담는데 실패하였습니다. 상태: ", status, "오류: ", error, "응답: ", xhr.responseText);
// 		            alert("메뉴를 담는데 실패하였습니다. 상세 오류: " + xhr.responseText);
// 		        }
// 		    });
// 		});
        
        
    </script>	
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

    <script src="/resources/js/delivery.js"></script>
</body>
</html>