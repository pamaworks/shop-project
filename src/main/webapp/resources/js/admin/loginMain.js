/**
 * 관리자 로그인js
 */

$(function(){

	// 로그인 버튼 클릭시 -> 유효성(validation) 검사 -> 이상없으면 로그인 진행
	$('#btn_login').on("click", function(){

		// 아이디 검사
		if ($('#admin_id').val() == "" || $('#admin_id').val() == null) {
			alert("아이디를 입력해주세요.");

			$('#admin_id').focus();
			return false;
		}

		// 패스워드 검사
		if ($('#admin_pw').val() == "" || $('#admin_pw').val() == null) {
			alert("비밀번호를 입력해주세요.");

			$('#admin_pw').focus();
			return false;
		}

		// 유효성 검사 통과하면, 로그인 전송
		$('#loginForm').submit();

	});


});
