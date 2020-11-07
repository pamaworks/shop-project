<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>admin order list</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>


<!-- 주문 리스트 js -->
<script type="text/javascript" src="/js/admin/order/list.js" charset="UTF-8"></script>

<style>
#subject_col span{
	border-right: solid 2px lightgray;
    display: inline-block;
    font-weight: 600;
    width: 18%;
}

#subject_col2 span{
	display: inline-block;
    width: 18%;
    font-size: 13px;
}
a{
color: black;
}

</style>
<script>
$(document).ready(function(){
	
	// 검색 버튼 클릭 시 
	$("#btn_search").on("click", function(){
		if($('#keyword').val()==null || $('#keyword').val()==""){
			alert("검색어를 입력해주세요.");
			$('#keyword').focus();
			return false;
		}else{
		self.location = "list"
			+ '${pm.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keyword').val();
		}
	});
	
	// 배송상태 변경 버튼
	$('button[name=selectDelivery]').on("click",function(){
		
		var ord_delivery = $("#select_deli option:selected").val();
		var ord_code = $(this).prev().val();
		
		$.ajax({
			url : '/admin/order/delivery',
			type:'post',
			dataType: 'text',
			data:{	ord_delivery : ord_delivery,
					ord_code : ord_code
				},
			success : function(data){
				alert("배송상태가 변경되었습니다.");
				location.href="/admin/order/list${pm.makeSearch(pm.cri.page)}"
			}
			
		});
		
	});
	
});
</script>

</head>



<body class="hold-transition skin-blue sidebar-mini">

	<%-- @ModelAttribute("cri") SearchCriteria cri, Model model --%>

	<%-- 로그아웃 상태 --%>
	<c:if test="${sessionScope.admin == null}">
		<script>
			alert("관리자만 접근 가능합니다. \n로그인 해주세요.");
			location = "/admin/loginMain";
		</script>
	</c:if>
	<%-- // 로그아웃 상태 --%>


	<%-- 로그인한 상태 --%>

	<c:if test="${sessionScope.admin != null}">

		<!-- 헤더 -->
		<%@include file="/WEB-INF/views/common/admin/top.jsp"%>
		<!-- // 헤더 -->


		<!-- 사이드바 메뉴 /관리자기능 -->
		<%@include file="/WEB-INF/views/common/admin/left.jsp"%>
		<!-- // 사이드바 메뉴 -->


		<!-- 본문 -->
		<div class="wrapper">


			<div class="content-wrapper">
				<section class="content-header">
					<h1>
						Prinha Admin Page <small style="font-size: 13px;"> 주문 목록 </small>
					</h1>
				</section>


				<section class="content container-fluid">
					<div class="row">
					<div class="col-md-12">
					
					
					
						
						<%-- 검색 / 클릭 버튼 --%>
						<div class="row text-center">
							
							<%-- 검색 조건 / 페이지 이동에도 해당 값 유지하기 --%>
							<div class="search" style="display: inline-block; float: left; margin-left: 15px;">
								<%-- 검색 조건 : 회원아이디,회원명 --%>
								<select name="searchType" style="width: 180px; height: 26px;">
									<option <c:out value="${cri.searchType == null ? 'selected' : ''}" />>검색 조건 선택</option>
									
									<option value="ord_code" <c:out value="${cri.searchType eq 'ord_code' ? 'selected' : ''}" />>주문 코드</option>
									<option value="mem_id" <c:out value="${cri.searchType eq 'mem_id' ? 'selected' : ''}" />>회원 아이디</option>
									<option value="mem_name" <c:out value="${cri.searchType eq 'mem_name' ? 'selected' : ''}" />>회원명</option>
															
								</select>
								
								<input type="text" name="keyword" id="keyword" value="${cri.keyword}" />
								<button id="btn_search" class="btn btn-default" style="width: 50px;height: 26px;padding:3.5px 4px;">검색</button>
							</div>	
						
							
							
					
						</div>
					
					
						<br>
					
					
						<%-- 주문 리스트 / 페이징 --%>
						<div class="box box-primary">
						
							<%-- 주문 리스트 --%>
							<div class="box-body">
								<div class="orderList" >
								<%-- 주문내역 테이블 --%>
								<table class="table  text-center" id="ordertbl">
									<thead id="thead">
									
									<tr style="background-color: aliceBlue;" >
											
											<td colspan="7" style="text-align:center;" id="subject_col">
												
												<span style="width: 10%;">주문번호</span>
												<span>회원명</span>
												<span>회원아이디</span>
												<span>주문일자</span>
												<span style="border: none;width: 30%;">배송상태</span>
											
											</td>
											
										<tr>
									
									
									<%-- 주문이 존재하지 않는 경우 --%>
									<tr>
										<c:if test="${empty orderInfo}">
											<span style="color: red;font-size: 13.5px;">주문이 존재하지 않습니다.</span>
										</c:if>
									</tr> 
										
									
									<%-- 주문이 존재하는 경우 --%>
									
									<c:forEach items="${orderInfo}" var="orderInfo">
										
										<tr style="background-color: white;" >
											
											<td colspan="7" style="text-align:center;" id="subject_col2">
												
												<a href="/admin/order/read?ord_code=${orderInfo.ord_code}"><span style="width:10%;">${orderInfo.ord_code}</span></a>
												<a href="/admin/order/read?ord_code=${orderInfo.ord_code}"><span>${orderInfo.mem_name}</span></a>
												<a href="/admin/order/read?ord_code=${orderInfo.ord_code}"><span>${orderInfo.mem_id}</span></a>
												
												<span style="font-style: italic; color: darkgray; font-size: 12px;">
												<fmt:formatDate value="${orderInfo.ord_regdate}" pattern="yyyy/MM/dd HH:mm:ss"/></span>
												<span style="width: 30%;">${orderInfo.ord_delivery}
												
												<select class="form-control" name="select_deli" id="select_deli" style="width: 100px !important;display: inline-block;font-size: 10px;">
													
													<option <c:out value="${orderInfo.ord_delivery == '배송준비중'?'selected':''}"/>>배송준비중</option>
													<option <c:out value="${orderInfo.ord_delivery == '배송중'?'selected':''}"/>>배송중</option>
													<option <c:out value="${orderInfo.ord_delivery == '배송완료'?'selected':''}"/>>배송완료</option>
												</select>
												<input type="hidden" id="order_ord_code" value="${orderInfo.ord_code}">
												<button name="selectDelivery" id="selectDelivery" class="btn btn-secondary" type="button" style="background-color: gray;font-size: 12px;color: white;">배송상태변경</button>
												
												</span>
											
												
											</td>
											
										<tr>
									</c:forEach>
									
									
									<thead>
									
								</table>
								<br><br><br>
							</div>
								
							</div>
						
							
							<%-- 페이징 기능 --%>
							<div class="box-footer">
								<div class="text-center">
									<ul class="pagination">
									
									
										<%-- 이전표시 여부  [이전] --%>
										<c:if test="${pm.prev}">
											<li><a href="list${pm.makeSearch(pm.startPage-1)}">&laquo;</a>
											</li>
										</c:if>
										
										
										<%-- 페이지목록번호 :  1  2  3  4  5  --%>
										<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
											var="idx">
											<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
												<a href="list${pm.makeSearch(idx)}">${idx}</a>
											</li>
										</c:forEach>
										
										
										<%-- 다음표시 여부  [다음]--%>
										<c:if test="${pm.next && pm.endPage > 0}">
											<li><a href="list${pm.makeSearch(pm.endPage +1)}">&raquo;</a>
											</li>
										</c:if>

									</ul>
								</div>							
							</div>
						
						</div>
						
						
					</div>	
					</div>
				</section>

			</div>
		</div>
		<!-- // 본문 -->



		<!-- // 푸터 -->
		<%@include file="/WEB-INF/views/common/admin/bottom.jsp"%>
		<!-- 푸터 -->
	

</c:if>
	<%-- // 로그인한 상태 --%>

</body>
</html>