/**
 * mypage.js
 */



$(function() {
	


	// 모달을 전역변수로 선언
	var modalContents = $(".modal-contents");
	var modal = $("#defaultModal");

	
	// 적립금 모달창
	/*$('#btn-point').on("click", function(){

		modalContents.text("회원님의 적립금은 "+point+"원 입니다.");
		modal.modal('show');
	});*/


	// 회원정보 버튼 클릭시
	$('#btn-profile').on("click", function() {
		
		location.href = "/member/checkPW?url=modify";
	});
	
	
	// 비밀번호 변경 버튼 클릭시
	$('#btn-password').on("click", function() {
		
		location.href = "/member/checkPW?url=changePW";
	});
	

	// 회원탈퇴 버튼 클릭시
	$('#btn-withdrawal').on("click", function() {
		
		location.href = "/member/checkPW?url=withdrawal";
	});
	
	// 장바구니 버튼 클릭시
	$('#btn-cart').on("click", function() {
		
		location.href = "/cart/list";
	});
	
	// 주문 내역 조회 클릭시
	$('#btn-order-list').on("click", function() {
		
		location.href = "/order/list";
	});	
	


});