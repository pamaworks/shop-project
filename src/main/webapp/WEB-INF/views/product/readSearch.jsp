<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>readSearch</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>




<%-- 템플릿: 상품목록 --%>
<script id="template" type="text/x-handlebars-template">
	{{#each .}}
		<li class="replyLi" data-rv_num={{rv_num}} style="clear:both;margin-bottom:27px;">
        	<i class="fa fa-comments bg-blue"></i>
            <div class="timeline-item" style="border:1px solid lightgray;padding: 11px;">
                <span class="time" style="font-size: 13px;font-style: italic;color: gray;">
                	<i class="fa fa-clock-o"></i>{{prettifyDate rv_regdate}}
                </span>
                <h3 class="timeline-header">
					<strong style="color: orangered;">{{checkRating rv_score}} <p class='rv_score' style="display:none;">{{rv_score}}</p></strong> 
					</h3>
                <div class="timeline-body" style="display:inline-block;">
					<p style="font-size:11px;;">작성자: {{mem_id}}</p> <br>
					<p id='rv_content' style="font-size:15px;">{{rv_content}}</p> </div>
				<div class="timeline-footer" style="margin-top:22px;">
					{{eqReplyer mem_id rv_num}}
				</div>
	         </div>			
         </li>
	{{/each}}
</script>

<%-- 핸들바 사용자 정의 헬퍼 --%>
<script>
	$(document).ready(function(){
		
		
		// 상품 판매 여부
		if($('#pdt_buy').val()=='N'){
			alert("현재 판매중인 상품이 아닙니다.");
			location.href="/";
		}

		/* 상품 목록 버튼 클릭 시 */
		$("#btn_list").on("click", function(){
			location.href="/product/list?${pm.makeQuery(pm.cri.page)}&cate_code=${vo.cate_code}";
		});

		/* 
		 * 사용자 정의 헬퍼(prettifyDate)
		 * : 매개변수로 받은 timeValue를 원하는 날짜 형태로 바꿔준다.
		 */ 
		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" + date;
		});

		/* 
		 * 사용자 정의 헬퍼(checkRating)
		 * : 매개변수로 받은 후기 평점을 별표로 출력
		 */ 
		Handlebars.registerHelper("checkRating", function(rating) {
			var stars = "";
			switch(rating){
				case 1:
					 stars="★☆☆☆☆";
					 break;
				case 2:
					 stars="★★☆☆☆";
					 break;
				case 3:
					 stars="★★★☆☆";
					 break;
				case 4:
					 stars="★★★★☆";
					 break;
				case 5:
					 stars="★★★★★";
					 break;
				default:
					stars="☆☆☆☆☆";
			}
			return stars;
		});

		/* 
		 * 사용자 정의 헬퍼(eqReplyer)
		 * : 로그인 한 아이디와 리뷰의 아이디 확인 후, 수정/삭제 버튼 활성화 
		 */ 
		Handlebars.registerHelper("eqReplyer", function(replyer, rv_num) {
			var btnHtml = '';
			var mem_id = "${sessionScope.user.mem_id}";
			if (replyer == "${user.mem_id}") {
				btnHtml = "<a class='btn btn-secondary btn-xs' data-toggle='modal' data-target='#modifyModal' style='color:white;font-size:11px;'>"
					  + "MODIFY</a>"
					  + "<button class='btn btn-danger btn-xs' style='margin-left:5px;font-size:11px;margin-left:5px;'" 
					  + "onclick='deleteReview("+rv_num+");'"
					  + "type='button' >DELETE</button>"; 
			}
			return new Handlebars.SafeString(btnHtml);
			

		});

	});
</script>


<%-- 스타일 --%>
<style>

	ul,li{
		list-style: none;
	}

     #star_grade a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade a.on{
        color: black;
    }
    
    #star_grade_modal a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade_modal a.on{
        color: black;
    }
    
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
     .show{
   
       max-height: 800px; 
       overflow: auto;       
     } 
     .content_img img{
     width: 90% !important;
     height: auto !important;     
     }
     .buy-info span{
     	font-size: 14px;
    	display: inline-block;
   		float: left;
    	color: dimgray;
     }
     .buy-info label{
     	font-size: 14px;
    	display: inline-block;
    	float: left;
   		font-weight: 600;
    	color: darkslategray;
    	margin-right: 15px;
     }
     .replyLi{
		position: relative;
		top: 30px;
     }
     .time-label button{
     margin-bottom: 50px;
     }
</style>

	

<script type="text/javascript" src="/js/product/read.js"></script>
<link rel= "stylesheet" type="text/css" href="/css/member/pager.css">
</head>

<body>
	
	
	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->



	<!-- 본문  -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="margin-top:100px;min-height: 560px;">
			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
			
				<%-- 상품 상세 --%>
				<div style="width:100%; background-color:white;" class="container text-center">
				
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
						
							<div class="box-header">
							
								<h3 class="box-title">PRODUCT DETAIL</h3>
							</div>
							<!-- /.box-header -->
							
							<hr style="margin-bottom: 75px;">
							
							<%-- 상품 상세 정보 출력 --%>
							<div class="box-body">
							<input type="hidden" id="pdt_amount" value="${vo.pdt_amount}">
								<input type="hidden" id="pdt_buy" value="${vo.pdt_buy}">
								<div class="form-group container buy-info" style="margin:30px 0px; min-height: 350px;" >
									<div style="float:left;width: 40%;height:100%;min-width: 350px;margin-bottom: 20px;">
										<img src="/product/displayFile?fileName=${vo.pdt_img}" style="display: inline;width: 100%;">
									</div>
									<div style="display: inline-block; margin-left:20px;padding-top: 45px;float: right;margin-bottom: 45px;">
										<p id="soldOut" style="font-size: 15px; font-weight: 600; color: red;display: none;text-align: left;"> - 품절상품 - </p>
										<label for="InputProductName">상품명</label>
										<span>${vo.pdt_name}</span><br><br>
										
										<label for="InputCompany">제조사</label>
										<span>${vo.pdt_company}</span><br><br>
										
										<div style="float:left;text-align: left;">
											<label for="InputPrice" style="margin-right:10px;">판매가</label> 
											
											<span style="width:100px; margin-right:10px; display:inline-block;">
												<fmt:formatNumber value="${vo.pdt_price}" pattern="###,###,###" />원
											</span>
										
											
											<label for="InputDiscount" style="">할인가</label> 
											
											<span style="width:100px; display:inline-block;">
												<fmt:formatNumber value="${vo.pdt_discount}" pattern="###,###,###" />원
											</span>
										</div>
										<br><br>
										<input type="hidden" id="pdt_amount" name="pdt_amount" value="${vo.pdt_amount}">
												
										
										<%-- 로그인 상태 --%>
            							<c:if test="${sessionScope.user != null}">
										<div>
											<form method="get" action="/order/buy" id="orderForm">
												<label for="InputOrderAmount">구매 수량</label>
												<input type="number" id="ord_amount" name="ord_amount" value="1" style="width: 77px;font-size: 13px; height: 24px; float: left;padding-bottom: 4px; padding-left: 5px;"/><br><br>
												<input type="hidden" id="pdt_num" name="pdt_num" value="${vo.pdt_num}" />
												
												<hr>
												<button type="button" id="btn_buy" class="btn btn-secondary" style="float: right;font-size: 12.5px;margin-left: 10px;">구매하기</button>
												
												<%-- 장바구니 기능으로 진행 -> 같은 폼안에 있지만 js코드 따로 , 주소 따로--%>
												<button type="button" id="btn_cart" class="btn btn-secondary" style="float: right;background-color: lightgray;color: white;border-color: lightgray;font-size: 12.5px;">장바구니</button>
											</form>
										</div>
										</c:if>
										
										<%-- 로그아웃 상태 --%>
            							<c:if test="${sessionScope.user == null}">
										<div>
											<form method="get" action="/order/buy" id="orderForm">
												<label for="InputOrderAmount">구매 수량</label>
												<input type="number" id="ord_amount" name="ord_amount" value="1" style="width: 77px;font-size: 13px; height: 24px; float: left;padding-bottom: 4px; padding-left: 5px;"/><br><br>
												<input type="hidden" id="pdt_num" name="pdt_num" value="${vo.pdt_num}" />
												
												<hr>
												<button type="button" name="btn_logout" class="btn btn-secondary" style="float: right;font-size: 12.5px;margin-left: 10px;">구매하기</button>
												
												<%-- 장바구니 기능으로 진행 -> 같은 폼안에 있지만 js코드 따로 , 주소 따로--%>
												<button type="button" name="btn_logout" class="btn btn-secondary" style="float: right;background-color: lightgray;color: white;border-color: lightgray;font-size: 12.5px;">장바구니</button>
											</form>
										</div>
										</c:if>
										
									</div>
								</div>
								
								<hr style="margin-top:50px;margin-bottom: 30px;clear: both;">
								<!-- 상품 상세 -->
								<label for="detail" style="font-size: 24px; margin: 10px auto;">DETAIL</label><br>
								<div contenteditable="false" style="padding: 20px;" class="content_img">
									${vo.pdt_content}
								</div>
								<br>
								
								
								
								
								<%-- 상품 후기 --%>
								<div class='popup back' style="display:none;"></div>
							    <div id="popup_front" class='popup front' style="display:none;">
							     	<img id="popup_img">
							    </div>
						    	<form role="form" action="modifyPage" method="post">
									<input type='hidden' name='bno' value="${boardVO.bno}">
									<input type='hidden' name='page' value="${cri.page}"> 
									<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
									<%-- 
									<input type='hidden' name='searchType' value="${cri.searchType}">
									<input type='hidden' name='keyword' value="${cri.keyword}">
									 --%>
								</form>
								
								<div style="margin-bottom: 30px;">
								
								<hr style="margin-top: 30px;">
									<!-- 상품후기쓰기 부분 -->
									 <div>
										<label for="review" style="font-size: 24px; margin: 10px auto;">Review</label><br>
										<div class="rating">
											<p id="star_grade">
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
											</p>
										</div>
										<textarea id="reviewContent" rows="3" style="width:100%;border-color: lightgray;width:100%;"></textarea><br>
									
									
										<!-- 상품 후기 리스트 -->
									 	<ul class="timeline" style="padding:0;">
				 							 <!-- timeline time label -->
											<li class="time-label" id="repliesDiv" >
											
											    <%-- 로그인 상태 --%>
           										<c:if test="${sessionScope.user != null}">
											    <button class="btn btn-secondary" id="btn_write_review" type="button" style="float: right;font-size: 11px;margin-left: 10px;">상품후기쓰기</button>
											    </c:if>
											    
											    <%-- 로그아웃 상태 --%>
           										<c:if test="${sessionScope.user == null}">
											    <button class="btn btn-secondary" name="btn_review_logout" type="button" style="float: right;font-size: 11px;margin-left: 10px;">상품후기쓰기</button>
											    </c:if>
											    
												<button type="button" class="btn btn-secondary" style="float: right;background-color: lightgray;color: white;border-color: lightgray;font-size: 11px;">
											    	상품후기 보기 <small id='replycntSmall'> [ ${totalReview} ] </small>
											    </button>
											    
											    <button id="btn_list" type="button" class="btn btn-outline-dark" style="width: 145px;font-size: 11px;float: left;position:relative;">상품 리스트로 돌아가기</button>
							
											</li>
											<li class="noReview" style="display:none;width: 600px;margin:0 auto;">
												<i class="fa fa-comments bg-blue"></i>
												<div class="timeline-item" >
													 <h3 class="timeline-header" style="font-size:15px;">
														상품후기가 존재하지 않습니다.<br>
														상품후기를 입력해주세요.</h3>
												</div>
											</li>
											 
										</ul>
										
										
										
										<!-- 상품 후기 리스트 페이지부분 -->  
										<div class='text-center' style="margin-top: 77px;">
											<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
									 	</div>
									 </div>
									 
									 
									 <%-- Modal : 상품후기 수정/삭제 팝업 --%>
									<div id="modifyModal" class="modal modal-primary fade" role="dialog">
									  <div class="modal-dialog">
									    <!-- Modal content-->
									    <div class="modal-content">
									      <div class="modal-header" >
									        <button type="button" class="close" data-dismiss="modal">&times;</button>
									        <div class="modal-title">
												<p id="star_grade_modal">
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
												</p>
									        </div>
									      </div>
									      <div class="modal-body" data-rv_num>
									        <p><input type="text" id="replytext" class="form-control"></p>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-info" id="btn_modal_modify">MODIFY</button>
									        <button type="button" class="btn btn-default" data-dismiss="modal">CLOSE</button>
									      </div>
									    </div>
									  </div>
									</div>      
							</div>
							
							
							<!-- /.box-body -->

						</div>
						<!-- /.box -->	
					</div>
					<!--/.col (left) -->
				
				</div>		
				
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

	<!--// 본문  -->


	<!-- 푸터 -->
	<%@include file="/WEB-INF/views/common/bottom.jsp"%>
	<!--// 푸터 -->


</body>
</html>