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

<title>admin product insert</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>



<!-- CK Editor -->
<script src="/ckeditor/ckeditor.js"></script>

<!-- Handlebar -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<!-- 카테고리 핸들바 템플릿 -->
<script id="subCGListTemplate" type="text/x-handlebars-template">
	<option value="default">2차 카테고리  선택</option>
	{{#each .}}
	<option value="{{cate_code}}">{{cate_name}} </option>
	{{/each}}
</script>


<!-- ckEditor / 2차 카테고리 처리 이벤트 -->
<script>
	$(document).ready(function(){
		/* ckEditor 작업 */
		// config.js를 사용하지 않고 개별 설정하는 부분
		var ckeditor_config = {
				resize_enabled : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				toolbarCanCollapse : true,
				removePlugins : "elementspath",
				// 파일 업로드 기능 추가
				// CKEditor를 이용해 업로드 사용 시 해당 주소에 업로드 됨
				filebrowserUploadUrl: '/admin/product/imgUpload'
		};
		
		
		CKEDITOR.replace("pdt_content", ckeditor_config);
		// config.js의 설정을 사용하려면, 다음과 같이 사용
		// CKEDITOR.replace("desc", "");

		
		// 1차 카테고리에 따른 2차 카테고리 작업
		$('#cate_code_prt').on("change",function(){
			
			var mainCGCode = $(this).val(); // 선택한 1차 카테고리 코드
			
			// url 매핑주소를 경로형태로 사용  @PathVariable
			var url = "/admin/product/subCGList/"+mainCGCode; 
			
			
			// 2차 카테고리에 해당하는 데이터를 getJson형태로 받아옴
			// REST 방식으로 전송
			$.getJSON(url, function(data){ // data : 2차 카테고리 데이터
				
				// 받은 데이터를 2차 카테고리 템플릿에 적용
				subCGList(data, $('#cate_code'), $('#subCGListTemplate'))
			});
		});
		
		});

</script>


<!-- 2차 카테고리 템플릿 적용 함수 -->
<script>
	var subCGList = function(subCGStr, target, templateObject){
		
		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr); // 템플릿에 2차 카테고리 데이터가 바인딩
		
		// 기존 option 제거(누적방지)
		$('#cate_code option').remove();
		target.append(options);
	}


	
</script>



<!-- 상품 등록 유효성 검사 -->
<script src="/js/admin/product/insert.js"></script>

</head>



<body class="hold-transition skin-blue sidebar-mini">


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
						Prinha Admin Page <small style="font-size: 13px;"> 상품 등록 </small>
					</h1>
				</section>


				<section class="content container-fluid">

					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">상품 등록</h3>
						</div>
						<!-- /.box-header -->
						<!-- form start -->
						<!-- enctype="multipart/form-data" -->
						<form id="registerForm" role="form" action="/admin/product/insert" method="post" enctype="multipart/form-data">
							<div class="box-body">
							
								<!-- 카테고리 선택 -->
								<div class="form-group">
									<label for="InputCategory" style="width:30%; margin-right:20px;" >1차 카테고리</label>
									<label for="InputCategory" style="width:30%;" >2차 카테고리</label> <br />
									
									<select class="form-control" id="cate_code_prt" name="cate_code_prt" style="width:30%; margin-right:10px; display: inline-block;" >
										 <option value="default">1차 카테고리 선택</option>
										 <%-- 4) 상품 등록GET 부분  model --%>
										  <c:forEach items="${cateList}" var="vo">
										  	<option value="${vo.cate_code}">${vo.cate_name}</option>
										  </c:forEach>
									</select>
									<select class="form-control" id="cate_code" name="cate_code" style="width: 30%; display: inline-block;">
										 <option value="default">2차 카테고리 선택</option>
									</select>
								</div>
							
							
									<div class="form-group">
										<label for="InputProductName">상품명</label> <input
											type="text" id="pdt_name" name="pdt_name" class="form-control"
											placeholder="상품명을 입력해주세요." style="width:81.5%;">
									</div>
									
									<div class="form-group">
										<label for="InputCompany">제조사</label> <input
											type="text" id="pdt_company" name="pdt_company" class="form-control"
											placeholder="제조사를 입력해주세요." style="width:81.5%;">
									</div>
									
									<div class="form-group">
										<label for="InputPrice" style="width:40.5%; margin-right:10px;">판매가</label> 
										<label for="InputPrice" style="width:39.5%;">할인가</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_price" name="pdt_price" class="form-control onlyNumber" 
											placeholder="₩" />
										<input style="width:40%; display: inline-block;"
											type="text" id="pdt_discount" name="pdt_discount" class="form-control onlyNumber"
											placeholder="₩" />
									</div>
						
									<div class="form-group">
								 		<label for="InputDetail">상품 상세</label>
                   						 <textarea class="form-control" id="pdt_content" 
                   						 name="pdt_content" rows="10" cols="80"></textarea>
              						
									</div>

									<div class="form-group">
										<label for="InputThumbImg">썸네일(대표) 이미지</label> <input
											type="file" id="file1" name="file1" class="form-control" style="width: 81.5%;"/>
									</div>
									
									<div class="form-group">
										<label for="InputAmount" style="width:30%; margin-right:10px;">수량</label> 
										<label for="InputBuy" style="width:15%;">구매 가능 여부</label><br /> 
										<input style="width:30%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_amount" name='pdt_amount' class="form-control onlyNumber" 
											 />
										<select class="form-control" id="pdt_buy" name="pdt_buy" style="width: 15%; display: inline-block;">
										  <option>Y</option>
										  <option>N</option>
										</select>
									</div>								
			
							</div>
							<!-- /.box-body -->

							<div class="box-footer">
								<button id="btn_submit" type="button" class="btn btn-primary">상품 등록</button>

							</div>
						</form>
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