<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>admin product list</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>




<script>

$(document).ready(function(){
	
// 검색 버튼 클릭 시 
$("#btn_search").on("click", function(){
	if($('#keyword').val()==null || $('#keyword').val()==""){
		alert("검색어를 입력해주세요.");
		$('#keyword').focus();
		return false;
	}else{
	self.location = "list"
		+ '${pm.makeQuery(1)}'
		+ "&searchType="
		+ $("select option:selected").val()
		+ "&keyword=" + $('#keyword').val();
	}
});


// 선택 상품 수정 버튼 클릭 시 
$("#btn_check_edit").on("click", function(){

	// 체크여부 유효성 검사
	if($("input[name='check']:checked").length==0){
		alert("수정할 상품을 선택해주세요.");
		return;
	}
	
	var checkArr = [];
	var amountArr = [];
	var buyArr = [];
	
	//var pdt_amount = $("#pdt_amount").val();
	//var pdt_buy = $("#pdt_buy:selected").val();
	
	// 체크 된 상품의 value(pdt_num)을 가져옴
	$("input[name='check']:checked").each(function(i){
		var pdt_num = $(this).val();
		var pdt_amount = $("input[name='amount_"+pdt_num+"']").val();
		var pdt_buy = $("select[name='buy_"+pdt_num+"']").val();
		
		
		checkArr.push(pdt_num);			
		amountArr.push(pdt_amount);			
		buyArr.push(pdt_buy);
		
	});
	
	$.ajax({
		url: '/admin/product/editChecked',
		type: 'post',
		dataType: 'text',
		data: {
				checkArr : checkArr,
				amountArr : amountArr,
				buyArr : buyArr
			   },
		success : function(data) {
			alert("수정이 완료되었습니다.");
			location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
		}

	});
});



// 선택 상품 삭제 버튼 클릭 시
$("#btn_check_delete").on("click", function(){

	// 체크여부 유효성 검사
	if($("input[name='check']:checked").length==0){
		alert("삭제할 상품을 선택해주세요.");
		return;
	}

	// 체크 된 상품이 존재할 경우 진행
	var result = confirm("선택한 상품을 삭제하시겠습니까?");
	if(result){
		
		var checkArr = [];
		var imgArr = [];
		
		// 체크 된 상품의 value(pdt_num)을 가져옴
		$("input[name='check']:checked").each(function(i){
			var pdt_num = $(this).val();
			var pdt_img = $("input[name='img_"+pdt_num+"']").val();
			
			checkArr.push(pdt_num);
			imgArr.push(pdt_img);
		});
		
		$.ajax({
			url: '/admin/product/deleteChecked',
			type: 'post',
			dataType: 'text',
			data: {
					checkArr : checkArr,
					imgArr : imgArr
				   },
			success : function(data) {
				alert("삭제가 완료되었습니다.");
				location.href = "/admin/product/list${pm.makeSearch(pm.cri.page)}";
			}
		});
	} else{}
});


});


// 상품 수정 버튼 클릭 시 
var clickEdit = function(pdt_num){
	var url = '/admin/product/edit${pm.makeSearch(pm.cri.page)}&pdt_num=' + pdt_num;
	location.href= url;
};
</script>


<%-- 메시지 처리 --%>
<script>
	
	if("${msg}" == "INSERT_SUCCESS"){// 상품 등록
		alert("상품 등록이 완료되었습니다.");
	} else if ("${msg}" == "EDIT_SUCCESS") {// 상품 수정
		alert("상품 수정이 완료되었습니다.");
		
	} else if ("${msg}" == "DELETE_SUCCESS") {// 상품 삭제
		alert("상품 삭제가 완료되었습니다.");
	}
		
</script>


<!-- 상품 리스트 js -->
<script type="text/javascript" src="/js/admin/product/list.js" charset="UTF-8"></script>

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
						Prinha Admin Page <small style="font-size: 13px;"> 상품 목록 </small>
					</h1>
				</section>


				<section class="content container-fluid">
					<div class="row">
					<div class="col-md-12">
					
					
					
						
						<%-- 검색 / 클릭 버튼 --%>
						<div class="row text-center">
							
							<%-- 검색 조건 / 페이지 이동에도 해당 값 유지하기 --%>
							<div class="search" style="display: inline-block; float: left; margin-left: 15px;">
								<%-- 검색 조건 : 상품명, 내용, 제조사, 상품명+내용, 상품명+제조사, 상품명+내용+제조사 --%>
								<select name="searchType" style="width: 180px; height: 26px;">
									<option value="null" <c:out value="${cri.searchType == null ? 'selected' : ''}" />>검색 조건 선택</option>
									<option value="name" <c:out value="${cri.searchType eq 'name' ? 'selected' : ''}" />>상품명</option>
									<option value="content" <c:out value="${cri.searchType eq 'content' ? 'selected' : ''}" />>내용</option>
									<option value="company" <c:out value="${cri.searchType eq 'company' ? 'selected' : ''}" />>제조사</option>
									<option value="name_content" <c:out value="${cri.searchType eq 'name_content' ? 'selected' : ''}" />>상품명+내용</option>
									<option value="name_company" <c:out value="${cri.searchType eq 'name_company' ? 'selected' : ''}" />>상품명+제조사</option>
									<option value="all" <c:out value="${cri.searchType eq 'all' ? 'selected' : ''}" />>상품명+내용+제조사</option>
									
								</select>
								
								<input type="text" name="keyword" id="keyword" value="${cri.keyword}" />
								<button id="btn_search" class="btn btn-default" style="width: 50px;height: 26px;padding:3.5px 4px;">검색</button>
							</div>	
						
							
							<%-- 이동 버튼 --%>
							<div class="quickButton" style="display: inline-block; float: right; margin-right: 15px;">
								<button id="btn_check_edit" class="btn btn-default">선택 상품 수정</button>
								<button id="btn_check_delete" class="btn btn-default">선택 상품 삭제</button>
								<button id="btn_insert" class="btn btn-primary">상품 등록</button>
							</div>
					
						</div>
					
					
						<br>
					
					
						<%-- 상품 리스트 / 페이징 --%>
						<div class="box box-primary">
						
							<%-- 상품 리스트 --%>
							<div class="box-body">
							<table class="table table-striped text-center">
							
								<%-- default 정보 행 --%>
								<tr>
									<th><input type="checkbox" id="checkAll" /></th>
									<th>상품 번호</th>
									<th>대표 이미지</th>
									<th>상품명</th>
									<th>판매가</th>
									<th>할인가</th>
									<th>제조사</th>
									<th>수량</th>
									<th>판매 여부</th>
									<th>수정 / 삭제</th>
								</tr>
							
							
								<%-- 1) 상품 리스트 출력 : 상품이 없을 때 --%>
	
								<c:if test="${empty productList}">
									<tr>
										<td colspan="10">
													
											<p style="padding: 50px 0px;text-align: center;">등록된 상품이 존재하지 않습니다.</p>
												
										</td>
									</tr>
								</c:if>
								
								
								
								<%-- 2) 상품 리스트 출력 : 상품이 존재 --%>
								<c:forEach items="${productList}" var="productVO">
									<tr>
										<%-- 각 컬럼 --%>
									
											<td><input type="checkbox" name="check" class="check" value="${productVO.pdt_num}" style=""></td>
											<td class="col-md-1">${productVO.pdt_num}</td>
											
											<td class="col-md-2">
												<a href="/admin/product/read${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}" 
												style="color: black;"><img src="/admin/product/displayFile?fileName=${productVO.pdt_img}" style="width: 80px;"> </a>
												<input type="hidden" name="img_${productVO.pdt_num}" value="${productVO.pdt_img}" />
											</td>
												
											<td class="col-md-2">
												<a href="/admin/product/read${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}" 
												style="color: black;"> ${productVO.pdt_name} </a>
											</td>
											
											<td class="col-md-1">${productVO.pdt_price}</td>
											<td class="col-md-1">${productVO.pdt_discount}</td>
											<td class="col-md-2">${productVO.pdt_company}</td>

											
											<td>
												<input name="amount_${productVO.pdt_num}"
												type="number"
												style="width: 80px; height: 34px; padding-left: 5px;"
												value="${productVO.pdt_amount}" />
											</td>
											
											<td>
												<select class="form-control" name="buy_${productVO.pdt_num}" style="width: 60px; display: inline-block;">
													<option <c:out value="${productVO.pdt_buy == 'Y'?'selected':''}"/>>Y</option>
													<option <c:out value="${productVO.pdt_buy == 'N'?'selected':''}"/>>N</option>
												</select>
											</td>									
									
									
									
										<%-- 상품 수정/삭제 버튼 --%>
										<td class="col-md-2">
											<%-- 삭제 폼 (수정은 onclick) --%>
											<form class="deleteForm" method="post" action="/admin/product/delete${pm.makeSearch(pm.cri.page)}">
												<%-- 상품 코드 --%>
												<input type="hidden" name="pdt_num" value="${productVO.pdt_num}">
												<%-- 파일 이미지명 --%>
												<input type="hidden" name="pdt_img" value="${productVO.pdt_img}">
												
												<%-- 수정기능 -> 미리 정의 해놓은 onclick 함수 호출 --%>
												<button type="button" name="btn_edit" class="btn btn-default" onclick="clickEdit(${productVO.pdt_num});">수정</button>
												
												<%-- 삭제기능 -> 폼전송 --%>
												<button type="button" name="btn_delete" class="btn btn-danger">삭제</button>
											</form>
										</td>
									</tr>
								</c:forEach>
							
							
							</table>
							</div>
						
							
							<%-- 페이징 기능 --%>
							<div class="box-footer">
								<div class="text-center">
									<ul class="pagination">
									
									
										<%-- 이전표시 여부  [이전] --%>
										<c:if test="${pm.prev}">
											<li><a href="list${pm.makeSearch(pm.startPage-1)}">&laquo;</a>
											</li>
										</c:if>
										
										
										<%-- 페이지목록번호 :  1  2  3  4  5  --%>
										<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
											var="idx">
											<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
												<a href="list${pm.makeSearch(idx)}">${idx}</a>
											</li>
										</c:forEach>
										
										
										<%-- 다음표시 여부  [다음]--%>
										<c:if test="${pm.next && pm.endPage > 0}">
											<li><a href="list${pm.makeSearch(pm.endPage +1)}">&raquo;</a>
											</li>
										</c:if>

									</ul>
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