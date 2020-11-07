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

<title>MyPage</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>


<link href="/css/member/myPage.css" rel="stylesheet">
<script>
	/* 적립금
	var point = ${sessionScope.user.mem_point};
	*/
	
	$(function(){
		// 나의문의내역클릭시
		$('#btn-qna').on("click", function() {
			
			location.href = "/board/list?searchType=w&keyword=${sessionScope.user.mem_id}";
		});	
		
	});
	
</script>
<script src="/js/member/mypage.js"></script>


</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->


	<!-- 모달창 -->
	<div class="modal fade" id="defaultModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="height: 10px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" style="margin: -1.8rem -1rem -1rem auto;">×</button>

				</div>
				<div class="modal-body">
					<p class="modal-contents"></p>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!--// 모달창 -->


	<!-- 본문  -->
	<section>
		<div class="limiter" style="margin-top: 50px;">
			<div class="section-box">

				<div class="jumbotron">
					<h1 class="display-3">MY PAGE</h1>
					<p style="font-size: 13px;color: indianred;">
						<b>${sessionScope.user.mem_name}</b>님 (최근 접속 시간:
						<fmt:formatDate value="${sessionScope.user.mem_last_login}"
							pattern="yyyy-MM-dd HH:mm:ss" />
						)   /   <b>적립금 : </b><fmt:formatNumber value="${sessionScope.user.mem_point}" pattern="###,###,###" />원
					</p>
					<hr class="my-4">
					<p>
						<%-- <button id="btn-order-status" name="btn-order-status"
							type="button" class="btn btn-outline-secondary">
							<span class="button-en">ORDER STATUS</span><br>주문처리현황
						</button>--%>
						<button id="btn-order-list" name="btn-order-list" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">ORDER LIST</span><br>주문내역조회
						</button>
						<button id="btn-cart" name="btn-cart" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">CART</span><br>장바구니
						</button>
						<button id="btn-qna" name="btn-point" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">Q&A</span><br>나의문의내역
						</button>
						<br>
						<%--<button id="btn-my-board" name="btn-my-board" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">MY BOARD</span><br>게시물관리
						</button>--%>
						<button id="btn-profile" name="btn-profile" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">PROFILE</span><br>회원정보수정
						</button>
						<button id="btn-password" name="btn-password" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">PASSWORD</span><br>비밀번호변경
						</button>
						<button id="btn-withdrawal" name="btn-withdrawal" type="button"
							class="btn btn-outline-secondary">
							<span class="button-en">WITHDRAWAL</span><br>회원탈퇴
						</button>
					
					</p>

				</div>

			</div>
		</div>
	</section>

	<!--// 본문  -->




	<!-- 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!--// 푸터 -->


</body>
</html>