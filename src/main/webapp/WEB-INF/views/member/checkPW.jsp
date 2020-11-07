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

<title>Check Password</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<link href="/css/member/checkPW.css" rel="stylesheet">

<script>
	// 비밀번호를 틀렸을 때
	if("${msg}" == "CHECK_PW_FAIL"){
		alert("비밀번호가 틀렸습니다. 다시 확인해주세요.");
	}
</script>

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
	
	
	
<script>
var modalContents = $(".modal-contents");
var modal = $("#defaultModal");

$(document).ready(function(){
	
	// 확인 버튼 눌렀을 때
	$("#btn-check").on("click", function(){
		
		if($("#mem_pw").val()== null || $("#mem_pw").val()==""){
			modalContents.text("비밀번호를 입력해주세요.");
			modal.modal('show');
			$('#mem_pw').focus();
			return false;
		} else {
			$("#checkPWForm").submit();
		}
	});
	
	
	// 취소 버튼 눌렀을 때
	$('#btn-cancle').on("click",function(){
		var result = confirm("취소하시겠습니까?")	;
		location.href="/member/myPage";
	});
	
	
});
</script>



	<!-- 본문  -->
	<section>
		<div class="limiter" style="margin-top: 50px;">
			<div class="section-box">
				<div class="jumbotron">
					<h1 class="display-3" style="font-size: 29px;">비밀번호 확인</h1>
					<hr class="my-4">
					
					
					<form id="checkPWForm" method="post" action="checkPW">
					<div class="form-group">
					
						<%-- 1) 회원정보수정 : modify
							 2) 비밀번호변경 : changePW
							 3) 회원탈퇴 : withdrawal
						 --%>
						 
						 <%-- url 숨겨놓기 --%>
						 <input type="hidden" name="url" value="${url}" />
						 <input type="password" id="mem_pw" name="mem_pw" placeholder="비밀번호를 입력하세요." />
					
						<br>
						<button id="btn-check" name="btn-check"
							type="button" class="btn btn-primary">
							<span class="button-en">확인</span>
						</button>
						<button id="btn-cancle" name="btn-cancle" type="button"
							class="btn btn-light">
							<span class="button-en" style="color: black;">취소</span>
						</button>

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


</body>
</html>