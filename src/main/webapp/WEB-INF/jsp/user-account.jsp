<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>

	<c:set var="number1" value="0"/>
	<c:forEach items="${user.documents}" var="document">
  		 <c:set var="number1" value="${number1 + 1}"/>
  	</c:forEach>
  	
  	<c:set var="number2" value="0"/>
	<c:forEach items="${user.documentstoMe}" var="document">
  		 <c:set var="number2" value="${number2 + 1}"/>
  	</c:forEach>
  	
  	<table class="table table-bordered table-hover table-striped">
		<thead>
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Login</th>
				<th>Number of files sent by user</th>
				<th>Number of files sent to user</th>
				<th>Total</th>
			</tr>
		</thead>
		<tbody>
					<tr>
						<td><c:out value="${user.firstName}" /></td>
						<td><c:out value="${user.lastName}" /></td>
						<td><c:out value="${user.email}" /></td>
						<td><c:out value="${user.name}" /></td>
						<td><c:out value="${number1}" /></td>
						<td><c:out value="${number2}" /></td>
						<td><c:out value="${number1 + number2}" /></td>
					</tr>
		</tbody>
	</table>