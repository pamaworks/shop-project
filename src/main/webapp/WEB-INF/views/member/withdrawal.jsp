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

<title>withdrawal</title>


<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<link href="/css/member/withdrawal.css" rel="stylesheet">

<script type="text/javascript" src="/js/member/withdrawal.js"></script>

</head>
<body>


	<!-- 헤더  -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->



	<!-- 본문 -->
	<section style="width: 100%;min-height: 450px;">
		<div style="margin-top: 220px;" class="container">
		
			<div class="form-box">

				<h2 style="text-align: center;font-size: 29px;font-weight: 600;">회원탈퇴</h2>

				<hr />

				<form id="withdrawalForm" class="form-horizontal" role="form"
					method="post" action="/member/withdrawal">

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
	
					
					<hr style="clear: both;">

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button id="btn_submit" type="button" class="btn btn-primary">회원탈퇴</button>
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