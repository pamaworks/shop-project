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

<title>Q&A list</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/member/pager.css">
<script>
	var result = '${msg}';

	if (result == 'DELETE') {
		alert("게시물이 삭제 처리되었습니다.");
	}else if(result == 'REGSUCCESS'){
		alert("게시물 등록이 완료되었습니다.")
	}else if(result == 'MODIFYSUCCESS'){
		alert("게시물 수정이 완료되었습니다.");
	}
</script>

<script>



	
	$(document).ready(function() {

				$('#searchBtn').on(
						"click",
						function(event) {

							self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + $('#keywordInput').val();

						});

				$('#newBtn').on("click", function(evt) {

					self.location = "register";

				});

				$('#newBtn_logout').on("click",function(){
					
					alert("로그인한 사용자만 이용할 수 있습니다.");
					location.href="/member/login";
				});
				
				
				/*if($('span[name=badge_re]').innerHTML==null || $('span[name=badge_re]').innerHTML=='0'){
					$('#badge_re').hide();
				}*/
				
				
	});
</script>
<style>

element.style {
}
.list-group-item>.badge {
    float: right;
}
.badge {
    display: inline-block;
    min-width: 10px;
    padding: 3px 7px;
    font-size: 10px;
    font-weight: 700;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 10px;
}
</style>
</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->



	<!-- 본문  -->
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper"
		style="margin-top: 100px; min-height: 560px;">

		<%-- MAIN CONTENT --%>
		<section class="content container-fluid">

			<%-- 상품 상세 --%>
			<div style="width: 100%; background-color: white;"
				class="container text-center">

				<!-- left column -->
				<div class="col-md-12">
					<!-- general form elements -->
					<div class="box box-primary" style="margin-bottom: 22px;">

						<div class="box-header">

							<h3 class="box-title">Q&A LIST</h3>
						</div>
						<!-- /.box-header -->

						<hr style="margin-bottom: 75px;">

						<div class='box-body'>

							<select name="searchType" style="background-color: white; width: 130px; height: 29.5px; font-size: 13.5px;">
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
							<button type="button" class="btn btn-secondary" id='searchBtn' style="font-size: 12.5px; width: 60px; height: 32px; margin-bottom: 4px; padding-top: 5.5px;background-color: lightgray; color: white; border-color: lightgray;">검색</button>
							
							<%-- 로그인한 사용자만 등록가능 --%>
							<c:if test="${sessionScope.user!=null}">
							<button type="button" class="btn btn-secondary" id='newBtn' style="height: 31px;font-size: 12.5px;margin-bottom: 5px;padding-top: 5.5px;">Q&A 등록하기</button>
							</c:if>
							
							<%-- 로그아웃 --%>
							<c:if test="${sessionScope.user==null}">
							<button type="button" class="btn btn-secondary" id='newBtn_logout' style="height: 31px;font-size: 12.5px;margin-bottom: 5px;padding-top: 5.5px;">Q&A 등록하기</button>
							</c:if>
							
							
							
						</div>

					</div>
					<!-- /.box -->

					<div class="box">
						
						<div class="box-body">
							<table class="table table-bordered">
								<tr style="background-color: aliceblue; font-size: 14px; color: dimgray;">
									<th style="width: 10px;">No</th>
									<th >제목</th>
									<th style="width: 200px">작성자</th>
									<th style="width: 130px;">작성일</th>
									<th style="width: 75px;">조회수</th>
								</tr>

								<c:forEach items="${list}" var="boardVO">

									<tr style="font-size: 13.5px; color: dimgray;">
										<td>${boardVO.bno}</td>
										<td><a style="color:#444444;"
											href='/board/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${boardVO.bno}'>
												${boardVO.board_title}
												<span style="font-size: 10px; color: orangered;">re:${boardVO.board_replycnt}</span>
											
										</a></td>
										
										
										<td>${boardVO.mem_id}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${boardVO.board_regdate}" /></td>
										<td><span class="bg-red">${boardVO.board_viewcnt}</span></td>
									</tr>

								</c:forEach>

							</table>
						</div>

						<div class="box-footer container">

							<div class="text-center">
								<ul class="pagination">

									<c:if test="${pageMaker.prev}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
									</c:if>

									<c:forEach begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }" var="idx">
										<li
											<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
											<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
										</li>
									</c:forEach>

									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
									</c:if>

								</ul>
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