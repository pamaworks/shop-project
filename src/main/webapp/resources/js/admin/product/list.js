/**
 *  상품 리스트.js
 */


$(document).ready(function(){
    
		// 전체 선택 체크박스 클릭 시 
		$("#checkAll").on("click", function(){
			// 전체선택 클릭 여부로 다른 체크박스 체크
			$(".check").prop('checked', this.checked);
		});
		
		
		// 체크박스 중 선택안된 체크박스 존재 시 전체선택 해제 
		$(".check").on("click", function(){
			$("#checkAll").prop('checked', false);
		});
		
		
		// 상품 리스트 - 삭제 버튼 클릭 시 
		$("button[name=btn_delete]").on("click", function(){
			var result = confirm("이 상품을 삭제하시겠습니까?");
			if(result){
				// this -> 선택한 삭제 버튼의 
				// parent() -> 부모 form 태그
				
				//alert($(this).prev().prev().prev().val());
				
				$(this).parent().submit();
				
				// $(".deleteForm").submit(); // 버그 발생, 엉뚱한 데이터 삭제
			} else{}
		});
		
		// 상품 등록 클릭시
		$('#btn_insert').on("click",function(){
			
			location="/admin/product/insert";
		});
		
		
		
	});

	
	