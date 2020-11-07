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

<title>join</title>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<link href="/css/member/join.css" rel="stylesheet">

<script type="text/javascript" src="/js/member/join.js"></script>


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

				<h2 style="text-align: center;">JOIN</h2>

				<hr />

				<form id="joinForm" class="form-horizontal" role="form"
					method="post" action="/member/join">

					<div class="form-group" id="divId">
						<label for="inputId" class="col-lg-2 control-label">아이디</label>
						<div class="col-lg-10">
							<input name="mem_id" type="text"
								class="form-control onlyAlphabetAndNumber" id="mem_id"
								data-rule-required="true"
								placeholder="30자이내의 영문,숫자,_만 입력 가능합니다." maxlength="30"
								style="margin-right: 10px; width: 70%; float: left;">
							<button type="button" class="btn btn-secondary" id="btn_checkId">ID
								중복확인</button>
							<p id="id_availability"
								style="color: grey; display: none; font-size: 12px; margin: 3px; font-weight: 600;"></p>
						</div>
					</div>
					<div class="form-group" id="divPassword">
						<label for="inputPassword" class="col-lg-2 control-label">비밀번호</label>
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
					<div class="form-group" id="divName">
						<label for="inputName" class="col-lg-2 control-label">이름</label>
						<div class="col-lg-10">
							<input name="mem_name" type="text"
								class="form-control onlyHangul" id="name"
								data-rule-required="true" placeholder="한글만 입력 가능합니다."
								maxlength="15">
						</div>
					</div>

					<div class="form-group" id="divNickname">
						<label for="inputNickname" class="col-lg-2 control-label">닉네임</label>
						<div class="col-lg-10">
							<input name="mem_nick" type="text" class="form-control"
								id="nickname" data-rule-required="true" placeholder="별명"
								maxlength="15">
						</div>
					</div>

					<div class="form-group" id="divEmail">
						<label for="inputEmail" class="col-lg-2 control-label">이메일</label>
						<div class="col-lg-10">
							<input name="mem_email" type="email" class="form-control"
								id="email" data-rule-required="true" placeholder="이메일"
								maxlength="40"
								style="margin-right: 10px; width: 70%; float: left;">
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
								data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요."
								maxlength="11">
						</div>
					</div>

					<div class="form-group" id="divAddr">
						<label for="inputAddr" class="col-lg-2 control-label"
							style="padding-bottom: 22px;">주소</label> <br />
						<div class="col-lg-10" style="margin-top: -22px;">
							<input type="text" id="sample2_postcode" name="mem_zipcode"
								class="form-control" placeholder="우편번호" readonly
								style="margin-right: 10px; width: 70%; float: left; margin-bottom: 10px;">
							<input type="button" onclick="sample2_execDaumPostcode()"
								id="btn_postCode" class="btn btn-secondary" value="우편번호 찾기" />
							<input type="text" id="sample2_address" name="mem_addr"
								class="form-control" placeholder="주소" readonly
								style="margin-bottom: 10px;"> <input type="text"
								id="sample2_detailAddress" name="mem_addr_d"
								class="form-control" placeholder="상세주소"> <input
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
					
					
					
					<script>
					/**
					 *  //우편번호 API
					 */


					// 우편번호 찾기 화면을 넣을 element
					var element_layer = document.getElementById('layer');

					function closeDaumPostcode() {
						// iframe을 넣은 element를 안보이게 한다.
						element_layer.style.display = 'none';
					}

					function sample2_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
										// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

										// 각 주소의 노출 규칙에 따라 주소를 조합한다.
										// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										var addr = ''; // 주소 변수
										var extraAddr = ''; // 참고항목 변수

										// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
										if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을
																				// 경우
											addr = data.roadAddress;
										} else { // 사용자가 지번 주소를 선택했을 경우(J)
											addr = data.jibunAddress;
										}

										// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
										if (data.userSelectedType === 'R') {
											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
												extraAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== '' && data.apartment === 'Y') {
												extraAddr += (extraAddr !== '' ? ', '
														+ data.buildingName : data.buildingName);
											}
											// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraAddr !== '') {
												extraAddr = ' (' + extraAddr + ')';
											}
											// 조합된 참고항목을 해당 필드에 넣는다.
											document.getElementById("sample2_extraAddress").value = extraAddr;

										} else {
											document.getElementById("sample2_extraAddress").value = '';
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document.getElementById('sample2_postcode').value = data.zonecode;
										document.getElementById("sample2_address").value = addr;
										// 커서를 상세주소 필드로 이동한다.
										document.getElementById("sample2_detailAddress").focus();

										// iframe을 넣은 element를 안보이게 한다.
										// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
										element_layer.style.display = 'none';
									},
									width : '100%',
									height : '100%',
									maxSuggestItems : 5
								}).embed(element_layer);

						// iframe을 넣은 element를 보이게 한다.
						element_layer.style.display = 'block';

						// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
						initLayerPosition();
					}

					// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
					// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
					// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
					function initLayerPosition() {
						var width = 300; // 우편번호서비스가 들어갈 element의 width
						var height = 400; // 우편번호서비스가 들어갈 element의 height
						var borderWidth = 5; // 샘플에서 사용하는 border의 두께

						// 위에서 선언한 값들을 실제 element에 넣는다.
						element_layer.style.width = width + 'px';
						element_layer.style.height = height + 'px';
						element_layer.style.border = borderWidth + 'px solid';
						// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
						element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
								+ 'px';
						element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
								+ 'px';
					}

					
					</script>
					
					
					
					<hr style="clear: both;">

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button id="btn_submit" type="button" class="btn btn-primary">회원가입</button>
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