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

<title>change password</title>


<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<link href="/css/member/changePW.css" rel="stylesheet">

<script type="text/javascript" src="/js/member/changePW.js"></script>

</head>
<body>


	<!-- 헤더  -->
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




	<!-- 본문 -->
	<section style="width: 100%;min-height: 450px;">
		<div style="margin-top: 220px;" class="container">
		
			<div class="form-box">

				<h2 style="text-align: center;font-size: 29px;font-weight: 600;">비밀번호변경</h2>

				<hr />

				<form id="changePWForm" class="form-horizontal" role="form"
					method="post" action="/member/changePW">

					<div class="form-group" id="divId">
						<label for="inputId" class="col-lg-2 control-label">아이디</label>
						<div class="col-lg-10">
							<input name="mem_id" type="text"
								class="form-control onlyAlphabetAndNumber" id="mem_id"
								data-rule-required="true"
								maxlength="30" value="${sessionScope.user.mem_id}" readonly="readonly"
								style="margin-right: 10px; float: left;">
							
							<p id="id_availability"
								style="color: grey; display: none; font-size: 12px; margin: 3px; font-weight: 600;"></p>
						</div>
					</div>
					
					
					<div class="form-group" id="divPassword">
						<label for="inputPassword" class="col-lg-2 control-label">변경할 비밀번호</label>
						<div class="col-lg-10">
							<input name="mem_pw" type="password" class="form-control"
								id="password" name="excludeHangul" data-rule-required="true"
								placeholder="영문 대소문자,숫자,특수문자를 하나 이상씩 포함하여 8~16자 이내로 입력하세요."
								maxlength="30">
						</div>
					</div>
					<div class="form-group" id="divPasswordCheck">
						<label for="inputPasswordCheck" class="col-lg-2 control-label">비밀번호
							확인</label>
						<div class="col-lg-10">
							<input name="mem_pw_check" type="password" class="form-control"
								id="passwordCheck" data-rule-required="true"
								placeholder="비밀번호 확인" maxlength="30">
						</div>
					</div>
					
					<hr style="clear: both;">

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button id="btn_submit" type="button" class="btn btn-primary">비밀번호변경</button>
							<button id="btn_cancle" type="button" class="btn btn-light">취소</button>
						</div>
					</div>
				</form>
			</div>
			
			<br>
			<br>

		</div>
	</section>
	<!--// 본문 -->


	<!-- 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!--// 푸터 -->


</body>
</html>