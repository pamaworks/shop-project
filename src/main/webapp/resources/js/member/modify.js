/**
 * 회원정보수정 js
 */



// 이메일 형식 검사 함수
function email_check(email) {

	var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

	// alert(regex.test(email));

	return (regex.test(email));

}

// 이메일 인증 확인 여부를 위한 변수
var isCheckEmail = "true";





$(function(){
	
	// 이메일 변경시 이메일 인증 확인 변수 false
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



	// 수정 클릭시 -> 유효성(validation) 검사 -> 이상없으면 수정 진행
	$('#btn_submit').click(function() {

						var divName = $('#divName');
						var divNickname = $('#divNickname');
						var divEmail = $('#divEmail');
						var divPhoneNumber = $('#divPhoneNumber');
						var divEmailAuthCode = $('#divEmailAuthCode');
						var divAddr = $('#divAddr');

						
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

	
						
						// 이메일을 변경 했을때에만 인증코드 발송
						//if($('#email').val() != $('#hidden_email').val())
						if(isCheckEmail=='false'){
							modalContents.text("이메일 인증을 해주시기 바랍니다.");
							modal.modal('show');

							divEmailAuthCode.removeClass("has-success");
							divEmailAuthCode.addClass("has-error");
							$('#mem_authcode').focus();
							return false;
						} else {
							isCheckEmail = 'true';
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

						// 유효성 검사 통과하면, 회원 정보 수정

						$('#modifyForm').submit();
						

					});

	// 취소 버튼 클릭시
	$('#btn_cancle').on("click", function() {

		var result = confirm("회원 정보 수정을 취소하시겠습니까?");
		if (result) {
			location.href = "/member/myPage";

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

	

});
