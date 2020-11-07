/**
 * 비밀번호변경 js\
 * 
 */



$(function() {


	// 모달을 전역변수로 선언
	var modalContents = $(".modal-contents");
	var modal = $("#defaultModal");

	
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

	
	
	// 비밀번호 변경 버튼 클릭시 -> 유효성(validation) 검사 -> 이상없으면 변경 진행
	$('#btn_submit').click(function() {

				
						var divPassword = $('#divPassword');
						var divPasswordCheck = $('#divPasswordCheck');
				

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

					
						// 유효성 검사 통과하면, 비밀번호 변경 전송
						$('#changePWForm').submit();
						
					});

	// 취소 버튼 클릭시
	$('#btn_cancle').on("click", function() {

		var result = confirm("비밀번호 변경을 취소하시겠습니까?");
		if (result) {
			location.href = "/member/myPage";

		} else {
		}

	});



});
