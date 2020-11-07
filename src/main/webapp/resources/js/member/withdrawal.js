/**
 * 탈퇴 js
 * 
 */



$(function() {

	// 탈퇴 버튼
	$('#btn_submit').on("click", function() {

		var result = confirm("회원 탈퇴를 진행하시겠습니까?");
		if (result) {
			
			$('#withdrawalForm').submit();
			//alert("회원탈퇴가 완료되었습니다.");

		} else {
		}
		
			

	});

	// 취소 버튼 클릭시
	$('#btn_cancle').on("click", function() {

		var result = confirm("회원탈퇴를 취소하시겠습니까?");
		if (result) {
			location.href = "/member/myPage";

		} else {
		}
	});


});
