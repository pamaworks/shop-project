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

<title>admin product edit</title>

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
		
		
		//상품 목록 버튼 클릭시
		$("#btn_list").on("click", function(){
			var result = confirm("내용을 저장하지 않고, 목록으로 돌아가시겠습니까?");
			
			if(result){
				location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
			} else {}
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

<!-- 파일 변경 이벤트 메소드 -->
<script>
var fileChange = function(fis) {
	var str = fis.value;
	$("#fileName").html("파일이 변경되었습니다.");
}

</script>


<!-- 상품 수정 유효성 검사 -->
<script src="/js/admin/product/productEdit.js"></script>

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
						Prinha Admin Page <small style="font-size: 13px;"> 상품 수정 </small>
					</h1>
				</section>


				<section class="content container-fluid">

					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">상품 수정</h3>
						</div>
						<!-- /.box-header -->
						<!-- form start -->
						<!-- enctype="multipart/form-data" -->
						<form id="editForm" role="form" action="/admin/product/edit" method="post" enctype="multipart/form-data">
							<div class="box-body">
								 
									<div class="form-group">
										<input type="hidden" name="page" value="${cri.page}" />
										<input type="hidden" name="perPageNum" value="${cri.perPageNum}" />
										<input type="hidden" name="searchType" value="${cri.searchType}" />
										<input type="hidden" name="keyword" value="${cri.keyword}" />
									</div>
									
									<div class="form-group">
										<input name="pdt_num" type="hidden" value="${vo.pdt_num}" />
										<label for="InputCategory" style="width:40%; margin-right:20px;" >1차 카테고리</label>
										<label for="InputCategory" style="width:40%;" >2차 카테고리</label> <br />
										<select class="form-control" id="cate_code_prt" name="cate_code_prt" style="width:40%; margin-right:10px; display: inline-block;" >
											<option value="default">1차 카테고리 선택</option>
											<c:forEach items="${cateList}" var="list">
												<option value="${list.cate_code}"<c:out value="${vo.cate_code_prt == list.cate_code?'selected':''}"/>>${list.cate_name}</option>
											</c:forEach>
										</select>
										<select class="form-control" id="cate_code" name="cate_code" style="width: 40%; display: inline-block;">
										 	<option value="default">2차 카테고리 선택</option>
										 	<c:forEach items="${subCateList}" var="subList">
										  		<option value="${subList.cate_code}"<c:out value="${vo.cate_code == subList.cate_code?'selected':''}"/>>${subList.cate_name}</option>
										 	</c:forEach>
										</select>
									</div>
									<div class="form-group">
										<label for="InputProductName">상품명</label> <input
											type="text" id="pdt_name" name="pdt_name" class="form-control"
											value="${vo.pdt_name}" style="width: 81.5%;">
									</div>
									<div class="form-group">
										<label for="InputCompany">제조사</label> <input
											type="text" id="pdt_company" name="pdt_company" class="form-control"
											value="${vo.pdt_company}" style="width: 81.5%;">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:40.5%; margin-right:10px;">판매가</label> 
										<label for="exampleInputEmail1" style="width:39.5%;">할인가</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_price" name="pdt_price" class="form-control" 
											value="${vo.pdt_price}" />
										<input style="width:40%; display: inline-block;"
											type="text" id="pdt_discount" name="pdt_discount" class="form-control "
											value="${vo.pdt_discount}" />
									</div>
									<div class="form-group">
										<label for="InputDetail">상품 상세</label>
										<textarea class="form-control" id="pdt_content" name="pdt_content" rows="8">
											${vo.pdt_content}</textarea>
									</div>
									<div class="form-group">
										<input type="hidden" name="pdt_img" value="${vo.pdt_img}" />	
										<label for="InputThumbImg">썸네일(대표) 이미지</label> 
										<span id="fileName" style="margin-left:5px; font-weight: 500;">현재 등록된 파일: <c:out value="${originFile}" /></span>
										<input onchange="fileChange(this)"
											type="file" id="file1" name="file1" class="form-control" />
											
											
											
									</div>
									<div class="form-group">
										<label for="InputAmount" style="width:40%; margin-right:10px;">수량</label> 
										<label for="InputBuy" style="width:40%;">구매 가능 여부</label><br /> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_amount" name='pdt_amount' class="form-control" 
											value="${vo.pdt_amount}" />
										<select class="form-control" id="pdt_buy" name="pdt_buy" style="width: 45%; display: inline-block;">
										  <option 
										  	<c:out value="${vo.pdt_buy == 'Y'?'selected':''}"/>>Y</option>
										  <option
										  	<c:out value="${vo.pdt_buy == 'N'?'selected':''}"/>>N</option>
										</select>
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
								<button id="btn_submit" type="button" class="btn btn-primary" >상품수정</button>
								<button id="btn_list" type="button" class="btn btn-default" >취소</button>
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