<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>

	<c:if test="${param.fail eq true}">
		<div class="alert alert-danger">Failed to create new document</div>
	</c:if>
	
	<c:if test="${param.success eq true}">
		<div class="alert alert-success">Document Removed</div>
	</c:if>

<h1><c:out value="${user.name}" /></h1>

<script type="text/javascript">
$(document).ready(function() {
	$(".triggerDelete").click(function(e) {
		e.preventDefault();
		$("#modalDeleteDoc .deleteBtn").attr("href", $(this).attr("href"));
		$("#modalDeleteDoc").modal();
	});
});
</script>

<br>

<div role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs">
  	<c:forEach items="${user.documents}" var="document">
  		 <li><a href="#document_${document.id}" data-toggle="tab">${document.type}</a></li>
  	</c:forEach>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home"></div>
  </div>

</div>
	
	<br><br>

	<table class="table table-bordered table-hover table-striped">
		<thead>
			<tr>
				<th>Document Name</th>
				<th>Type</th>
				<th>Date</th>
				<th>To Who:</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach items="${user.documents}" var="document">
					<tr>
						<td><c:out value="${document.name}" /></td>
						<td><c:out value="${document.type}" /></td>
						<td><c:out value="${document.date}" /></td>
						<td><c:out value="${document.reciever}" /></td>
						<td><a href="<spring:url value="/document/remove/${document.id}.html" />" class="btn btn-danger triggerDelete">delete</a></td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
	
	<!-- Modal -->
<div class="modal fade" id="modalDeleteDoc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Delete document</h4>
      </div>
      <div class="modal-body">
       Are you sure to delete this document?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <a href="" class="btn btn-danger deleteBtn">Delete</a>
      </div>
    </div>
  </div>
</div>
