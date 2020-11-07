<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>admin login main</title>
	
	
<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/admin/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%-- <%@include file="/WEB-INF/views/common/bootjs.jsp"%> --%>


<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/member/util.css">
	<link rel="stylesheet" type="text/css" href="/css/admin/main.css">
<!--===============================================================================================-->
<script src="/bower_components/jquery/dist/jquery.min.js"></script>
<script src="/js/admin/loginMain.js"></script>

<script>
	if("${msg}"=="ADMIN_LOGIN_FAIL"){
		alert("로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 확인해주세요.");
		
	} else if("${msg}"=="ADMIN_LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다.");
		
	}
</script>

</head>

<body>
	
	<div class="limiter">
		<div class="container-login100" style="background-image: url('/img/img-01.jpg');">
			<div class="wrap-login100 p-t-190 p-b-30" style="padding-top:20px;">
				<form id="loginForm" action="/admin/main" method="post" class="login100-form validate-form">
					<div class="login100-form-avatar">
						<img src="/img/avatar-01.jpg" alt="AVATAR">
					</div>

					<span class="login100-form-title p-t-20 p-b-45">
						Prinha Admin Login
					</span>

					<div class="wrap-input100 validate-input m-b-10">
						<input class="input100" type="text" name="admin_id" id="admin_id" placeholder="Admin ID" value="admin">

					</div>

					<div class="wrap-input100 validate-input m-b-10">
						<input class="input100" type="password" name="admin_pw" id="admin_pw" placeholder="Admin Password" value="1111">
	
					</div>

					<div class="container-login100-form-btn p-t-10">
						<button class="login100-form-btn" type="button" id="btn_login">
							Login
						</button>
					</div>
					
					<%-- 
					<div class="text-center w-full p-t-25 p-b-230">
						<a href="#" class="txt1">
							Forgot Username / Password?
						</a>
					</div>
					--%>
				</form>
			</div>
		</div>
	</div>
	
	

	
<!--===============================================================================================-->	
	<script src="/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/vendor/bootstrap/js/popper.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/vendor/select2/select2.min.js"></script>


</body>
</html>