<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> 
<script type="text/javascript"> 
google.charts.load('current', {'packages':['corechart']}); 
google.charts.setOnLoadCallback(drawChart); 
google.charts.setOnLoadCallback(drawChart2); 
function drawChart() { 
	var data = google.visualization.arrayToDataTable([ 
		['날짜', '주문 수']${result}
		
		]); 
	var options = {
			
	          title: '일자별 주문 수',
	          seriesType: 'bars'
	          //series: {2: {type: 'line'}}
	        };
    var chart = new google.visualization.ComboChart(document.getElementById('curve_chart'));
    chart.draw(data, options);
	} 
	
function drawChart2() { 
	var data = google.visualization.arrayToDataTable([ 
		['날짜', '매출']${result2}
		
		]); 
	var options = {
			
	          title: '일자별 매출 금액',
	          legend: 'none',
	          hAxis: { maxValue: 7 },
	          vAxis: { maxValue: 13 },
	          lineWidth: 10,
	          colors: ['#b9c246']
	          //series: {2: {type: 'line'}}
	        };
    var chart = new google.visualization.LineChart(document.getElementById('revenue_chart'));
    chart.draw(data, options);
	} 
</script>

<head>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">

<title>admin main</title>


<!-- AdminLTE 2 header plug-in -->
<%@include file="/WEB-INF/views/common/admin/header_plugin.jsp"%>

<!-- Bootstrap core JavaScript -->
<%@include file="/WEB-INF/views/common/admin/bootjs.jsp"%>

<link rel="canonical" href="https://getbootstrap.com/docs/3.4/examples/signin/">

<script>

if("${msg}"=="ADMIN_LOGIN_SUCCESS"){
		alert("로그인 되었습니다.\n환영합니다!");
	} 

</script>

</head>

<body class="hold-transition skin-blue sidebar-mini">


<%-- 로그아웃 상태 --%>
 <c:if test="${sessionScope.admin == null}">
	<script>
		alert("관리자만 접근 가능합니다. \n로그인 해주세요.");
		location="/admin/loginMain";
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
				<h1 style="display: inline-block;">
					Prinha Admin Page <small style="font-size: 13px;">쇼핑몰 관리자 페이지</small>
				</h1>
				
				<p style="display: inline-block;font-size: 14px;color: indianred;font-weight: 600;">&nbsp;&nbsp;[ 오늘 방문자수 : ${sessionScope.todayCount}명 / 누적 방문자수 : ${sessionScope.totalCount}명 ]</p>
				
			</section>

			
			<section class="content container-fluid">
			

	<!-- Small boxes (Stat box) -->
      <div class="row">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>${todayOrders}</h3>

              <p>Today Orders</p>
            </div>
            <div class="icon">
              <i class="ion ion-bag"></i>
            </div>
           
          </div>
        </div>
        <!-- ./col -->
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>${todayUser}</h3>

              <p>Today User Registrations</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
           
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>${todayQna}</h3>

              <p>Today Q&A</p>
            </div>
            <div class="icon">
              <i class="ion ion-stats-bars"></i>
            </div>
           
          </div>
        </div>
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>${todayReview}</h3>

              <p>Today Review</p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
           
          </div>
        </div>
        <!-- ./col -->
      </div>
      <!-- /.row -->
			
		
		<div class="main_chart" style="position: relative;">
		<!-- 날짜별 주문수 -->
		<div id="curve_chart" style="width: 48%;height: 350px;display: inline-block;margin-right: 2%;"></div>
		
		<!-- 날짜별 매출금액 -->
		<div id="revenue_chart" style="width: 48%;height: 350px;display: inline-block;"></div>
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