<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>

	<c:if test="${param.fail eq true}">
		<div class="alert alert-danger">Failed to create new document</div>
	</c:if>
	
	<c:if test="${param.success eq true}">
		<div class="alert alert-success">Document Removed</div>
	</c:if>
	
	<c:if test="${param.wrongUser eq true}">
		<div class="alert alert-danger">You are not permitted to delete this document</div>
	</c:if>
	
<script type="text/javascript">
$(document).ready(function() {
	$(".triggerDelete").click(function(e) {
		e.preventDefault();
		$("#modalDeleteDoc .deleteBtn").attr("href", $(this).attr("href"));
		$("#modalDeleteDoc").modal();
	});
	$(".documentForm").validate(
			{
				rules: {
					name: {
						required : true,
						minlength : 1
					},
					reciever: {
						required : true,
					}
				},
				highlight: function(element) {
					$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
				},
				unhighlight: function(element) {
					$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
				}
			}			);
});
</script>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  New Document
</button>

	<form:form commandName="document" cssClass="form-horizontal documentForm" method="post" action="/myDocuments.html" enctype="multipart/form-data">
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">New Document</h4>
      </div>
      <div class="modal-body">
      
		<div class="form-group">
			<label for="reciever" class="col-sm-2 control-label">To Who:</label>
  				<select class="form-control" name="reciever">
  					<c:forEach items="${users}" var="usersList">
  						<option value="${usersList.id}" id="listOption">${usersList.firstName} ${usersList.lastName}</option>
  					</c:forEach>
  				</select>
		</div>
		
		<br><br>
		<div class="form-group">
			<label for="description" class="col-sm-2 control-label">Description:</label>
			<div class="col-sm-10">
				<form:input path="description" cssClass="form-control" />
				<form:errors path="description" />
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-10">
				Editable: <form:checkbox path="editable"/>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-2">
				<label for="file-to-add" class="col-sm-2 control-label">File</label>
				<input type="file" name="file" id="file" />
			</div>
		</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <input type="submit" class="btn btn-primary" value="Save">
      </div>
    </div>
  </div>
</div>
</form:form>

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

	<h1>Documents Sent by Me</h1>
	<table class="table table-bordered table-hover table-striped">
		<thead>
			<tr>
				<th>Document Name</th>
				<th>Description</th>
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
						<td><c:out value="${document.description}" /></td>
						<td><c:out value="${document.type}" /></td>
						<td><c:out value="${document.date}" /></td>
						<td><c:out value="${users[document.reciever-1].firstName} ${users[document.reciever-1].lastName}" /></td>
						<td>
							<a href="<spring:url value="/document/download/${document.id}.html" />" class="btn btn-success ">download</a>
							<c:if test="${document.editable eq true}">
								<a href='<spring:url value="/document/remove/${document.id}.html" />' class="btn btn-primary ">
									edit
								</a>
							</c:if>
							<a href="<spring:url value="/document/remove/${document.id}.html" />" class="btn btn-danger triggerDelete ">delete</a>
						</td>
						</tr>
				</c:forEach>
	</table>
	
	<h1>Documents Sent to Me</h1>
	<table class="table table-bordered table-hover table-striped">
		<thead>
			<tr>
				<th>Document Name</th>
				<th>Description</th>
				<th>Type</th>
				<th>Date</th>
				<th>From</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
	
	<c:forEach items="${user.documentstoMe}" var="documentToMe">
					<tr>
						<td><c:out value="${documentToMe.name}" /></td>
						<td><c:out value="${documentToMe.description}" /></td>
						<td><c:out value="${documentToMe.type}" /></td>
						<td><c:out value="${documentToMe.date}" /></td>
						<td><c:out value="${users[documentToMe.sender-1].firstName} ${users[documentToMe.sender-1].lastName}" /></td>
						<td>
							<a href="<spring:url value="/document/download/${documentToMe.id}.html" />" class="btn btn-success ">download</a>
							<c:if test="${documentToMe.editable eq true}">
								<a href='<spring:url value="/document/remove/${documentToMe.id}.html" />' class="btn btn-primary ">
									edit
								</a>
							</c:if>
							<a href="<spring:url value="/document/remove/${documentToMe.id}.html" />" class="btn btn-danger triggerDelete ">delete</a>
						</td>
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