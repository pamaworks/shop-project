/**
 *  상품수정js
 */



$(document).ready(function() {

	
	/* 상품 수정 버튼 클릭 시 */
	$("#btn_submit").on("click", function(){
		var result = confirm("수정된 정보를 저장하시겠습니까?");
		
		if(result){
			var mainCategory = $("#cate_code_prt option:selected");
			var subCategory = $("#cate_code option:selected");
			var pdt_name = $("#pdt_name");
			var pdt_company = $("#pdt_company");
			var pdt_price = $("#pdt_price");
			var pdt_discount = $("#pdt_discount");
			var ckeditor = CKEDITOR.instances['pdt_content'];
			var pdt_amount = $("#pdt_amount");
			var pdt_buy = $("#pdt_buy");
			
			var file1 = $("#file1");
			var fileSize = file1.size;
			var fileFormat  = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
			var maxSize = 5 * 1024 * 1024; // 5MB
			
			
			
			if(mainCategory.val()==null || mainCategory.val()=="default"){
				alert("1차 카테고리를 선택해주세요.");
				mainCategory.focus();
				return;
				
			} else if(subCategory.val()==null || subCategory.val()=="default"){
				alert("2차 카테고리를 선택해주세요.");
				subCategory.focus();
				return;
				
			}
			else if(pdt_name.val()==null || pdt_name.val()==""){
				alert("상품명을 입력해주세요.");
				pdt_name.focus();
				return;
				
			} else if(pdt_company.val()==null || pdt_company.val()==""){
				alert("제조사를 입력해주세요.");
				pdt_company.focus();
				return;
				
			}else if(pdt_price.val()==null || pdt_price.val()==""){
				alert("판매가를 입력해주세요.");
				pdt_price.focus();
				return;
				
			}else if(pdt_discount.val()==null || pdt_discount.val()==""){
				alert("할인가를 입력해주세요.");
				pdt_discount.focus();
				return;
				
			}else if(pdt_price.val() < pdt_discount.val()){
				alert("할인가는 판매가보다 작은 금액으로 입력해주세요.");
				pdt_discount.focus();
				return;
				
			}else if(ckeditor.getData()==null || ckeditor.getData()==""){
				alert("상품 상세 내용을 입력해주세요.");
				ckeditor.focus();	
				return;
				
			}else if(pdt_amount.val()==null || pdt_amount.val()==""){
				alert("상품 수량을 입력해주세요.");
				pdt_amount.focus();
				return;
				
//			}else if($('#fileName').html()=='파일이 변경되었습니다.'){
//				
//				if(!file1.val().match(fileFormat)){
//					alert("이미지 파일만 업로드 가능합니다.");
//					file1.focus();
//					return;
//					
//				}else if(fileSize > maxSize){
//					alert("파일 사이즈는 5MB까지만 가능합니다.");
//					file1.focus();
//					return;
//					
//				}
				
			}else {
				$("#editForm").submit();
			}
		} else {}
		
		
	});
	
	
});

