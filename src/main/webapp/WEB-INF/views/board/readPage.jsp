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

<title>Q&A readPage</title>

<!-- Bootstrap core CSS -->
<!-- Custom styles for this template -->
<%@include file="/WEB-INF/views/common/bootcss.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/bootjs.jsp"%>


<link rel="stylesheet" type="text/css" href="/css/member/pager.css">
<style>
label{
font-size: 14px; font-weight: 600; color: gray;}
ol,ul,li{list-style: none;}
</style>

<!-- 핸들바 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>


<!-- 출력결과 템플릿 -->
<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}} style="clear:both;margin-bottom:27px;">
<i class="fa fa-comments bg-blue"></i>
 <div class="timeline-item" style="border:1px solid lightgray;padding: 11px;">
  <span class="time" style="font-size: 13px;font-style: italic;color: gray;">
    <i class="fa fa-clock-o"></i>{{prettifyDate reply_regdate}}
  </span>
	<p class="replyer_ad" style="font-size:11px;">작성자: {{replyer}}</p>
	<input type="hidden" value="{{replyer}}" name="replyer_ad">
  <div class="timeline-body" style="font-size: 14px;margin-bottom: 20px;">{{reply_text}} </div>
	<div class="timeline-footer" style="margin-top:22px;">
		{{eqReplyer replyer rno}}
	</div>
  </div>
</li>
{{/each}}
</script>
<!-- 출력결과 템플릿 -->
<script>
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	//  printData(data.list, $("#repliesDiv") ,$('#template'));                       
	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr); //template(데이터)
		$(".replyLi").remove(); //수정이나 삭제 하기전의 원래 댓글목록을 제거해야 한다.
		target.after(html);

	}
	
	
	/* 
	 * 사용자 정의 헬퍼(eqReplyer)
	 * : 로그인 한 아이디와 리뷰의 아이디 확인 후, 수정/삭제 버튼 활성화 
	 */ 
	Handlebars.registerHelper("eqReplyer", function(replyer, rno) {
		var btnHtml = '';
		var mem_id = "${sessionScope.user.mem_id}";
		if (replyer == mem_id) {
			btnHtml = "<a class='btn btn-secondary btn-xs' data-toggle='modal' data-target='#modifyModal' style='color:white;font-size:11px;'>"
				  + "MODIFY</a>"
				  
		}
		return new Handlebars.SafeString(btnHtml);
		

	});
	

	var bno = ${boardVO.bno}; //부모글 게시물 번호
	
	var replyPage = 1;

	// 댓글 데이타를 불러와서 화면에 출력하는 기능
	function getPage(pageInfo){
		
		
		//replies/12/1
		$.getJSON(pageInfo,function(data){
			
			//댓글 목록을 출력하는 기능
			printData(data.list, $("#repliesDiv") ,$('#template'));
			//페이지 번호를 출력하는 기능
			printPaging(data.pageMaker, $(".pagination"));
			
			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount +" ]");
			
		});
	}


	// printPaging(data.pageMaker, $(".pagination"));
	var printPaging = function(pageMaker, target) {

		var str = "";

		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}

		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	};
	
	
	$(document).ready(function(){

	

	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();  // a 태그를 클릭시 진행되는 링크 기능을 무력화시킴.
		
		replyPage = $(this).attr("href");
		
		getPage("/replies/"+bno+"/"+replyPage);
		
	});
	

	$("#replyAddBtn").on("click",function(){
		
		
		 var replyer = $("#replyer").val();
		 var reply_text = $("#reply_text").val();
		 
		 
		 if(reply_text==null || reply_text==""){
			 alert("댓글을 입력해주세요.");
			 return false;
		 }
		
		  
		  $.ajax({
				type:'post',
				url:'/replies/',
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({bno:bno, replyer:replyer, reply_text:reply_text}),
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("댓글이 등록 되었습니다.");
						replyPage = 1;
						
						// bno : 부모게시물 번호 변수가 전역으로 선언 되어있음
						//alert("/replies/"+bno+"/"+replyPage);
						//댓글 데이타 불러오는 기능
						getPage("/replies/"+bno+"/"+replyPage );
						
						//replyerObj.val();
						//replytextObj.val();
						$("#reply_text").val('');
					}
			}});
	});

	//댓글목록에서 수정버튼 클릭시 팝업창 띄우는 기능.
	$(".timeline").on("click", ".replyLi", function(event){
		
		
		
		var reply = $(this);
		
		$("#reply_text").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));
		
	});
	
	

	$("#replyModBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var reply_text = $("#new_reply_text").val();
		  
		  if(reply_text==null || reply_text==""){
			  alert("수정할 내용을 입력해주세요.");
			  return false;
		  }
		  
		  $.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "PUT" },
				data:JSON.stringify({reply_text:reply_text}), 
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});

	$("#replyDelBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var reply_text = $("#reply_text").val();
		  
		  $.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "DELETE" },
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});
	

});	
</script>


<script>
$(document).ready(function(){
   
   // 게시물 조회, 댓글 목록 동시에 출력 
   getPage("/replies/"+bno+"/"+replyPage );
   
   var formObj = $("form[role='form']");
   
   console.log(formObj);
   
   $("#modifyBtn").on("click", function(){
      formObj.attr("action", "/board/modifyPage");
      formObj.attr("method", "get");      
      formObj.submit();
   });
   
   $("#removeBtn").on("click", function(){
      
      var result = confirm("게시물을 삭제하시겠습니까?");
      if(result){
         formObj.attr("action", "/board/removePage");
         formObj.submit();
      } else{}
      
   });
   
   $("#goListBtn ").on("click", function(){
      formObj.attr("method", "get");
      formObj.attr("action", "/board/list");
      formObj.submit();
   });
   
   
   // 로그인, 로그인한 사용자와 게시물 작성자가 같아야함
   $('#replyAddBtn_logout').on('click',function(){
	   alert("Q&A 게시물 작성 회원과 관리자만 답변 가능합니다.");
	   return;
   });
   

// 댓글작성자가 관리자일 경우.. name="replyer_ad"
if($('input[name=replyer_ad]').val()=='admin'){
	  
	  
	  $(this).prev().hide();
	  
}

   
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
      style="margin-top: 100px; ">

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

                     <h3 class="box-title">Q&A</h3>
                  </div>
                  <!-- /.box-header -->

                  <hr style="margin-bottom: 75px;">

                  <form role="form" action="/board/modifyPage" method="post">

                     <input type='hidden' name='bno' value="${boardVO.bno}"> 
                     <input type='hidden' name='page' value="${cri.page}"> 
                     <input type='hidden' name='perPageNum' value="${cri.perPageNum}">
                     <input type='hidden' name='searchType' value="${cri.searchType}">
                     <input type='hidden' name='keyword' value="${cri.keyword}">
                     
                     
                  </form>
            
                  <div class="box-body" style="text-align: left;">
                     <div class="form-group" style="display: inline-block;float: left;width: 400px;">
                        <label for="InputTitle">제목</label> <input type="text"
                           name='board_title' class="form-control" value="${boardVO.board_title}"
                           readonly="readonly">
                           
                     </div>
                     
                     <div class="form-group" style="display: inline-block;float: left;margin-left: 20px;">
                        <label for="InputWriter">작성자</label> <input
                           type="text" name="mem_id" class="form-control"
                           value="${boardVO.mem_id}" readonly="readonly">
                     </div>
                     
                     <div class="form-group" style="display: inline-block;float: left;margin-left: 20px;">
                        <label for="InputRegdate">작성일</label> 
                           
                           <span id="board_regdate" class="form-control" style="background-color: #e9ecef; opacity: 1;">
                              <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.board_regdate}" />
                           </span>
                     </div>
                     
                     <div class="form-group" style="clear: both;">
                        <label for="InputContent">내용</label>
                        <textarea style="max-height: 180px;" class="form-control" name="board_content" rows="3"
                           readonly="readonly">${boardVO.board_content}</textarea>
                     </div>

                  </div>
                  <!-- /.box-body -->

                  <div class="box-footer" style="clear: both;">
                     <button type="submit" class="btn btn-outline-dark" id="goListBtn" style="width: 130px;font-size: 11px;float: left;position:relative;">리스트로 돌아가기</button>
                     
                     <%-- 로그인한 사용자와 작성자의 아이디가 같을 때만 보여짐  --%>
                     <c:if test="${sessionScope.user.mem_id == boardVO.mem_id}">
                     <button type="submit" class="btn btn-secondary" id="removeBtn" style="float: right;font-size: 11px;margin-left: 10px;">삭제</button>
                     <button type="submit" class="btn btn-secondary" id="modifyBtn" style="margin-left: 10px;float: right;background-color: lightgray;color: white;border-color: lightgray;font-size: 11px;">수정</button>
                     </c:if>
                     
                  </div>

	<hr style="margin-top: 80px;margin-bottom: 40px;">


	<div class="row">
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Q&A REPLY</h3>
					<p style="font-size: 13px; margin-bottom: 40px; color: indianred;">Q&A 게시물 작성 회원과 관리자만 답변 가능합니다.</p>
				</div>
				<div class="box-body" style="text-align: left;">
					
					<%-- 로그아웃  --%>
                    <c:if test="${sessionScope.user!=null}">
					<label for="replyer">작성자</label> 
					<input style="width: 200px;margin-bottom: 25px;" class="form-control" type="text" id="replyer" value="${sessionScope.user.mem_id}" readonly="readonly"> 
					</c:if>
					
					<label for="replyText">댓글</label> 
					<textarea style="max-height: 180px;" class="form-control" id="reply_text" rows="3"></textarea>
					
					<%--<input class="form-control" type="text" id="reply_text"> --%>
				
					

				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					
					
					<%-- 로그아웃  --%>
                    <c:if test="${empty sessionScope.user || sessionScope.user.mem_id!=boardVO.mem_id}">
					<button type="button" class="btn btn-secondary" id="replyAddBtn_logout" style="float: right;font-size: 11px;margin: 10px 0;">댓글 등록</button>
					</c:if>
				
					<%-- 로그인, 로그인한 세션정보와 게시글 작성자가 같아야함 --%>
                    <c:if test="${sessionScope.user != null && sessionScope.user.mem_id==boardVO.mem_id}">
					<button type="button" class="btn btn-secondary" id="replyAddBtn" style="float: right;font-size: 11px;margin: 10px 0;">댓글 등록</button>
					</c:if>
				
				</div>
				
			</div>

		
		<!-- The time line 댓글 목록 출력되는 위치 -->
		<ul class="timeline" style="padding: 0;">
		  <!-- timeline time label -->
		<li class="time-label" id="repliesDiv" style="margin-top: 70px; margin-bottom: 10px;">
		  <span class="bg-green" style="font-size: 14px;">
		    Q&A 댓글 <small id='replycntSmall'> [ ${boardVO.board_replycnt} ] </small>
		    </span>
		  </li>
		  <!-- 댓글목록 삽입위치 -->
		</ul>
		   
		   
		   
		   
			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->


          
<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      	<h4 class="modal-title" style="display: none;"></h4>
      </div>
      <div class="modal-body" data-rno>
        <p><input type="text" id="new_reply_text" class="form-control"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="replyDelBtn">Delete</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>   

               </div>
               <!-- /.box -->
            </div>
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