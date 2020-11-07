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

<title>login</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>


<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="/css/member/util.css">
<link rel="stylesheet" type="text/css" href="/css/member/main.css">
<!--===============================================================================================-->

<link href="/css/member/login.css" rel="stylesheet">

<script type="text/javascript" src="/js/member/login.js"></script>
<script>

if("${msg}"=="LOGIN_FAIL"){
		alert("로그인에 실패했습니다.\n아이디와 비밀번호를 확인해주세요.");
	} 

</script>
</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->


	<!-- 본문 들어가는 부분 -->
	<!--<div style="margin-top: 100px;" class="container"> 좌우측의 공간 확보 -->


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
			<div class="container-login100">
				<div class="wrap-login100">
					<div class="login100-form-title">
						<span class="login100-form-title-1"> LOGIN </span>
					</div>


					<form id="loginForm" class="login100-form validate-form"
						method="post" action="/member/login">
						<div class="wrap-input100 validate-input m-b-26">
							<span class="label-input100">UserID</span> <input id="mem_id"
								class="input100" type="text" name="mem_id" value="user01"> <span
								class="focus-input100"></span>
						</div>

						<div class="wrap-input100 validate-input m-b-18">
							<span class="label-input100">Password</span> <input id="mem_pw"
								class="input100" type="password" name="mem_pw" value="Qkdlfn12!"> <span
								class="focus-input100"></span>
						</div>


						<div class="checkbox" style="margin-top: 5px;text-align: left;display: inline-block;width: 50%;">
							<label class="txt1"> <input type="checkbox" id="isUseCookie" />
							<input type="hidden" name="isUseCookie" value="1">
								Remember me(쿠키 저장)
							</label>
						</div>


						<div class="flex-sb-m w-full p-b-30" style="width: 50%;display: inline-block;text-align: right;">


							<div>
								<a href="#" class="txt1"> Forgot Password? </a>
							</div>
						</div>

						<div class="container-login100-form-btn" style="width: 50%;">
							<button id="btn_submit" type="submit"
								class="login100-form-btn btn-primary">Login</button>
						</div>


						<div class="container-login100-form-btn" style="width: 50%;">
							<button id="btn_join" type="button"
								class="login100-form-btn btn-light" style="color: black;">
								Join Us</button>
						</div>


					</form>
				</div>
			</div>
		</div>
	</section>

	<!--// 본문  -->



	<!-- 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!--// 푸터 -->


	<!--===============================================================================================-->
	<script src="/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="/vendor/bootstrap/js/popper.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="/vendor/daterangepicker/moment.min.js"></script>
	<script src="/vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="/vendor/countdowntime/countdowntime.js"></script>



</body>
</html>