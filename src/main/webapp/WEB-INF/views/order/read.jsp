<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>order read</title>


<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>


<style>
.col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto{
   width: auto !important;}


.order_name_list td{

    font-size: 13.5px;
    font-weight: 600;

}   

#delivery_box > div{position: relative;width: 250px; display: inline-block;text-align: center;}


.deli_text{font-size: 14px; margin-top: 10px; font-weight: 600; color: #444444;}

</style>

<%-- 배송상태 --%>
<script>
$(function(){
	
	if($('#delivery_status').val()=='배송준비중'){
		
		$("#delivery1_img").attr("src", "/img/delivery1_1.png");
		$('#delivery1_text').attr("style","color:#5ac712");
		
		$("#delivery2_img").attr("src", "/img/delivery2.png");
		$('#delivery2_text').attr("style","color:#444444");
		
		$("#delivery3_img").attr("src", "/img/delivery3.png");
		$('#delivery4_text').attr("style","color:#444444");
		
	}else if($('#delivery_status').val()=='배송중'){
		
		$("#delivery1_img").attr("src", "/img/delivery1.png");
		$('#delivery1_text').attr("style","color:#444444");
		
		$("#delivery2_img").attr("src", "/img/delivery2_1.png");
		$('#delivery2_text').attr("style","color:#5ac712");
		
		$("#delivery3_img").attr("src", "/img/delivery3.png");
		$('#delivery4_text').attr("style","color:#444444");
		
	}else if($('#delivery_status').val()=='배송완료'){
		
		$("#delivery1_img").attr("src", "/img/delivery1.png");
		$('#delivery1_text').attr("style","color:#444444");
		
		$("#delivery2_img").attr("src", "/img/delivery2.png");
		$('#delivery2_text').attr("style","color:#444444");
		
		$("#delivery3_img").attr("src", "/img/delivery3_1.png");
		$('#delivery3_text').attr("style","color:#5ac712");
	}
	


});
</script>

</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->

	<!-- 본문  -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="margin-top:100px;min-height: 560px;">
			
			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid" style="margin-bottom: 60px;">
			
			<div class="row">
				<!-- left column -->
				<div class="box" style="width:85%; border: none;margin: 0 auto;">
				
		<div class="box-header">
							
			<h3 class="box-title" style="text-align: center;font-size: 1.6rem;font-weight: 600;">ORDER DETAIL LIST</h3>
		</div>
							
							
		<hr style="margin-bottom: 75px;">
			<form id="orderForm" method="post" action="/order/buy">
    		<div class="box-body">
							

							<%-- 주문내역 상단 버튼 --%>
							<div class="orderList" style="padding: 0px 40px;">
								<%-- 주문내역 테이블 --%>
								<table class="table  text-center" id="ordertbl">
									<thead id="thead">
										<tr style="background-color: aliceBlue;" >
											<td colspan="7" style="text-align:left;">
												
												
												<b style="font-style: italic; color: darkgray; font-size: 14px;">주문일자: <fmt:formatDate value="${order.ord_regdate}" pattern="yyyy/MM/dd HH:mm:ss"/></b>
												
												
												<span style="display: none;">주문번호: ${order.ord_code}</span>
											</td>
										<tr>
										<tr class="order_name_list" style="background-color: whitesmoke;">
											<td>상품이미지</td>
											<td>상품명</td>
											<td>판매가</td>
											<td>할인가</td>
											<td>구매수량</td>
											<td>총 구매 가격</td>
											<td>리뷰</td>
										
										</tr>
										<%-- 상품이 존재하지 않는 경우 --%>
										<tr>
											<c:if test="${empty orderList}">
												<span style="color: red;font-size: 13.5px;">구매하신 상품이 존재하지 않습니다.</span>
											</c:if>
										</tr>
									<thead>
									
									<%-- 상품이 존재하는 경우,  리스트 출력 --%>
									<tbody>
									<c:forEach items="${orderList}" var="product" varStatus="status">
									<c:set var="totalPrice" value="${totalPrice + orderList[status.index].pdt_price * orderList[status.index].ord_amount}"></c:set>
										<tr id="row">
											<td class="col-md-2">
												<a href="/product/read?pdt_num=${product.pdt_num}">
													<img src="/product/displayFile?fileName=${product.pdt_img}" style="width:100px;">
												</a>
											</td>
											<td class="col-md-2">
												<a href="/product/read?pdt_num=${product.pdt_num}"
													style="color: black;"> ${product.pdt_name} </a>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${product.pdt_price}" pattern="###,###,###" /></p>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${product.ord_price}" pattern="###,###,###" /></p>
											</td>
											<td class="col-md-1">
												<p>${product.ord_amount}</p>
											</td>
											<td class="col-md-1">
												<p ><fmt:formatNumber value="${product.ord_price * product.ord_amount}"  pattern="###,###,###" /></p>
											</td>
											<td class="col-md-1">
												<button type="button" name="btn_review" class="btn btn-secondary" style="font-size: 12px;background-color: lightgray;color: white;border-color: lightgray" 
												onclick="location.href='/product/read?pdt_num=${product.pdt_num}';" value="${product.pdt_num}" >상품후기 쓰기</button>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
								<br><br><br>
							</div>
							<hr><br>
							
							
							
							<div>
								<div class="box-header">
							
									<h3 class="box-title" style="text-align: center;font-size: 22px;font-weight: 600;color: black;margin: 20px;margin-bottom: 30px;">배송 진행 상황</h3>
								</div>
								
								<div class="box-body" id="delivery_box" style="position: relative;text-align: center;margin-bottom: 50px;">
								
									<input type="hidden" id="delivery_status" value="${order.ord_delivery}">
								
									<div id="delivery1" >
										<img src="/img/delivery1.png" alt="delivery" id="delivery1_img">
										<p class="deli_text" id="delivery1_text">배송준비중</p>
									</div>
									<img src="/img/po.png" alt="point" style="width: 28px; margin-top: -165px;">
									<div id="delivery2">
										<img src="/img/delivery2.png" alt="delivery" id="delivery2_img">
										<p class="deli_text" id="delivery2_text">배송중</p>
									</div>
									<img src="/img/po.png" alt="point" style="width: 28px; margin-top: -165px;">
									<div id="delivery3" >
										<img src="/img/delivery3.png" alt="delivery" id="delivery3_img">
										<p class="deli_text" id="delivery3_text">배송완료</p>
									</div>
								
								</div>
							
							
							</div>
							
							
							
							<hr style="clear: both;"><br>
							<%-- 주문 정보 --%>
							<div class="orderInfo" style="min-width:1000px;" > 
								<div class="userInfo" style="display:inline-block; float:left; width:60%; padding: 0% 5%;">
									<div class="container" style="width:100%;">
										<span style="font-size: 14px; font-weight: 600; color: indianred; margin-bottom: 15px; display: inline-block;">[주문 정보]</span>
										<div class="form-group">
											<label for="inputName">* 이름</label> <input type="text"
												class="form-control" value="${order.ord_name}" readonly style="width:calc(100% - 128px);">
										</div>
										<div class="form-group">
											<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
												class="form-control" value="${order.ord_phone}" readonly style="width:calc(100% - 128px);">
										</div>
										<div class="form-group">
											<label for="inputAddr">* 주소</label> <br />
											<input type="text" id="sample2_postcode" name="ord_zipcode" class="form-control" 
												value = "${order.ord_zipcode}" 
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
											
											<input type="text" id="sample2_address" name="ord_addr" class="form-control" 
												value = "${order.ord_addr}" 
												placeholder="주소" style=" margin:3px 0px;width:calc(100% - 128px);" readonly>
											<input type="text" id="sample2_detailAddress" name="ord_addr_d" class="form-control" 
												value = "${order.ord_addr_d}"
												placeholder="상세주소" readonly style="width:calc(100% - 128px);">
											<input type="hidden" id="sample2_extraAddress" class="form-control" 
												placeholder="참고항목"style="width:calc(100% - 128px);">
										</div>
									</div>
								</div>
								
								<%-- 주문 금액 확인 --%>
								<div class="orderConfirm" style="display:inline-block; width:20%; margin: 0px 5%;">
								<br>
									<%-- 주문 금액 --%>
									<div style="width: 400px;padding-right: 25%;">
										<span style="font-size: 14px; font-weight: 600; color: indianred; margin-bottom: 15px; display: inline-block;">[결제 금액]</span>
										<table class="table text-center" style="margin-top:15px;" >
											<tr>
												<td class="col-md-1" style="font-size: 14.5px; font-weight: 600;">총 상품금액</td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<fmt:formatNumber value="${totalPrice}" pattern="###,###,###" />원</td>
											</tr>
											<tr>
												<td class="col-md-1" style="font-size: 14.5px; font-weight: 600;">할인된 금액(-)</td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<fmt:formatNumber value="${totalPrice-order.ord_total_price}" pattern="###,###,###" />원</td>
											</tr>
											<tr>
												<td class="col-md-1" style="font-size: 14.5px; font-weight: 600; color: orangered;"><label>결제 금액</label></td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<label><fmt:formatNumber value="${order.ord_total_price}" pattern="###,###,###" />원</label>
												</td>
											</tr>
										</table>
								
									</div>
								</div>
							</div>


			</div>
			</form>
					
				</div>
			</div>
			</section>
			<!-- /.content -->
		</div>
			
	<!--// 본문  -->

	

	<!-- 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!--// 푸터 -->




</body>
</html>