<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>admin order read</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>

<style>

.order_name_list td{

    font-size: 13.5px;
    font-weight: 600;

}   
   
</style>

</head>



<body class="hold-transition skin-blue sidebar-mini">

	<%-- @ModelAttribute("cri") SearchCriteria cri, Model model --%>

	<%-- 로그아웃 상태 --%>
	<c:if test="${sessionScope.admin == null}">
		<script>
			alert("관리자만 접근 가능합니다. \n로그인 해주세요.");
			location = "/admin/loginMain";
		</script>
	</c:if>
	<%-- // 로그아웃 상태 --%>


	<%-- 로그인한 상태 --%>

	<c:if test="${sessionScope.admin != null}">

		<!-- 헤더 -->
		<%@include file="/WEB-INF/views/common/admin/top.jsp"%>
		<!-- // 헤더 -->


		<!-- 사이드바 메뉴 /관리자기능 -->
		<%@include file="/WEB-INF/views/common/admin/left.jsp"%>
		<!-- // 사이드바 메뉴 -->


		<!-- 본문 -->
		<div class="wrapper">


			<div class="content-wrapper">
				<section class="content-header">
					<h1>
						Prinha Admin Page <small style="font-size: 13px;"> 주문 상세 조회 </small>
					</h1>
				</section>


				<section class="content container-fluid">
					<div class="row">
					<div class="col-md-12">
					<div class="box box-primary">
					<div class="box-body">
							

							<%-- 주문내역 상단 버튼 --%>
							<div class="orderList" style="padding: 0px 40px;margin-top:27px;">
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
										
										</tr>
									</c:forEach>
									</tbody>
								</table>
								<br><br><br>
							</div>
							<hr style="width: 90%;"><br>
							
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
							
						
					</div>
					</div>	
					</div>
				</section>

			</div>
		</div>
		<!-- // 본문 -->



		<!-- // 푸터 -->
		<%@include file="/WEB-INF/views/common/admin/bottom.jsp"%>
		<!-- 푸터 -->
	

</c:if>
	<%-- // 로그인한 상태 --%>

</body>
</html>