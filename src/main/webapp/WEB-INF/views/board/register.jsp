<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Q&A readPage</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>

<style>
label{
font-size: 14px; font-weight: 600; color: gray;}
</style>
<script>

	$(document).ready(function(){
		
		// 게시물 등록 유효성 검사
		$('#registerBtn').on("click", function(){
			
			if($('#board_title').val()==null || $('#board_title').val()==""){
				alert("제목을 입력해주세요.");
				return;
				
			}
			
			if($('#board_content').val()==null || $('#board_content').val()==""){
				alert("내용을 입력해주세요.");
				return;
			}
			
			$('#registerForm').submit();
			
		});
		
		// 취소버튼 클릭시 리스트로 이동
		$('#cancleBtn').on("click", function(){
			var result = confirm("게시물 등록을 취소하시겠습니까?");
			if(result){
				location.href="/board/list";
			} else{}
		});
		
	});
	
</script>



</head>

<body>

	<!-- 헤더 -->
	<%@include file="/WEB-INF/views/common/top.jsp"%>
	<!--// 헤더 -->



	<!-- 본문  -->
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper"
		style="margin-top: 100px; min-height: 550px;">

		<%-- MAIN CONTENT --%>
		<section class="content container-fluid">

			<%-- 상품 상세 --%>
			<div style="width: 100%; background-color: white;"
				class="container text-center">

				<!-- left column -->
				<div class="col-md-12">
					<!-- general form elements -->
					<div class="box box-primary" style="margin-bottom: 22px;">

						<div class="box-header">

							<h3 class="box-title">REGISTER Q&A</h3>
						</div>
						<!-- /.box-header -->

						<hr style="margin-bottom: 75px;">
						
						
				<form id="registerForm" role="form" method="post" action="/board/register">
					<div class="box-body" style="text-align: left;">
						
						
						
						<div class="form-group" style="display: inline-block;float: left;width: 400px;">
								<label for="InputTitle">제목</label> 
								<input type="text" id="board_title" name='board_title' class="form-control">
									
							</div>
							
							<div class="form-group" style="display: inline-block;float: left;margin-left: 20px;">
								<label for="InputWriter">작성자</label> <input
									type="text" name="mem_id" class="form-control"
									value="${sessionScope.user.mem_id}" readonly="readonly">
							</div>

							<div class="form-group" style="clear: both;">
								<label for="InputContent">내용</label>
								<textarea style="max-height: 180px;" class="form-control" id="board_content" name="board_content" rows="3"></textarea>
						</div>
						
						
					</div>
					<!-- /.box-body -->
					
					<div class="box-footer" style="float: left;">
						<button id="registerBtn" type="button" class="btn btn-secondary" style="font-size: 12.5px;">게시물 등록</button>
						<button id="cancleBtn" type="button" class="btn btn-secondary" style="font-size: 12.5px;background-color: lightgray; color: white; border-color: lightgray;">취소</button>
					</div>
				</form>
						

					</div>
					<!-- /.box -->
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