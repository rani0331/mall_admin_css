<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
	<!-- 보안코드 넣기 -->
	<%
	System.out.println("\n----------EbookOne.jsp 실행----------");
	
	// 세션 검사 관리자 권한 1 이상만 볼 수 있도록.
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//수집
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.printf("ebookISBN: %s<ebookOne.jsp>\n",ebookISBN);
		
	
	//dao연결
	Ebook e = EbookDao.selectEbookOne(ebookISBN);
	System.out.println("\t"+e.getEbookISBN()+"<----ebookISBN");
	System.out.println("\t"+e.getEbookState()+"<----ebookState");
	System.out.println("\t"+e.getEbookSummary()+"<----ebookSummary");

	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookOne</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div><!-- 인클루드는 프로젝트 명이 필요없다 -->

	<h1>ebookOne</h1>
	<table border="1">
		<tr>
			<th>ebookNO</th>
			<td><%=e.getEbookNo()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>categoryName</th>
			<td><%=e.getCategoryName()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookTitle</th>
			<td><%=e.getEbookTitle()%></td>
			<td>&nbsp;</td>
		</tr>
		<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp">
			<tr>
				<th>ebookState</th>
				<td>
				<%=e.getEbookState()%> : 
				<input type="hidden" value="<%=ebookISBN%>" name="ebookISBN">
				<select name="ebookState">
						<option value="판매중">판매중</option>
						<option value="품절">품절</option>
						<option value="절판">절판</option>
						<option value="구편절판">구편절판</option>
				</select>
				</td>
				<td>
					<button type="submit">책상태 수정</button>
				</td>
			</tr>
		</form>
		<tr>
			<th>ebookAuthor</th>
			<td><%=e.getEbookAuthor()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookImg</th>
			<td><img width="125px" height="150px" src="<%=request.getContextPath()%>/img/<%=e.getEbookImg()%>"></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=e.getEbookISBN()%>">
					<button type="button">이미지 수정</button>
				</a>
			</td>
		</tr>
		<tr>
			<th>ebookISBN</th>
			<td><%=e.getEbookISBN()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookCompany</th>
			<td><%=e.getEbookCompany()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookDate</th>
			<td><%=e.getEbookDate()%></td>
			<td>&nbsp;</td>
		</tr>
		<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp">
			<tr>
				<th>ebookSummary</th>
				<td>
				<input type="hidden" value="<%=e.getEbookISBN()%>" name="ebookISBN">
				<textarea cols="50", rows="5" name="ebookSummary"><%=e.getEbookSummary()%></textarea>
				</td>
				<td>
					<button type="button">책요약 수정</button>
				</td>
			</tr>
		</form>
		<tr>
			<th>ebookPrice</th>
			<td><%=e.getEbookPrice()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookPageCount</th>
			<td><%=e.getEbookPageCount()%></td>
			<td>&nbsp;</td>
		</tr>
	</table>
	
	<button type="button">
	<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=e.getEbookISBN()%>">
		전체 수정(이미지 제외)
	</a>
	</button>
	
	<button type="button">	
	<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=e.getEbookISBN()%>">
		삭제
	</a>
	</button>
</body>
</html>