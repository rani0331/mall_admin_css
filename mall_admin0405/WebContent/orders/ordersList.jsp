<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*" %>

<%@ page import="java.util.*" %>

	<%
	System.out.println("\n----------Orderist.jsp 실행----------");

	//레벨 2 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	    
	<%
	// 현재페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.println("-----커렌트 페이지 : "+currentPage);
	}
	
	// 페이지당 수
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println("-----로우퍼 페이지 : "+rowPerPage);
	}
		
	//시작
	int beginRow = (currentPage -1) *rowPerPage ;
		
	
	%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오더리스트</title>
</head>
<body>
	<!-- 3. 출력 -->
	<h1>order List</h1>
	<!-- 상단바 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<br>
	
	<!-- 상단 몇개씩보기 -->
	
	<form action="<%=request.getContextPath()%>/order/orderList.jsp" method="post">
		<select name="rowPerPage">
			<%
			for (int i=10; i <=30; i+=5){
				if(rowPerPage == i){
			%>
					<option value="<%=i %>" selected="selected"> <%=i %></option>
			<%
				} else {
			%>
					<option value="<%=i %>"> <%=i %></option>
			<%
				}//if끝
			}//for끝
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<!--  row Per Page별 페이징 -->
	<table border="1">
		<thead>
			<th>orderNo</th>
			<th>(ebookNo) ebookTitle [ebookISBN]</th>
			<th>(clientNo) clientMail</th>
			<th>orderDate</th>
			<th>orderState수정</th>
		</thead>
		
		<tbody>
			<%
			//String searchWord ="";
			//public static ArrayList<Ebook> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception { //입력값 필요 없음
			ArrayList<OrdersAndEbookAndClient> ordersList = OrdersDao.selectOrdersListByPage(beginRow,rowPerPage);

				for(OrdersAndEbookAndClient oec : ordersList){
				System.out.println(oec.getOrders().getOrdersNo()+"<---주문번호");
			%>
				<tr>
					<td><%=oec.getOrders().getOrdersNo()%></td>
					<td>
					
					<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>">
					(<%=oec.getOrders().getEbookNo()%>) <%=oec.getEbook().getEbookTitle()%>  [﻿<%=oec.getEbook().getEbookISBN()%>]
					</a>
					</td>
					<td>(<%=oec.getOrders().getClientNo()%>) <%=oec.getClient().getClientMail()%></td>
					<td><%=oec.getOrders().getOrdersDate()%></td>
					<td>
						<form action="<%=request.getContextPath()%>/orders/updateOrdersAction.jsp" method="post">
						<%=oec.getOrders().getOrdersState()%>
						
						<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo()%>">
						<select name="orderState">
							<option value="결제확인">결제확인</option>
							<option value="배송완료">배송완료</option>
							<option value="주문요청">취소요청</option>
							<option value="취소완료">취소완료</option>
						</select>
						<button type="submit">승인</button>
						</form>
					</td>
				</tr>
			<%
				}//for끝
			%>
		</tbody>
	</table>
	<!-- 페이징 -->
		
	
		<%
		if(currentPage > 1){//현재 페이지가 1보다 크면 이전이 나오게 해라.
		%>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
		<%      
		}//이전 if 끝
		%>
		      
		      
		<%
		int totalRow = OrdersDao.totalCount(); //메서드활용
		int lastPage = totalRow/rowPerPage;
		System.out.println("\t total Row : "+ totalRow);
		System.out.println("\t last Page : "+ lastPage);
		        
		    
		if (totalRow% rowPerPage !=0){ //현재 페이지가 전체게시글/페이지행 몫이 딱 떨어지거나. 몫보다 클때.
			lastPage += 1;  // 잘안씀 lastPage - lastPage+1; lastPage++
		}//보드 케이블의 총 행수 구하는 if 끝
		         
		if(currentPage<lastPage) {//현재 페이지가 라스트 페이지보다 작으면 다음이 나오게 해라.
		%>
		
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
		
		<% 
		}//다음 if끝
		%>
</body>
</html>