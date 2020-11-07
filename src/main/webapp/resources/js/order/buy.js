/**
 *  buy js
 */


$(document).ready(function() {
	
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
	
	// 처음에 가격 업데이트
	updatePrice();

	/* 전체 선택 체크박스 클릭 시 */
	$("#checkAll").on("click", function() {
		// 전체선택 클릭 여부로 다른 체크박스 체크
		$(".check").prop('checked', this.checked);
	});

	
	/* 체크박스 중 선택안된 체크박스 존재 시 전체선택 해제 */
	$(".check").on("click", function() {
		$("#checkAll").prop('checked', false);
	});
	
	
	/* 선택 상품 삭제 버튼 클릭 시 */
	$("#btn_delete_check").on("click", function() {
		// 체크여부 유효성 검사
		if ($("input[name='check']:checked").length == 0) {
			alert("삭제할 상품을 선택해주세요.");
			return;
		}
		// 체크 된 상품이 존재할 경우 진행
		var result = confirm("선택한 상품을 삭제하시겠습니까?");
		if (result) {
			// 체크 된 상품의 value(cart_code)를 가져옴
			$("input[name='check']:checked").each(function(i) {
				var pdt_num = $(this).val();
				$("#productVO_"+pdt_num).remove();
				updatePrice();
			});
			
			if($("#ordertbl >tbody tr").length==0){
				$("#thead").append("<tr><td colspan='7' style='padding:20px 0px;'><span>구매할 상품이 존재하지 않습니다.</span></td></tr>");
			}
		} else {}
	});
	
	/* 결제하기 버튼 클릭 시 */
	$("#btn_submit").on("click", function(){
		
		
		
		if($("#ordertbl >tbody tr").length==0){
			// tr태그가 생성된다는 것 = 데이터가 있다는 것
			// (주문상품x)결제할 상품이 없는 경우
			alert("결제할 상품이 없습니다.\n메인화면으로 돌아갑니다.");
			location.href="/";
			return;
			
		} else {
			// 결제할 상품이 존재하는 경우
		
			
			var result = confirm("결제하시겠습니까?");

			if (result) {
			
			
			// 수령자 이름
			if ($('#ord_name').val() == "") {

				alert("수령자 이름을 입력해주세요.");
				$('#ord_name').focus();
				return false;
			} else{}
			
			// 휴대폰 번호
			if ($('#ord_phone').val() == "") {

				alert("휴대폰 번호를 입력해주세요.");
				$('#ord_phone').focus();
				return false;
			} else {}
			
			// 주소 변경 확인
			if ($('#sample2_address').val() == "") {

				alert("주소를 입력해주세요.");
				$('#sample2_address').focus();
				return false;
			} else {}
			
			// 상세주소
			if ($('#sample2_detailAddress').val() == "") {

				alert("상세주소를 입력해주세요.");
				$('#sample2_detailAddress').focus();
				return false;
			} else{}
			
			// 우편번호
			if ($('#sample2_postcode').val() == "") {

				alert("우편번호를 입력해주세요.");
				$('#sample2_postcode').focus();
				return false;
			} else {}

			
			
			$("#orderForm").submit(); // form태그 전송
			
			}else{}
		}
		
	});
});


/* 총 가격, 할인 가격 변경 */ 
var updatePrice = function(){
	
	var totalPrice = 0;
	var totalDiscount = 0;
	
	$(".productRow").each(function(index, item){
		var price=$(this).find("input[name='price']").val();
		var discount=$(this).find("input[name='discount']").val();
		var amount=$(this).find("input[name='amount']").val();
		
		totalPrice += price * amount;
		totalDiscount += discount * amount;
		
	});
	
	$("#totalPrice").html(numberFormat(totalPrice) + "원");
	$("#totalDiscount").html(numberFormat(totalDiscount) + "원");
	$("#ord_total_price").val(totalDiscount);
};

/* 숫자 콤마 설정 */
function numberFormat(inputNumber) {
	return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


