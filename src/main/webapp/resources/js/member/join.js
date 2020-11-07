/**
 * 회원가입 js\
 * 
 */



// 이메일 형식 검사 함수
function email_check(email) {

	var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

	// alert(regex.test(email));

	return (regex.test(email));

}



// 아이디중복체크 기능 사용여부확인 변수
var isCheckId = "false";

// 이메일 인증 확인 여부를 위한 변수
var isCheckEmail = "false";




$(function() {

	
	// 아이디 변경시 중복체크 기능 false
	$('#mem_id').on("change",function(){
		
		isCheckId = "false";
	
	});
	
	
	// 이메일 변경시 중복체크 기능 false
	$('#email').on("change",function(){
		
		isCheckEmail = "false";
	
	});
	
	
	
	// 모달을 전역변수로 선언
	var modalContents = $(".modal-contents");
	var modal = $("#defaultModal");

	$('.onlyAlphabetAndNumber').keyup(function(event) {
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val($(this).val().replace(/[^_a-z0-9]/gi, '')); // _(underscore),
			// 영어, 숫자만
			// 가능
		}
	});

	$(".onlyHangul").keyup(function(event) {
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[a-z0-9]/gi, ''));
		}
	});

	$(".onlyNumber").keyup(function(event) {
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});

	// 검사하여 상태를 class에 적용
	// 아이디
	$('#mem_id').keyup(function(event) {

		var divId = $('#divId');

		if ($('#mem_id').val() == "") {
			divId.removeClass("has-success");
			divId.addClass("has-error");
		} else {
			divId.removeClass("has-error");
			divId.addClass("has-success");
		}
	});

	// 비밀번호
	$('#password').keyup(function(event) {

		var divPassword = $('#divPassword');

		if ($('#password').val() == "") {
			divPassword.removeClass("has-success");
			divPassword.addClass("has-error");
		} else {
			divPassword.removeClass("has-error");
			divPassword.addClass("has-success");
		}
	});

	// 비밀번호 체크
	$('#passwordCheck').keyup(function(event) {

		var passwordCheck = $('#passwordCheck').val();
		var password = $('#password').val();
		var divPasswordCheck = $('#divPasswordCheck');

		if ((passwordCheck == "") || (password != passwordCheck)) {
			divPasswordCheck.removeClass("has-success");
			divPasswordCheck.addClass("has-error");
		} else {
			divPasswordCheck.removeClass("has-error");
			divPasswordCheck.addClass("has-success");
		}
	});

	// 이름
	$('#name').keyup(function(event) {

		var divName = $('#divName');

		if ($.trim($('#name').val()) == "") {
			divName.removeClass("has-success");
			divName.addClass("has-error");
		} else {
			divName.removeClass("has-error");
			divName.addClass("has-success");
		}
	});

	// 닉네임
	$('#nickname').keyup(function(event) {

		var divNickname = $('#divNickname');

		if ($.trim($('#nickname').val()) == "") {
			divNickname.removeClass("has-success");
			divNickname.addClass("has-error");
		} else {
			divNickname.removeClass("has-error");
			divNickname.addClass("has-success");
		}
	});

	// 이메일
	$('#email').keyup(function(event) {

		var divEmail = $('#divEmail');

		if ($.trim($('#email').val()) == "") {
			divEmail.removeClass("has-success");
			divEmail.addClass("has-error");
		} else {
			divEmail.removeClass("has-error");
			divEmail.addClass("has-success");
		}
	});

	// 이메일 인증코드
	$('#mem_authcode').keyup(function(event) {

		var divEmailAuthCode = $('#divEmailAuthCode');

		if ($.trim($('#mem_authcode').val()) == "") {
			divEmailAuthCode.removeClass("has-success");
			divEmailAuthCode.addClass("has-error");
		} else {
			divEmailAuthCode.removeClass("has-error");
			divEmailAuthCode.addClass("has-success");
		}
	});

	// 우편번호
	$('#sample2_postcode').keyup(function(event) {

		var divAddr = $('#divAddr');

		if ($.trim($('#sample2_postcode').val()) == "") {
			divAddr.removeClass("has-success");
			divAddr.addClass("has-error");
		} else {
			divAddr.removeClass("has-error");
			divAddr.addClass("has-success");
		}
	});

	// 주소
	$('#sample2_address').keyup(function(event) {

		var divAddr = $('#divAddr');

		if ($.trim($('#sample2_address').val()) == "") {
			divAddr.removeClass("has-success");
			divAddr.addClass("has-error");
		} else {
			divAddr.removeClass("has-error");
			divAddr.addClass("has-success");
		}
	});

	// 상세주소
	$('#sample2_detailAddress').keyup(function(event) {

		var divAddr = $('#divAddr');

		if ($.trim($('#sample2_detailAddress').val()) == "") {
			divAddr.removeClass("has-success");
			divAddr.addClass("has-error");
		} else {
			divAddr.removeClass("has-error");
			divAddr.addClass("has-success");
		}
	});

	// 휴대폰번호
	$('#phoneNumber').keyup(function(event) {

		var divPhoneNumber = $('#divPhoneNumber');

		if ($.trim($('#phoneNumber').val()) == "") {
			divPhoneNumber.removeClass("has-success");
			divPhoneNumber.addClass("has-error");
		} else {
			divPhoneNumber.removeClass("has-error");
			divPhoneNumber.addClass("has-success");
		}
	});

	// 회원가입 버튼 클릭시 -> 유효성(validation) 검사 -> 이상없으면 가입 진행
	$('#btn_submit').click(function() {

						// var provision = $('#provision');
						// var memberInfo = $('#memberInfo');
						var divId = $('#divId');
						var divPassword = $('#divPassword');
						var divPasswordCheck = $('#divPasswordCheck');
						var divName = $('#divName');
						var divNickname = $('#divNickname');
						var divEmail = $('#divEmail');
						var divPhoneNumber = $('#divPhoneNumber');
						var divEmailAuthCode = $('#divEmailAuthCode');
						var divAddr = $('#divAddr');

						// 회원가입약관
						/*
						 * if ($('#provisionYn:checked').val() == "N") {
						 * modalContents.text("회원가입약관에 동의하여 주시기 바랍니다."); // 모달
						 * 메시지 입력 modal.modal('show'); // 모달 띄우기
						 * 
						 * provision.removeClass("has-success");
						 * provision.addClass("has-error");
						 * $('#provisionYn').focus(); return false; } else {
						 * provision.removeClass("has-error");
						 * provision.addClass("has-success"); } // 개인정보취급방침 if
						 * ($('#memberInfoYn:checked').val() == "N") {
						 * modalContents.text("개인정보취급방침에 동의하여 주시기 바랍니다.");
						 * modal.modal('show');
						 * 
						 * memberInfo.removeClass("has-success");
						 * memberInfo.addClass("has-error");
						 * $('#memberInfoYn').focus(); return false; } else {
						 * memberInfo.removeClass("has-error");
						 * memberInfo.addClass("has-success"); }
						 */

						// 아이디 검사
						if ($('#mem_id').val() == "") {
							modalContents.text("아이디를 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divId.removeClass("has-success");
							divId.addClass("has-error");
							$('#mem_id').focus();
							return false;
						} else {
							divId.removeClass("has-error");
							divId.addClass("has-success");
						}

						// 아이디 중복체크 사용 여부
						if (isCheckId == 'false') { 
							modalContents.text("아이디 중복 체크를 해주세요.");
							modal.modal('show');

							divId.removeClass("has-success");
							divId.addClass("has-error");
							$('#btn_checkId').focus();
							return false;
						} else {
							isCheckId='true';
							divId.removeClass("has-error");
							divId.addClass("has-success");
						}

						// 패스워드 유효성 함수 호출
						var enCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
						if (!enCheck.test($('#password').val())) {
							modalContents
									.text("비밀번호는 영문 대문자,영문 소문자,숫자,특수문자를 하나 이상씩 포함하여 8~16자 이내로 입력하세요.");
							modal.modal('show');

							divPassword.removeClass("has-success");
							divPassword.addClass("has-error");
							$('#password').focus();
							return false;
						} else {
							divPassword.removeClass("has-error");
							divPassword.addClass("has-success");
						}

						// 패스워드 검사
						if ($('#password').val() == "") {
							modalContents.text("비밀번호를 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divPassword.removeClass("has-success");
							divPassword.addClass("has-error");
							$('#password').focus();
							return false;
						} else {
							divPassword.removeClass("has-error");
							divPassword.addClass("has-success");
						}

						// 패스워드 확인 검사
						if ($('#passwordCheck').val() == "") {
							modalContents.text("비밀번호 확인을 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divPasswordCheck.removeClass("has-success");
							divPasswordCheck.addClass("has-error");
							$('#passwordCheck').focus();
							return false;
						} else {
							divPasswordCheck.removeClass("has-error");
							divPasswordCheck.addClass("has-success");
						}

						// 패스워드 비교
						if ($('#password').val() != $('#passwordCheck').val()
								|| $('#passwordCheck').val() == "") {
							modalContents.text("비밀번호가 일치하지 않습니다.");
							modal.modal('show');

							divPasswordCheck.removeClass("has-success");
							divPasswordCheck.addClass("has-error");
							$('#passwordCheck').focus();
							return false;
						} else {
							divPasswordCheck.removeClass("has-error");
							divPasswordCheck.addClass("has-success");
						}

						// 이름
						if ($('#name').val() == "") {
							modalContents.text("이름을 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divName.removeClass("has-success");
							divName.addClass("has-error");
							$('#name').focus();
							return false;
						} else {
							divName.removeClass("has-error");
							divName.addClass("has-success");
						}

						// 닉네임
						if ($('#nickname').val() == "") {
							modalContents.text("닉네임을 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divNickname.removeClass("has-success");
							divNickname.addClass("has-error");
							$('#nickname').focus();
							return false;
						} else {
							divNickname.removeClass("has-error");
							divNickname.addClass("has-success");
						}

						// 이메일
						if ($('#email').val() == "") {
							modalContents.text("이메일을 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divEmail.removeClass("has-success");
							divEmail.addClass("has-error");
							$('#email').focus();
							return false;
						} else {
							divEmail.removeClass("has-error");
							divEmail.addClass("has-success");
						}

						// 이메일 인증코드
						if (isCheckEmail=='false') {
							modalContents.text("이메일 인증을 해주시기 바랍니다.");
							modal.modal('show');

							divEmailAuthCode.removeClass("has-success");
							divEmailAuthCode.addClass("has-error");
							$('#mem_authcode').focus();
						
							return false;
						} else {
							isCheckEmail='true';
							divEmailAuthCode.removeClass("has-error");
							divEmailAuthCode.addClass("has-success");
						}

						// 휴대폰 번호
						if ($('#phoneNumber').val() == "") {
							modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divPhoneNumber.removeClass("has-success");
							divPhoneNumber.addClass("has-error");
							$('#phoneNumber').focus();
							return false;
						} else {
							divPhoneNumber.removeClass("has-error");
							divPhoneNumber.addClass("has-success");
						}

						// 우편번호
						if ($('#sample2_postcode').val() == "") {
							modalContents.text("우편번호를 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divAddr.removeClass("has-success");
							divAddr.addClass("has-error");
							$('#sample2_postcode').focus();
							return false;
						} else {
							divAddr.removeClass("has-error");
							divAddr.addClass("has-success");
						}

						// 주소
						if ($('#sample2_address').val() == "") {
							modalContents.text("주소를 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divAddr.removeClass("has-success");
							divAddr.addClass("has-error");
							$('#sample2_address').focus();
							return false;
						} else {
							divAddr.removeClass("has-error");
							divAddr.addClass("has-success");
						}

						// 상세주소
						if ($('#sample2_detailAddress').val() == "") {
							modalContents.text("상세주소를 입력하여 주시기 바랍니다.");
							modal.modal('show');

							divAddr.removeClass("has-success");
							divAddr.addClass("has-error");
							$('#sample2_detailAddress').focus();
							return false;
						} else {
							divAddr.removeClass("has-error");
							divAddr.addClass("has-success");
						}

						// 유효성 검사 통과하면, 회원 가입 전송

						$('#joinForm').submit();
						//alert("회원가입이 완료되었습니다!");

					});

	// 취소 버튼 클릭시
	$('#btn_cancle').on("click", function() {

		var result = confirm("가입을 취소하시겠습니까?");
		if (result) {
			location.href = "/";

		} else {
		}

	});

	// 이메일 인증 클릭시
	$('#btn_sendAuthCode')
			.on(
					"click",
					function() {

						// 수신자 메일(회원가입시에 사용자가 입력한 메일 주소)
						var receiveMail = $('#email').val();

						// 입력한 메일 공백 유효성 검사
						if (receiveMail == "" || receiveMail == null) {
							// 메시지를 alert형태로 출력하지않고, 임의의 위치에 출력
							// alert("이메일공백");
							$('#authcode_status').show();
							$('#authcode_status').html("이메일을 입력해주세요.");
							$('#email').focus();
							return false;
						}

						// 이메일 형식 검사
						if (!email_check(receiveMail)) {
							// 메시지를 alert형태로 출력하지않고, 임의의 위치에 출력
							// alert("이메일형식");
							$('#authcode_status').show();
							$('#authcode_status').html("올바른 이메일 주소를 입력해주세요.");
							$('#email').focus();
							return false;

						}

						// 현재 작업 진행 상태를 보여줌
						$('#authcode_status').show();
						$('#authcode_status').html('인증코드를 전송 중입니다. 잠시 기다려주세요.');

						// ajax형태로 메일 전송
						$
								.ajax({
									url : '/email/send', // EmailController
									// sendMail
									type : 'post',
									dataType : 'text',
									data : {
										receiveMail : receiveMail
									}, // {key : value}
									success : function(data) {
										$('#divEmailAuthCode').show(); // 이메일
										// 인증코드
										// 입력 박스
										// show
										$('#authcode_status').css("color",
												"grey");
										//$('#btn_sendAuthCode').html('메일 재전송');
										$('#authcode_status')
												.html(
														'메일이 전송되었습니다. 입력하신 이메일 주소에서 인증코드 확인 후 입력해주세요.');
									}

								});

					});

	// 이메일 인증코드 입력 후 확인 클릭시
	$('#btn_checkAuthCode').on("click", function() {

		var authcode = $('#mem_authcode').val(); // 사용자가 입력한 인증 코드

		$.ajax({
			url : '/member/checkAuthCode',
			type : 'post',
			dataType : 'text',
			data : {
				authcode : authcode
			},
			success : function(data) {
				if (data == 'SUCCESS') {
					$('#divEmailAuthCode').hide(); // 인증코드 입력박스 숨기기
					$('#authcode_status').css("color", "blue");
					$('#authcode_status').html('인증에 성공했습니다.');

					isCheckEmail = "true";
					
					return;
				} else {

					$('#authcode_status').css("color", "red");
					$('#authcode_status').html('인증 번호가 틀립니다. 다시 시도해주세요.');
					return;
				}
			}

		});

	});

	// 아이디 중복 확인 클릭 시
	$('#btn_checkId').on(
			"click",
			function() {

				if ($('#mem_id').val() == "" || $('#mem_id').val() == null) {
					$('#id_availability').show();
					$('#id_availability').html("아이디를 입력해주세요.");
					return;
				}

				var mem_id = $('#mem_id').val();

				// ajax 방식으로 데이터 전송
				// ajax방식의 제어 흐름 : 클라이언트 시작 -> 서버요청 -> 클라이언트 종료
				$.ajax({
					url : "/member/checkIdJoin",
					type : "post",
					dataType : "text",
					data : {
						mem_id : mem_id
					},
					success : function(data) {
						if (data == 'SUCCESS') { // 사용 가능한 아이디
							$('#id_availability').show();
							$('#id_availability').css("color", "blue");
							$('#id_availability').html("사용 가능한 아이디입니다.");

							// 아이디를 중복체크하고 나서 아이디 텍스트박스 읽기모드, 중복체크 비활성화
							//$("#mem_id").attr("readonly", true);
							//$("#btn_checkId").attr("disabled", true);

							isCheckId = "true"; // 아이디 중복체크 확인 용도
						} else { // 사용 불가능 아이디(이미 존재하는 아이디) = 'FAIL'
							$('#id_availability').show();
							$('#id_availability').css("color", "red");
							$('#id_availability').html(
									"이미 존재하는 아이디입니다. \n다른 아이디를 입력해주세요.");
						}
					}

				});

			});

});
