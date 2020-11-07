
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
	
<%-- 로그인 안 한 상태 --%>
<c:if test="${sessionScope.user == null}">
<nav class="navbar navbar-expand-lg navbar-dark bg-white fixed-top">
	<div class="container">
		
		
		<a class="navbar-brand" href="/">
			<img src="/img/prinha_logo_p.png" class="main_logo_img" alt="main_logo">
		</a>

		
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target=".navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse navbarResponsive" id="">
			<ul class="navbar-nav ml-auto">
			
			
				<li class="nav-item dropdown shop drop1"> <!-- 드롭다운 메뉴--> 
					<a class="nav-link dropdown-toggle bar_category2" href="/product/list?cate_code=1000" data-toggle="dropdown" style="color:red;"> SHOP </a> 
				
					<div class="dropdown-menu drop2">
						
						<c:forEach items="${userCategoryList}" var="list"> 
							<a class="dropdown-item mainCategory" href="/product/list?cate_code=${list.cate_code}"><c:out value="${list.cate_name}" /></a> 
							
						</c:forEach>
						
					</div> 
				</li>


				<li class="nav-item nodrop"><a class="bar_category" href="/member/login">LOGIN</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/member/join">JOIN</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/board/list">Q&A</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/member/login">CART</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/member/login">ORDER</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/member/login">MY PAGE</a></li>
				
				
				<!-- 드롭다운 메뉴--> 
				<!-- 
				<li class="nav-item dropdown community drop1"> 
					<a class="nav-link dropdown-toggle bar_category2 community bar_category" href="#" data-toggle="dropdown"  style="color:#444444;">COMMUNITY</a> 
				
					<div class="dropdown-menu drop2"> 
						
						<a class="dropdown-item" href="#">Q&A</a> 
						<a class="dropdown-item" href="#">REVIEW</a> 
					</div> 
				</li>
				-->
				<%@include file="/WEB-INF/views/common/navSearch.jsp"%>
				
			</ul>
		</div>
		
		
	</div>
</nav>
</c:if>


<%-- 로그인 한 상태 --%>
<c:if test="${sessionScope.user != null}">
	<nav class="navbar navbar-expand-lg navbar-dark bg-white fixed-top">
	<div class="container">
		
		
		<a class="navbar-brand" href="/">
			<img src="/img/prinha_logo_p.png" class="main_logo_img" alt="main_logo">
		</a>

		
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target=".navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse navbarResponsive" id="">
			<ul class="navbar-nav ml-auto">

				<li class="nav-item dropdown shop drop1"> <!-- 드롭다운 메뉴--> 
					<a class="nav-link dropdown-toggle bar_category2" href="/product/list?cate_code=1000" data-toggle="dropdown" style="color:red;"> SHOP </a> 
				
					<div class="dropdown-menu drop2"> 
						
						<c:forEach items="${userCategoryList}" var="list"> 
							<a class="dropdown-item" href="/product/list?cate_code=${list.cate_code}"><c:out value="${list.cate_name}" /></a> 
							
						</c:forEach>
						
					</div> 
				</li>


				<li class="nav-item nodrop"><a class="bar_category" href="/member/logout">LOGOUT</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/board/list">Q&A</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/cart/list">CART</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/order/list">ORDER</a></li>
				<li class="nav-item nodrop"><a class="bar_category" href="/member/myPage">MY PAGE</a></li>
				
				
				
				<!-- 드롭다운 메뉴--> 
				<!--
				<li class="nav-item dropdown community drop1"> 
					<a class="nav-link dropdown-toggle bar_category2 community" href="#" data-toggle="dropdown" style="color:#444444;">COMMUNITY</a> 
				
				
					 <div class="dropdown-menu drop2"> 
						
						<a class="dropdown-item" href="#">Q&A</a> 
						<a class="dropdown-item" href="#">REVIEW</a> 
					</div> 
					 
				</li>
				-->
				
				<%@include file="/WEB-INF/views/common/navSearch.jsp"%>
				
			</ul>
		</div>
		
		
	</div>
</nav>
</c:if>
