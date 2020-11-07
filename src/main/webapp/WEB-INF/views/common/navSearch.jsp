<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

				<!-- 검색 -->
				<form action="/product/listSearch" method="get" class="sidebar-form" style="margin-left: 10px;">
					<div class="input-group">
						<input type="hidden" name="searchType" class="form-control" value="name_detail">
						<input type="text" name="keyword" class="form-control" placeholder="상품 검색"  
							<c:if test="${!empty scri}">
								value="<c:out value='${scri.keyword}' />"
							</c:if>
							style="background-color: white; color:#B8C7CE;width: 130px;height: 33px;font-size: 13.5px;">
						<span class="input-group-btn">
							<button type="submit" name="search" id="search-btn" class="btn btn-flat" style="background-color: #444444;width: 52px;height: 33px;margin-left: 
							5px;position: relative;">
								<i class="fa fa-search" style="color:white;font-size: 13.5px;position: absolute;top:5.5px;left:10px;">검색</i>
							</button>
						</span>
					</div>
				</form>