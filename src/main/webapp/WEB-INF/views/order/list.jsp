<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>order list</title>


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
   
</style>

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
							
			<h3 class="box-title" style="text-align: center;font-size: 1.6rem;font-weight: 600;">ORDER LIST</h3>
		</div>
							
							
		<hr style="margin-bottom: 75px;">
				
    							<div class="box-body">
							<table class="table text-center">
								<%-- 상품이 존재하지 않는 경우 --%>
								<c:if test="${empty orderList}">
									<tr>
										<td colspan="10" style="border: none;"> 
											<p style="padding:50px 0px; text-align: center;border: none;color: red;font-size: 13.5px;">주문하신 상품이 없습니다.</p>
										</td>
									<tr>
								</c:if>
								
								
								<%-- 상품이 존재하는 경우,  리스트 출력 --%>
								<c:forEach items="${orderList}" var="orderVO" varStatus="status">
									<c:if test="${status.index==0 || orderVO.ord_code != code}">
									<tr style="background-color: aliceBlue;" >
										<td colspan="5" style="text-align:left;">
											<b style="font-style: italic; color: darkgray; font-size: 14px;">주문일자: <fmt:formatDate value="${orderVO.ord_regdate}" pattern="yyyy/MM/dd HH:mm:ss"/></b>
											<span style="display: none;">주문번호: ${orderVO.ord_code}</span>
										</td>
										<td> 
											<button class="btn btn-secondary" style="font-size: 12px;" onclick="location.href='/order/read?ord_code=${orderVO.ord_code}';">
											주문 상세보기</button> 
										</td>
									<tr>
									<tr class="order_name_list" style="background-color: whitesmoke;">
										<td>상품이미지</td>
										<td>상품명</td>
										<td>판매가</td>
										<td>할인가</td>
										<td>구매가</td>
										<td>리뷰</td>
									</tr>
									</c:if>
									<c:set var="code" value="${orderVO.ord_code}">	</c:set>
									<tr>
										<td class="col-md-2">
											<a href="/product/read?pdt_num=${orderVO.pdt_num}">
												<img src="/product/displayFile?fileName=${orderVO.pdt_img}" style="width:100px;">
											</a>
										</td>
										<td class="col-md-2">
											<a href="/product/read?pdt_num=${orderVO.pdt_num}"
												style="color: black;"> ${orderVO.pdt_name} </a>
										</td>
										<td class="col-md-1">
											<fmt:formatNumber value="${orderVO.ord_price}" pattern="###,###,###" /></p>
											
										<td class="col-md-1">
											<p>${orderVO.ord_amount}</p>
										</td>
										<td class="col-md-1">
											<fmt:formatNumber value="${orderVO.ord_price * orderVO.ord_amount}" pattern="###,###,###" /></p>
										</td>
										<td class="col-md-2">
											
											<button type="button" class="btn btn-secondary" style="font-size: 12px;background-color: lightgray;color: white;border-color: lightgray"
												onclick="location.href='/product/read?pdt_num=${orderVO.pdt_num}';" value="${orderVO.pdt_num}" >상품후기 쓰기</button>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
				
					
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