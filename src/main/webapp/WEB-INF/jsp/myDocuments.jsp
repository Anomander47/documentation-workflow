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
	$(".triggerDocumentEdition").click(function(e) {
		e.preventDefault();
		Id = this.id;
		$("#editDocForm .nameHolder").attr("placeholder", $("#varName"+Id).val());
		$("#editDocForm .descriptionHolder").attr("placeholder", $("#varDescription"+Id).val());
		$("#modalEditDoc").modal();
	});
	$(".editDocumentButton").click(function(e) {
		if($('#nameInput').val() == ''){
			$('#nameInput').val($("#varName"+Id).val());
		   }
		if($('#descriptionInput').val() == ''){
			$('#descriptionInput').val($("#varDescription"+Id).val());
		   }
		$("#docId").val(Id);
		$("#docDescription").val($("#descriptionInput").val());
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
	
	<br><br>

	<h1>Documents Sent by Me</h1>
	<table class="table table-bordered table-hover table-striped">
		<thead>
			<tr>
				<th>Document Name</th>
				<th>Description</th>
				<th>Date</th>
				<th>Last edited</th>
				<th>To Who:</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach items="${user.documents}" var="document">
					<tr>
						<td><c:out value="${document.name}" /></td>
						<td><c:out value="${document.description}" /></td>
						<td><c:out value="${document.date}" /></td>
						<td><c:out value="${document.lastEdited}" /></td>
						<td><c:out value="${users[document.reciever-1].firstName} ${users[document.reciever-1].lastName}" /></td>
						<td>
							<a href="<spring:url value="/document/download/${document.id}.html" />" class="btn btn-success ">download</a>
							<c:if test="${document.editable eq true}">
								<a href='<spring:url value="/document/edit/${document.id}.html" />' id="${document.id}" class="btn btn-primary triggerDocumentEdition ">
									<input id="varName${document.id}" value="${document.name}" type="hidden"/>
									<input id="varDescription${document.id}" value="${document.description}" type="hidden"/>
									<input id="varSender${document.id}" value="${document.sender}" type="hidden"/>
									<input id="varReciever${document.id}" value="${document.reciever}" type="hidden"/>
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
				<th>Date</th>
				<th>Last edited</th>
				<th>From</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
	
	<c:forEach items="${user.documentstoMe}" var="documentToMe">
					<tr>
						<td><c:out value="${documentToMe.name}" /></td>
						<td><c:out value="${documentToMe.description}" /></td>
						<td><c:out value="${documentToMe.date}" /></td>
						<td><c:out value="${documentToMe.lastEdited}" /></td>
						<td><c:out value="${users[documentToMe.sender-1].firstName} ${users[documentToMe.sender-1].lastName}" /></td>
						<td>
							<a href="<spring:url value="/document/download/${documentToMe.id}.html" />" class="btn btn-success ">download</a>
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

<form:form id="editDocForm" commandName="editDocument" cssClass="form-horizontal documentForm" method="post" action="/editDocument.html" enctype="multipart/form-data">
<!-- Modal -->
<div class="modal fade" id="modalEditDoc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body">
      
      <input id="docId" name="docId" value="" type="hidden"/>
      <input id="docDescription"  name="docDescription" value="" type="hidden"/>
      
		<div class="form-group">
			<label for="reciever" class="col-sm-2 control-label">To Who:</label>
  				<select class="form-control" name="reciever">
  				<option value="${user.id}" id="listOption">Copy for me</option>
  					<c:forEach items="${users}" var="usersList">
  					<c:if test="${user.id != usersList.id}">
  					<option value="${usersList.id}" id="listOption">${usersList.firstName} ${usersList.lastName}</option>
					</c:if>
  					</c:forEach>
  				</select>
		</div>
		
		<br><br>
		<div class="form-group">
			<label for="description" class="col-sm-2 control-label">Description:</label>
			<div class="col-sm-10">
				<form:input path="description" id="descriptionInput" cssClass="form-control descriptionHolder" placeholder="" />
				<form:errors path="description" />
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
        <input type="submit" class="btn btn-primary editDocumentButton" value="Save">
      </div>
    </div>
  </div>
</div>
</form:form>