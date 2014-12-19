<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>
	
	<c:if test="${param.success eq true}">
		<div class="alert alert-success">Document Removed</div>
	</c:if>
	
	<input id="varUserId" value="${user.id}" type="hidden"/>
	<input id="varFirstName" value="${user.firstName}" type="hidden"/>
	<input id="varLastName" value="${user.lastName}" type="hidden"/>
	<input id="varEmail" value="${user.email}" type="hidden"/>
	<input id="varLogin" value="${user.name}" type="hidden"/>
	<input id="varPassword" value="${user.password}" type="hidden"/>
	
	
	<script type="text/javascript">
$(document).ready(function() {
	$(".editUserButton").click(function(e) {
		if($('#firstNameInput').val() == ''){
			$('#firstNameInput').val($("#varFirstName").val());
		   }
		if($('#lastNameInput').val() == ''){
			$('#lastNameInput').val($("#varLastName").val());
		   }
		if($('#emailInput').val() == ''){
			$('#emailInput').val($("#varEmail").val());
		   }
		if($('#loginInput').val() == ''){
			$('#loginInput').val($("#varLogin").val());
		   }
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
		$("#userId").val($("#varUserId").val());
	});
	$(".editUserForm").validate(
			{
				rules: {
					email: {
						email : true,
					},
					name: {
						minlength : 3,
						remote : {
							url: "<spring:url value='/register/available.html' />",
							type: "get",
							data: {
								username: function() {
									return $("#name").val();
								}
							}
						}
					},
					password: {
						required : true,
						minlength : 5
					},
					password_confirm: {
						required : true,
						minlength : 5,
						equalTo: "#passwordInput"
					}
				},
				highlight: function(element) {
					$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
				},
				unhighlight: function(element) {
					$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
				},
				messages: {
					name: {
						remote: "Such username already exists"
					}
				}
			}		
		);
	$(".triggerEdition").click(function(e) {
		e.preventDefault();
		$("#modalEditDoc .editBtn").attr("href", $(this).attr("href"));
		$("#modalEditDoc").modal();
	});
});
</script>

<h1><c:out value="${user.name}" /></h1> 

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#modalEditUser">
  Edit User
</button>

<br><br>

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
	
<script type="text/javascript">
$(document).ready(function() {
	$(".triggerDelete").click(function(e) {
		e.preventDefault();
		$("#modalDeleteDoc .deleteBtn").attr("href", $(this).attr("href"));
		$("#modalDeleteDoc").modal();
	});
});
</script>
	
	<br><br>

	<h1>Documents Sent by <c:out value="${user.name}" /></h1>
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
							<a href='<spring:url value="/users/document/editByAdmin/${document.id}.html" />' id="${document.id}" class="btn btn-primary triggerDocumentEdition ">
									<input id="varName${document.id}" value="${document.name}" type="hidden"/>
									<input id="varDescription${document.id}" value="${document.description}" type="hidden"/>
									<input id="varSender${document.id}" value="${document.sender}" type="hidden"/>
									<input id="varReciever${document.id}" value="${document.reciever}" type="hidden"/>
									edit
								</a>
							<a href="<spring:url value="/users/document/removeByAdmin/${user.id}/${document.id}.html" />" class="btn btn-danger triggerDelete ">delete</a>
						</td>
						</tr>
				</c:forEach>
	</table>
	
	<h1>Documents Sent to <c:out value="${user.name}" /></h1>
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
							<a href='<spring:url value="/users/document/editByAdmin/${documentToMe.id}.html" />' id="${documentToMe.id}" class="btn btn-primary triggerDocumentEdition ">
									<input id="varName${documentToMe.id}" value="${documentToMe.name}" type="hidden"/>
									<input id="varDescription${documentToMe.id}" value="${documentToMe.description}" type="hidden"/>
									<input id="varSender${documentToMe.id}" value="${documentToMe.sender}" type="hidden"/>
									<input id="varReciever${documentToMe.id}" value="${documentToMe.reciever}" type="hidden"/>
									edit
								</a>
							<a href="<spring:url value="/users/document/removeByAdmin/${user.id}/${documentToMe.id}.html" />" class="btn btn-danger triggerDelete ">delete</a>
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

	<form:form commandName="editUser" cssClass="form-horizontal editUserForm" method="post" action="/users/${user.id}.html" >
<!-- Modal -->
<div class="modal fade" id="modalEditUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Edit User</h4>
      </div>
      <div class="modal-body">
		
		<div class="form-group">
		<label for="first-name" class="col-sm-2 control-label">First name:</label>
		<div class="col-sm-10">
			<form:input path="firstName" id="firstNameInput" cssClass="form-control" placeholder="${user.firstName}" />
			<form:errors path="firstName" />
		</div>
	</div>
		
		<div class="form-group">
		<label for="last-name" class="col-sm-2 control-label">Last name:</label>
			<div class="col-sm-10">
				<form:input path="lastName" id="lastNameInput" cssClass="form-control" placeholder="${user.lastName}" />
				<form:errors path="lastName" />
			</div>
		</div>
		
		<div class="form-group">
			<label for="email" class="col-sm-2 control-label">Email:</label>
				<div class="col-sm-10">
					<form:input path="email" id="emailInput" cssClass="form-control" placeholder="${user.email}" />
					<form:errors path="email" />
				</div>
		</div>
		
		<div class="form-group">
		<label for="name" class="col-sm-2 control-label">Login:</label>
		<div class="col-sm-10">
			<form:input path="name" id="loginInput" cssClass="form-control" placeholder="${user.name}" />
			<form:errors path="name" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="password" class="col-sm-2 control-label">Password:</label>
		<div class="col-sm-10">
			<form:password path="password" id="passwordInput" cssClass="form-control" />
			<form:errors path="password" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="password" class="col-sm-2 control-label">Confirm password:</label>
		<div class="col-sm-10">
			<input type="password" name="password_confirm" id="password_confirm" class="form-control" />
		</div>
	</div>
	
	<div class="form-group">
		<div class="col-sm-2">
			<input type="submit" value="Save" class="btn btn-lg btn-primary editUserButton" />
		</div>
	</div>
	</div>
	</div>
	</div>
	</div>
</form:form>

<form:form id="editDocForm" commandName="editDocument" cssClass="form-horizontal documentForm" method="post" action="/users/editDocumentByAdmin.html" enctype="multipart/form-data">
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
      <input id="userId"  name="userId" value="" type="hidden"/>
      
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