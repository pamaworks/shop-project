<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 함수기능을 제공해주는 JSTL 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>cart list</title>


<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>



<style>
th{	padding: 0 !important; 
    width: 100px !important;
    font-size: 15px !important;
    color: slategray;
    }
    
.col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto{
   
    width: auto !important;
  
  }
td, a{
font-size: 13px !important;}

}
</style>

<script src="/js/cart/list.js"></script>

</head>

<body>

   <!-- 헤더 -->
   <%@include file="/WEB-INF/views/common/top.jsp"%>
   <!--// 헤더 -->


   <!-- 본문  -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper" style="margin-top:100px;min-height: 560px;">
         
         <%-- MAIN CONTENT --%> 
         <section class="content container-fluid">
         
         	<%-- 상품 상세 --%>
				<div style="width:100%; background-color:white;" class="container text-center">
				
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
						
							<div class="box-header">
							
								<h3 class="box-title">CART</h3>
							</div>
							<!-- /.box-header -->
							
							<hr style="margin-bottom: 75px;">
							
							            <div class="row">
               <!-- left column -->
               <div class="box" style="width: 100%;margin: 0 auto;border: none;">
                  <form method="post" action="/order/buyFromCart" style="min-width: 530px;">
                 
                  <%-- 상품이 존재하는 경우 --%>
                  <c:if test="${!empty cartProductList}">
                  <div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
                     <button id="btn_buy_check"  class="btn btn-secondary" type="submit" style="font-size:12.5px;">선택 상품 구매</button>
                     <button id="btn_delete_check"  class="btn btn-secondary" style="background-color: lightgray;color: white;border-color: lightgray;font-size:13px;">선택 상품 삭제</button>
                  </div>
                  </c:if>
                  
                  <%-- 상품이 존재하지않는 경우 --%>
                  <c:if test="${empty cartProductList}">
                  <div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
                     <button class="btn btn-secondary" type="button" style="font-size:12.5px;">선택 상품 구매</button>
                     <button class="btn btn-secondary" type="button" style="background-color: lightgray;color: white;border-color: lightgray;font-size:13px;">선택 상품 삭제</button>
                  </div>
                  </c:if>
                  
                  <div class="box-body">
                     <table class="table table-striped text-center">
                        <tr style="position: relative;text-align: left;">
                           <th><input type="checkbox" id="checkAll" checked="checked" style="left: 13px;position: relative;"/></th>
                           <th>번호</th>
                           <th>상품 이미지</th>
                           <th>상품명</th>
                           <th>판매가</th>
                           <th>할인가</th>
                           <th>수량</th>
                           <th>구매/삭제</th>
                        </tr>
                        
                      <%-- 상품이 존재하지 않는 경우 --%>
                     <c:if test="${empty cartProductList}">
                           <tr>
                              <td colspan="10"> 
                                 <p style="padding:50px 0px; text-align: center;color:red;">장바구니에 담긴 상품이 없습니다.</p>
                              </td>
                           <tr>
                      </c:if>
                        
                        <%-- 상품이 존재하는 경우,  리스트 출력 --%>
                        <!-- JSTL 변수 선언 -->
                        <!-- fn:length(문자열 or 배열) -> Model 컬렉션에 해당하는 성격 -->
                        <c:set var="i" value="${fn:length(cartProductList)}" />
                        <c:forEach items="${cartProductList}" var="cartProductVO">
                           <!--  value가 3이면 i=3 tr도 3번 반복 -->
                           <tr style="position: relative;text-align: left;">                              <!-- hidden으로 숨겨놓기 -->
                              <td class="col-md-1">
                                 <input type="checkbox" name="check" class="check" value="${cartProductVO.cart_code}" checked="checked" >
                                 <input type="hidden" id="pdt_num_${cartProductVO.cart_code}" name="pdt_num" value="${cartProductVO.pdt_num}" >
                                 <input type="hidden" name="cart_amount" value="${cartProductVO.cart_amount}" >
                                 <input type="hidden" name="cart_code" value="${cartProductVO.cart_code}" >
                              </td>
                              
                              <!-- 번호 -->
                              <!-- i값 : value="${fn:length(cartProductList)} -->
                              <td class="col-md-1">${i}</td>
                              
                              <td class="col-md-2">
                                 <a href="/product/read?pdt_num=${cartProductVO.pdt_num}&cate_code=${cate_code}">
                                    <img src="/product/displayFile?fileName=${cartProductVO.pdt_img}" style="width:100px;">
                                 </a>
                              </td>
                              <td class="col-md-2">
                                 <a href="/product/read?pdt_num=${cartProductVO.pdt_num}&cate_code=${cate_code}"
                                    style="color: black;"> ${cartProductVO.pdt_name} </a>
                              </td>
                              
                              <!-- name은 기본적으로 중복이 가능하나, 프로그래밍 목적에 따라서 적절히! -->
                              <td class="col-md-1">
                                 <p>${cartProductVO.pdt_price}</p>
                                 <input type="hidden" name="price_${cartProductVO.cart_code}" value="${cartProductVO.pdt_price}" /></td>
                              <td class="col-md-1">
                                 <p>${cartProductVO.pdt_discount}</p>
                                 <input type="hidden" name="discount_${cartProductVO.cart_code}" value="${cartProductVO.pdt_discount}" /></td>
                              
                              
                              <td class="col-md-2">
                                 <input type="number" name="cart_amount_${cartProductVO.cart_code}"
                                    style="width:60px; height:34px; padding-left:5px;" value="${cartProductVO.cart_amount}" />
                                 <button type="button" name="btn_modify" class="btn btn-secondary" value="${cartProductVO.cart_code}" style="background-color: lightgray;color: white;border-color: lightgray;font-size:13px;">변경</button>
                              </td>
                              <td class="col-md-2">
                                 <button type="button" name="btn_buy" class="btn btn-secondary" value="${cartProductVO.cart_code}"
                                    onclick="clickBuyBtn(${cartProductVO.pdt_num}, ${cartProductVO.cart_code});" style="font-size:12.5px;">구매</button>
                                 <button type="button" name="btn_delete" class="btn btn-secondary" value="${cartProductVO.cart_code}" style="background-color: lightgray;color: white;border-color: lightgray;font-size:13px;">삭제</button>
                              </td>
                              
                              <c:set var="i" value="${i-1}" ></c:set> <!-- i 값 줄어들게한 후, 다시 저장 -->
                           </tr>

                        </c:forEach>
                        
                        
                     </table>
                  </div>
                  </form>
                  <div class="box-body" style="width: 100%;padding-bottom:10%;min-width: 530px;">
                     <table class="table table-striped text-center" >
                        <tr>
                           <td class="col-md-1">총 상품금액</td>
                           <td class="col-md-1">결제 예정 금액</td>
                        </tr>
                        <tr >
                           <td class="col-md-1" style="height:50px; text-align: center;"><p id="totalPrice">0</p></td>
                           <td class="col-md-1" style="height:50px; text-align: center;"><p id="totalDiscount">0</p></td>
                        </tr>
                     </table>
                  </div>
               </div>
            </div>


						
					</div>
					<!--/.col (left) -->
				
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