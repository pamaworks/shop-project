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

<title>modify</title>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<link href="/css/member/modify.css" rel="stylesheet">

<script type="text/javascript" src="/js/member/modify.js"></script>


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
	<section>
		<div style="margin-top: 100px;" class="container">
		
			<div class="form-box">

				<h2 style="text-align: center;font-size: 29px;font-weight: 600;">회원정보수정</h2>

				<hr />

				<form id="modifyForm" class="form-horizontal" role="form"
					method="post" action="/member/modify">

					<div class="form-group" id="divId">
						<label for="inputId" class="col-lg-2 control-label">아이디</label>
						<div class="col-lg-10">
							<input name="mem_id" type="text"
								class="form-control onlyAlphabetAndNumber" id="mem_id"
								data-rule-required="true"
								maxlength="30" value="${vo.mem_id}" readonly="readonly"
								style="margin-right: 10px; float: left;">
							
							<p id="id_availability"
								style="color: grey; display: none; font-size: 12px; margin: 3px; font-weight: 600;"></p>
						</div>
					</div>
				
					<div class="form-group" id="divName">
						<label for="inputName" class="col-lg-2 control-label">이름</label>
						<div class="col-lg-10">
							<input name="mem_name" type="text"
								class="form-control onlyHangul" id="name"
								data-rule-required="true" value="${vo.mem_name}"
								maxlength="15">
						</div>
					</div>

					<div class="form-group" id="divNickname">
						<label for="inputNickname" class="col-lg-2 control-label">닉네임</label>
						<div class="col-lg-10">
							<input name="mem_nick" type="text" class="form-control"
								id="nickname" data-rule-required="true" value="${vo.mem_nick}"
								maxlength="15">
						</div>
					</div>

					<div class="form-group" id="divEmail">
						<label for="inputEmail" class="col-lg-2 control-label">이메일</label>
						<div class="col-lg-10">
							<input name="mem_email" type="email" class="form-control"
								id="email" data-rule-required="true" value="${vo.mem_email}"
								maxlength="40"
								style="margin-right: 10px; width: 70%; float: left;">
							
							<input type="hidden" id="hidden_email" value="${vo.mem_email}">
							
							<button type="button" class="btn btn-secondary"
								id="btn_sendAuthCode">이메일 인증</button>
							<p id="authcode_status"
								style="color: grey; display: none; font-size: 12px; margin: 3px; font-weight: 600;"></p>
						</div>
					</div>

					<!-- 이메일 인증 요청을 하고 , 성공적으로 진행이 되면, 아래 div태그가 보여진다. -->
					<div class="form-group" id="divEmailAuthCode"
						style="display: none;">
						<label for="inputAuthCode" class="col-lg-2 control-label">*이메일
							인증코드</label>
						<div class="col-lg-10">
							<input type="text" class="form-control" id="mem_authcode"
								placeholder="이메일 인증코드를 입력해 주세요."
								style="margin-right: 10px; width: 70%; float: left; margin-bottom: 10px;" />
							<button id="btn_checkAuthCode" class="btn btn-secondary"
								type="button">확인</button>
						</div>
					</div>


					<div class="form-group" id="divPhoneNumber">
						<label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰
							번호</label>
						<div class="col-lg-10">
							<input name="mem_phone" type="tel"
								class="form-control onlyNumber" id="phoneNumber"
								data-rule-required="true" value="${vo.mem_phone}"
								maxlength="11">
						</div>
					</div>

					<div class="form-group" id="divAddr">
						<label for="inputAddr" class="col-lg-2 control-label"
							style="padding-bottom: 22px;">주소</label> <br />
						<div class="col-lg-10" style="margin-top: -22px;">
							<input type="text" id="sample2_postcode" name="mem_zipcode"
								class="form-control" value="${vo.mem_zipcode}" readonly
								style="margin-right: 10px; width: 70%; float: left; margin-bottom: 10px;">
							<input type="button" onclick="sample2_execDaumPostcode()"
								id="btn_postCode" class="btn btn-secondary" value="우편번호 찾기">
							<input type="text" id="sample2_address" name="mem_addr"
								class="form-control" value="${vo.mem_addr}" readonly
								style="margin-bottom: 10px;"> 
								<input type="text"
								id="sample2_detailAddress" name="mem_addr_d"
								class="form-control" value="${vo.mem_addr_d}"> 
								<input
								type="hidden" id="sample2_extraAddress" class="form-control"
								placeholder="참고항목">
						</div>
					</div>


					<!-- Daum 우편번호 API -->
					<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
					<div id="layer"
						style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
							id="btnCloseLayer"
							style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
							onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
					<!-- // Daum 우편번호 API  -->
					
					
					<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script type="text/javascript" src="/js/postCode.js"></script>
					
					
					<hr style="clear: both;">

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button id="btn_submit" type="button" class="btn btn-primary">수정</button>
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