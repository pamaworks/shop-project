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

<title>prinha shoppingmall project</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>


<script>

if("${msg}" == "REGISTER_SUCCESS"){
	alert("회원가입이 완료되었습니다.\n로그인해주세요.");
}else if("${msg}" == "LOGIN_SUCCESS"){
	alert("로그인 되었습니다. \n환영합니다!");
}else if("${msg}" == "LOGIN_FAIL"){
	alert("로그인에 실패하였습니다. \n다시 시도해주세요.");
}else if("${msg}" == "LOGOUT_SUCCESS"){
	//alert("로그아웃되었습니다.");
}else if("${msg}" == "CHECK_PW_FAIL"){
	//alert("비밀번호 재확인 실패");
}else if("${msg}" == "MODIFY_SUCCESS"){
	alert("회원정보가 수정되었습니다.");
}else if("${msg}"=="CHANGE_PW_SUCCESS"){
		alert("비밀번호가 성공적으로 변경되었습니다.");
}  else if("${msg}"=="DELETE_USER_SUCCESS"){
		alert("회원 탈퇴되었습니다. 감사합니다.");
} 
 

</script>
</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!-- // 헤더 -->



	<!-- 본문 -->
	<section id="hero">
		<div class="hero-container">
			<div id="heroCarousel" class="carousel slide carousel-fade"
				data-ride="carousel">

				<ol class="carousel-indicators" id="hero-carousel-indicators"></ol>

				<div class="carousel-inner" role="listbox">

					<!-- Slide 1 -->
					<div class="carousel-item active">

						<div class="carousel-background">
							<a href=""><img class="carousel-background-img"
								src="img/main_slide1.jpg" alt="slide_img" style="width: 100%;"></a>
						</div>


					</div>

					<!-- Slide 2 -->
					<div class="carousel-item">
						<div class="carousel-background">
							<a href=""><img class="carousel-background-img"
								src="img/main_slide2.jpg" alt="slide_img" style="width: 100%;"></a>
						</div>
						<div class="carousel-container"></div>
					</div>

					<!-- Slide 3 -->
					<div class="carousel-item">
						<div class="carousel-background">
							<a href=""><img class="carousel-background-img"
								src="img/main_slide3.jpg" alt="slide_img" style="width: 100%;"></a>
						</div>
						<div class="carousel-container"></div>
					</div>

				</div>

				<a class="carousel-control-prev" href="#heroCarousel" role="button"
					data-slide="prev"> <span
					class="carousel-control-prev-icon icofont-thin-double-left"
					aria-hidden="true"></span> <span class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#heroCarousel" role="button"
					data-slide="next"> <span
					class="carousel-control-next-icon icofont-thin-double-right"
					aria-hidden="true"></span> <span class="sr-only">Next</span>
				</a>

			</div>
		</div>

		<!-- 인스타그램 연동 -->
		<p class="insta_p"
			style="width: 200px; margin: 20px auto; text-align: center; font-size: 11px; margin-top: 50px;">
			<a href="https://www.instagram.com/prinhashop/" style="color: gray;">I
				N S T A G R A M @ P R I N H A</a>
		</p>
		<%@include file="/WEB-INF/views/common/insta.jsp"%>

		<!-- // 인스타그램 연동 -->


	</section>
	<!-- // 본문 -->


	<!-- // 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!-- 푸터 -->


</body>

</html>
