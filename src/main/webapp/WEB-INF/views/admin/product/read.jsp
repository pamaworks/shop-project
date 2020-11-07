<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>admin product detail</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>

<!-- CK Editor -->
<script src="/ckeditor/ckeditor.js"></script>

<!-- Handlebar -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>


<%-- ckEditor 버튼 클릭  --%>
<script>
$(document).ready(function(){
	/* 상품 목록 버튼 클릭 시 */
	$("#btn_list").on("click", function(){
		location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
	});
});
</script>
<style>
.content-img img{
width: 90% !important;
height: auto !important;
}

.thum_origin_img{
width: 30% !important;
height: auto !important;
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
						Prinha Admin Page <small style="font-size: 13px;"> 상품 상세 </small>
					</h1>
				</section>


				<section class="content container-fluid">
					
				<!-- 상품등록 폼 -->
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">상품 상세</h3>
							</div>
							<!-- /.box-header -->
							
							<%-- 상품 상세 정보 출력 --%>
							<div class="box-body">
								<div class="form-group">
									<label for="InputCategory" style="width:40%; margin-right:20px;" >1차 카테고리</label>
									<label for="InputCategory" style="width:40%;" >2차 카테고리</label> <br />
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.cate_code_prt}</span>
									<span class="form-control" style="width:40%;  display:inline-block;">${vo.cate_code}</span>
									
								</div>
								<div class="form-group">
									<label for="InputProductName">상품명</label> 
									<span class="form-control" style="width: 81.5%;">${vo.pdt_name}</span>
								</div>
								<div class="form-group">
									<label for="InputCompany">제조사</label> 
									<span class="form-control" style="width: 81.5%;">${vo.pdt_company}</span>
								</div>
								<div class="form-group">
									<label for="InputPrice" style="width:40.5%; margin-right:10px;">판매가</label> 
									<label for="InputPrice" style="width:39.5%;">할인가</label> 
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.pdt_price}</span>
									<span class="form-control" style="width:40%; display:inline-block;">${vo.pdt_discount}</span>
								</div>
								<div class="form-group">
									<label for="InputDetail">상품 상세</label><br>
									<div class="content-img" contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
										${vo.pdt_content}
									</div>
								</div>
								<div class="form-group">
									<label for="InputThumbImg">썸네일(대표) 이미지 : <span style="font-weight: 500;">${vo.pdt_img}</span></label> 
								
									
									<div contenteditable="false" style="width:100%;border: 1px solid #d2d2d2; padding: 20px;">
										<img class="thum_origin_img" src="/admin/product/displayFile?fileName=${name}">
									</div>
										
									
								</div>
								<div class="form-group">
									<label for="InputAmount" style="width:40%; margin-right:10px;">수량</label> 
									<label for="InputBuy" style="width:40%;">구매 가능 여부</label><br /> 
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.pdt_amount}</span>
									<span class="form-control" style="width:40%; display:inline-block;">${vo.pdt_buy}</span>
								</div>
								<div class="form-group">
									<label for="RegDate" style="width:40%; margin-right:10px;">상품 등록일</label> 
									<label for="RegDate" style="width:40%;">최종 수정일</label> <br />
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">
										<fmt:formatDate value="${vo.pdt_date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<span class="form-control" style="width:40%; display: inline-block;">
										<fmt:formatDate value="${vo.pdt_date_up}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<!-- 
									<input type="text" id="pdt_date_up" name="pdt_date_up" class="form-control" 
										value="${vo.pdt_date_up}" readonly />
										 -->
								</div>
							</div>
							
							
							<!-- /.box-body -->

							<div class="box-footer">
								<div>
									
								</div>

								<ul class="mailbox-attachments clearfix uploadedList">
								</ul>

								<button id="btn_list" type="button" class="btn btn-primary" >상품 목록</button>
							</div>
						
						</div>
						<!-- /.box -->	
					</div>
					<!--/.col (left) -->
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