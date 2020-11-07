<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<header class="main-header">
	<!-- Logo -->
	<a href="/admin/main" class="logo">
			<span class="logo-mini"></span> <!-- logo for regular state and mobile devices --> 
		<span class="logo-lg">
			<img src="/img/prinha_logo_pw.png" class="main_logo_img" alt="main_logo" style="width: 100px;">
		</span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top" role="navigation" style="background-color: #96c7ed;">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"> <span class="sr-only" >Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				
						<li class="dropdown user user-menu"> 
							<p class="hidden-xs" style="color:white; margin-top:14px;">
								최근 접속 시간: 
								<fmt:formatDate value="${sessionScope.admin.admin_last_login}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</p>
						</li>
						<li class="dropdown user user-menu"> 
							<p class="hidden-xs" style="color:white; margin-top:14px; margin-left:15px; margin-right:15px;">
								${sessionScope.admin.admin_name}님
							</p>
						</li>
						<li class="dropdown user user-menu">
							<a href="/admin/logout" onclick="return confirm('로그아웃하시겠습니까?');"> 
								<span class="hidden-xs">로그아웃</span>
							</a>
						</li>		
	
				<!-- Control Sidebar Toggle Button -->
	
				
			</ul>
		</div>
	</nav>
	
	
	
</header>    