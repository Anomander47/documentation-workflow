<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>

<h1>Sent documents</h1>
<table class="table table-bordered table-hover table-striped">
	<thead>
		<tr>
			<th>Event</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${history}" var="history">
			<tr>
				<c:if test="${history.sentPost != null}">
				<td>
						<c:out value="${history.sentPost}" />
				</td>
				
				<td>
						<c:out value="${history.date}" />
				</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>

<h1>Deleted documents</h1>
<table class="table table-bordered table-hover table-striped">
	<thead>
		<tr>
			<th>Event</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${history}" var="history">
			<tr>
				<c:if test="${history.deletePost != null}">
				<td>
						<c:out value="${history.deletePost}" />
				</td>
				
				<td>
						<c:out value="${history.date}" />
				</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>

<h1>Edited documents</h1>
<table class="table table-bordered table-hover table-striped">
	<thead>
		<tr>
			<th>Event</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${history}" var="history">
			<tr>
				<c:if test="${history.editPost != null}">
				<td>
						<c:out value="${history.editPost}" />
				</td>
				
				<td>
						<c:out value="${history.date}" />
				</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>