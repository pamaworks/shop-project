<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>list Search</title>


<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>



<style>
ul{
   	list-style:none;
   	padding-left:0px;
}
.pdtList{
    display: inline-block;
    margin: 10px;
    padding:22px 40px;
}


</style>

<link rel= "stylesheet" type="text/css" href="/css/member/pager.css">

<%-- 버튼 처리 --%>
<script>

/* 장바구니 버튼 클릭 이벤트 */
var cart_click = function(pdt_num){
	$.ajax({
		url: "/cart/add",
		type: "post",
		dataType: "text",
		data: {pdt_num: pdt_num},
		success: function(data){
			var result = confirm("장바구니에 추가되었습니다.\n지금 확인하시겠습니까?");
			if(result){
				location.href="/cart/list";
			} else{}
		}
	});
}


$(document).ready(function(){


	if($('#logout_check').val()==""){
		
		// 로그아웃 상태에서 장바구니, 구매하기 버튼 클릭시 로그인 페이지로 이동
		$('button[name=btn_buy]').on("click",function(){
			alert("로그인 후 이용가능합니다.");
			location.href="/member/login";
		});
		
		$('button[name=btn_cart]').on("click",function(){
			alert("로그인 후 이용가능합니다.");
			location.href="/member/login";
		});	
	}
	

	
});	
</script>


</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->

	<input type="hidden" id="logout_check" value="${sessionScope.user.mem_id}">

	<!-- 본문  -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="margin-top:100px;min-height: 560px;">
			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
			
				<%-- 상품 검색 표시 --%>
				<div style="width:100%; background-color:white;" class="container text-center">
					<h3>Search : ${scri.keyword}</h3><br>
					
					
					
			<ul class="pdtList" style="padding: 0;">
						
						
				<%-- 상품이 존재하지 않는 경우 --%>
				<c:if test="${empty productList}">
					<span>검색 조건에 일치하는 상품이 존재하지 않습니다.</span>
				</c:if>
				
						
			<%-- 상품이 존재하는 경우 --%>
			<c:forEach items="${productList}" var="productVO" >		
			<%-- pdt_buy가 Y인 경우 --%>
            <c:if test="${productVO.pdt_buy == 'Y'}">
            
            
			
						
			<div class="card h-100" style="border:none;width: 27%;min-width: 270px;margin: 0 27px; display: inline-block;margin-bottom:50px;">
			
			
				<li class="product" style="display: none;">${productVO.pdt_num}</li>
			
				<!-- img 400x400 -->
              <a href="/product/readSearch${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}">
              		<img class="card-img-top" src="/product/displayFile?fileName=${productVO.pdt_img}" alt="thumb_img">
              </a>
              
              <div class="card-body">
                <h4 class="card-title" style="text-align: left;margin-bottom: 10px;">
                  <a href="/product/readSearch${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}"
                   	style="color:#444444;font-size: 15.5px;font-weight: 600;">${productVO.pdt_name}</a>
                </h4>
                
                <hr>
                
                <p style="text-align: right;margin-bottom: 4px;font-size: 12px;text-align: right;">판매가 : <fmt:formatNumber value="${productVO.pdt_price}" pattern="###,###,###" />원</p>
                <h5 style="text-align: right;color: indianred;font-size: 15px;font-weight: 600;text-align: right;">할인가 : <fmt:formatNumber value="${productVO.pdt_discount}" pattern="###,###,###" />원</h5>
                <p class="card-text"></p>
                
               <div class="btnContainer" style="text-align: right;">
					<button class="btn btn-secondary" id="btn_buy" name="btn_buy" type="button" style="font-size: 12px;width: 74px;"
						onclick="location.href = '/order/buy?pdt_num=${productVO.pdt_num}&ord_amount=1';">바로구매</button>
					<button class="btn btn-secondary" id="btn_cart" name="btn_cart" type="button" style="width: 74px;font-size: 12px;background-color: lightgray;width: 74px;color: white;border-color: lightgray;"
						onclick="cart_click(${productVO.pdt_num})">장바구니</button>
				</div>
                
           		</div>
           		</div>
           		</c:if>
				</c:forEach>			

					</ul>
				</div>
			
							
							
				
				
				<%-- 페이지 표시 --%>
				<div class="box-footer container" style="width:100%;margin-top: 40px; ">
					<div class="text-center">
						<ul class="pagination">
						
						
							<c:if test="${pm.prev}">
								<li><a href="listSearch${pm.makeSearch(pm.startPage-1)}">&laquo;</a>
								</li>
							</c:if>


							<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
								var="idx">
								<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
									<a href="listSearch${pm.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>


							<c:if test="${pm.next && pm.endPage > 0}">
								<li><a href="listSearch${pm.makeSearch(pm.endPage +1)}">&raquo;</a>
								</li>
							</c:if>
							
							
						</ul>
					</div>
				</div>

				
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

	<!--// 본문  -->



	<!-- 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!--// 푸터 -->




</body>
</html>