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

<title>buy</title>


<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>


<style>
.col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto{
   width: auto !important;}
</style>
<script>
	$(function(){
		
		// 주문내역확인 클릭
		$('#btn_orderList').on("click",function(){
			location.href="/order/list";
		});
		
		// 쇼핑계속하기
		$('#btn_main').on("click",function(){
			location.href="/";
		});
		
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
			<section class="content container-fluid">
			
			
    			<div class="box" style="border: none; padding:200px 50px; text-align: center;">
					<div class="box-body"  >
						<h3>해당 상품의 주문이 완료되었습니다.</h3><br>
						<button type="button" id="btn_orderList" class="btn btn-secondary" style="font-size: 13px;">주문내역 확인</button>
						<button type="button" id="btn_main" class="btn btn-secondary" style="background-color: lightgray;color: white;border-color: lightgray;font-size:13px;">쇼핑 계속하기</button>
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