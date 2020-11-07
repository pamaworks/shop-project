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

<title>admin Q&A list</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>

<style>
label{
font-size: 14px; font-weight: 600; color: gray;}
ol,ul,li{list-style: none;}
</style>

<script>
	var result = '${msg}';

	if (result == 'DELETE') {
		alert("게시글이 삭제 처리되었습니다.");
	}
	
</script>

<script>



	
	$(document).ready(function() {

				$('#searchBtn').on(
						"click",
						function(event) {

							self.location = "list"
									+ '${pm.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + $('#keywordInput').val();

						});

			
	});
</script>
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
						Prinha Admin Page <small style="font-size: 13px;"> 고객 문의 </small>
					</h1>
				</section>


				<section class="content container-fluid">
					<div class="row">
					<div class="col-md-12">
					
					<div class="row text-center" style="margin-bottom: 20px;">
					<div class="search" style="display: inline-block; float: left; margin-left: 15px;">

							<select name="searchType" style="width: 180px; height: 26px;">
								<option value="n"
									<c:out value="${cri.searchType == null?'selected':''}"/>>
									검색 조건 선택</option>
								<option value="t"
									<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
									제목</option>
								<option value="c"
									<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
									내용</option>
								<option value="w"
									<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
									작성자</option>
								<option value="tc"
									<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
									제목&내용</option>
								<option value="cw"
									<c:out value="${cri.searchType eq 'tw'?'selected':''}"/>>
									제목&작성자</option>
								<option value="tcw"
									<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
									제목&내용&작성자</option>
							</select> <input type="text" name='keyword' id="keywordInput"
								value='${cri.keyword }'>
							
							<button id="searchBtn" class="btn btn-default" style="width: 50px;height: 26px;padding:3.5px 4px;">검색</button>
							
						</div>
						</div>
						
					
						<div class="box box-primary">
						
						<div class="box-body" style="text-align: center;">
							<table class="table table-bordered">
								<tr style="background-color: aliceblue; font-size: 14px; color: dimgray;">
									<th style="width: 15%;text-align: center;">No</th>
									<th style="width: 40%;text-align: center;">제목</th>
									<th style="width: 15%;text-align: center;">작성자</th>
									<th style="width: 15%;text-align: center;">작성일</th>
									<th style="width: 15%;text-align: center;">조회수</th>
								</tr>

								<c:forEach items="${list}" var="boardVO">

									<tr style="font-size: 13.5px; color: dimgray;">
										<td>${boardVO.bno}</td>
										<td><a style="color:#444444;"
											href='/admin/board/readPage${pm.makeSearch(pm.cri.page) }&bno=${boardVO.bno}'>
												${boardVO.board_title}
												<span style="font-size: 10px; color: orangered;">re:${boardVO.board_replycnt}</span>
											
										</a></td>
										
										
										<td>${boardVO.mem_id}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${boardVO.board_regdate}" /></td>
										<td><span>${boardVO.board_viewcnt}</span></td>
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