<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Mail.Book &mdash; Website Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/fonts/icomoon/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-datepicker.css">
    
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/fonts/flaticon/font/flaticon.css">
  
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/aos.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.fancybox.min.css">
    

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    
  </head>
  <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">
	<%
	//레벨 2 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>

	<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
	%>
	
	<%
	//수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.printf("noticeNo: %s<updateNoticeOneForm.jsp>\n",noticeNo);
	//dao연결
	Notice n= NoticeDao.selectNoticeOne(noticeNo);
	%>
  <!-- 전체를 감싸는-->
  <div class="site-wrap">
  
   	<!-- 0메뉴바 div -->
	<!-- 모바일버전. 안채워둠 -->
    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div> <!-- .site-mobile-menu -->
    
    <!-- 데스크탑버전. -->
    <div class="site-navbar-wrap">
      <div class="site-navbar site-navbar-target js-sticky-header">
        <div class="container">
          <div class="row align-items-center">
          	<!-- 메뉴바 2개 div -->
           	<!-- 왼쪽 로고 div -->
            <div class="col-6 col-md-4 half">
              <h1 class="my-0 site-logo"><a href="<%=request.getContextPath()%>/adminIndex.jsp">Mail<span class="text-primary">.</span>book</a></h1>
            </div>
         	<!-- 오른쪽 버튼 div -->
            <!-- 관리자화면 메뉴(네비게이션) include -->
	   			<jsp:include page="<%=request.getContextPath()%>/inc/adminMenu.jsp"></jsp:include>
          </div>
        </div>
      </div>
    </div> <!-- END .site-navbar-wrap --> 
	
	<!-- 페이지 -->
	  <div class="site-blocks-cover" id="home-section">
	      <div class="container">
	        <div class="row">
	          <div class="col-md-12 ml-auto align-self-center">
	            
	            <div class="intro">
	              <div class="text">
	              	<h1><span class="text-primary">카테고리</span> 목록</h1>
	                <br>
	                <div class="TR">
	                 <a class="btn btn-primary" href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp">카테고리 추가</a>
	          
	                </div>
	                <br>
	              </div> 
	             </div>
	             
				<!-- 글 전체 -->		       
				<div class="d-flex">   
				<!-- 1 테이블 -->  
	<form action="<%=request.getContextPath()%>/notice/updateNoticeOneAction.jsp" method="post">
	<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
		<table border="1">
			<tr>
				<th>managerId</th>
				<td><%=n.getManagerId()%></td>
			</tr>
			<tr>
				<th>noticeDate</th>
				<td><%=n.getNoticeDate()%></td>
			</tr>
			<tr>
				<th>noticeTitle</th>
				<td><input type="text" name="noticeTitle" value="<%=n.getNoticeTitle()%>"></td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td><textarea rows="5" cols="80" name="noticeContent"><%=n.getNoticeContent()%></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>