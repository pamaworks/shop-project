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

<title>admin Q&A readPage</title>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>
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
		var mem_id = "${sessionScope.admin.admin_id}";
		if (replyer == mem_id) {
			btnHtml = "<a class='btn btn-danger btn-xs' data-toggle='modal' data-target='#modifyModal' style='font-size: 14px;width: 80px;'>"
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
	

	// ReplyController -> 사용자와 같이
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

   
   $("#removeBtn").on("click", function(){
      
      var result = confirm("게시물을 삭제하시겠습니까?");
      if(result){
         formObj.attr("action", "/admin/board/removePage");
         formObj.submit();
      } else{}
      
   });
   
   $("#goListBtn ").on("click", function(){
      formObj.attr("method", "get");
      formObj.attr("action", "/admin/board/list");
      formObj.submit();
   });
   
   

});
</script>
<style>
.box-footer{
	border:none;
}
</style>
</head>



<body class="hold-transition skin-blue sidebar-mini">

	
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
						Prinha Admin Page <small style="font-size: 13px;"> 고객 문의 </small>
					</h1>
				</section>


				<section class="content container-fluid">
					<div class="row">
					<div class="col-md-12">
					
			
						<div class="box box-primary">
						
						<form role="form" action="/board/modifyPage" method="post">

                     <input type='hidden' name='bno' value="${boardVO.bno}"> 
                     <input type='hidden' name='page' value="${cri.page}"> 
                     <input type='hidden' name='perPageNum' value="${cri.perPageNum}">
                     <input type='hidden' name='searchType' value="${cri.searchType}">
                     <input type='hidden' name='keyword' value="${cri.keyword}">
                     
                     
                  </form>
            
            	<div class="box-header">
					<h3 class="box-title">Q&A</h3>
					
				</div>
            
            	  <!-- box body -->
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
						
						
					
				 <!-- box footer -->		
				 <div class="box-footer" style="clear: both;margin-top: -20px;">
                     <button type="submit" class="btn btn-outline-dark" id="goListBtn" style="width: 130px;font-size: 11px;float: left;position:relative;">리스트로 돌아가기</button>
                     
                   
                     <button type="submit" class="btn btn-secondary" id="removeBtn" style="float: right;font-size: 11px;margin-left: 10px;">삭제</button>
                   
                     
                  </div>
                  
                  
                 
	<!-- 댓글 -->
	<div class="row" style="margin-top: 45px;">
		<div class="col-md-12">

			<div class="box box-success" style="padding-bottom: 50px;">
				<div class="box-header">
					<h3 class="box-title">Q&A REPLY</h3>
					
				</div>
				<div class="box-body" style="text-align: left;">
					
					
					<label style="display: none;" for="replyer">작성자</label> 
					<input style="width: 200px;margin-bottom: 25px;" class="form-control" type="hidden" id="replyer" value="${sessionScope.admin.admin_id}" readonly="readonly"> 
					
					
					<label for="replyText">답변등록</label> 
					<textarea style="max-height: 180px;" class="form-control" id="reply_text" rows="3"></textarea>
					
					<%--<input class="form-control" type="text" id="reply_text"> --%>
				
					

				</div>
				<!-- /.box-body -->
				<div class="box-footer" style="margin-top: -5px;">					
					<button type="button" class="btn btn-secondary" id="replyAddBtn" style="float: right;font-size: 11px;">등록</button>
					
				</div>
				
			</div>

		
		<!-- The time line 댓글 목록 출력되는 위치 -->
		<ul class="timeline" style="width: 90%;margin: 0 auto;margin-bottom: 30px;padding: 0;">
		  <!-- timeline time label -->
		<li class="time-label" id="repliesDiv" style="margin-top: 70px; margin-bottom: 10px;">
		  <span class="bg-green" style="font-size: 15px;">
		    Q&A 댓글 <small id='replycntSmall'> [ ${boardVO.board_replycnt} ] </small>
		    </span>
		  </li>
		  <!-- 댓글목록 삽입위치 -->
		</ul>
		   
		   
		   
		   
			<div class='text-center' style="margin-bottom: 50px;">
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