/**
 * 로그인js
 */

$(function() {

	// 모달을 전역변수로 선언
	var modalContents = $(".modal-contents");
	var modal = $("#defaultModal");

	// 로그인 버튼 클릭시 -> 유효성(validation) 검사 -> 이상없으면 로그인 진행
	$('#btn_submit').on("click", function(){

		// 아이디 검사
		if ($('#mem_id').val() == "" || $('#mem_id').val() == null) {
			modalContents.text("아이디를 입력해주세요.");
			modal.modal('show');

			$('#mem_id').focus();
			return false;
		}

		// 패스워드 검사
		if ($('#mem_pw').val() == "" || $('#mem_pw').val() == null) {
			modalContents.text("비밀번호를 입력해주세요.");
			modal.modal('show');

			$('#mem_pw').focus();
			return false;
		}
		
		if($('#isUseCookie').is(":checked")){
			//alert("쿠키체크완료!!");
			
			$('input[name=isUseCookie]').val(2);
			
			//alert("isUseCookie : "+$('input[name=isUseCookie]').val());
		}

		// 유효성 검사 통과하면, 로그인 전송
		$('#loginForm').submit();

	});

	// 회원가입 버튼 클릭시
	$('#btn_join').on("click", function() {
		location.href = "/member/join";
	});
	
	
	

});
