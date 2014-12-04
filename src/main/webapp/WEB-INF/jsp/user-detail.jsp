<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>

<h1>${user.name}</h1>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  New File
</button>

<form:form commandName="file" cssClass="form-horizontal">
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">New File</h4>
      </div>
      <div class="modal-body">
     
		<div class="form-group">
			<label for="file-name" class="col-sm-2 control-label">Name:</label>
			<div class="col-sm-10">
				<form:input path="name" cssClass="form-control" />
			</div>
		</div>
		
		<div class="form-group">
			<label for="type" class="col-sm-2 control-label">Type:</label>
			<div class="col-sm-10">
				<form:input path="type" cssClass="form-control" />
			</div>
		</div>
		
		<div class="form-group">
			<label for="first-name" class="col-sm-2 control-label">To Who:</label>
			<div class="col-sm-10">
				<form:input path="reciever" cssClass="form-control" />
			</div>
		</div>
		
		<li class="dropdown">
              <a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
                Dropdown
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
                <li role="presentation"><a role="menuitem" tabindex="-1" href="https://twitter.com/fat">pdf</a></li>
                <li role="presentation"><a role="menuitem" tabindex="-1" href="https://twitter.com/fat">jpeg</a></li>
                <li role="presentation"><a role="menuitem" tabindex="-1" href="https://twitter.com/fat">doc</a></li>
              </ul>
            </li>

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
	
	<table class="table table-bordered table-hover table-striped">
		<thead>
			<tr>
				<th>File Name</th>
				<th>Type</th>
				<th>Date</th>
				<th>To Who:</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach items="${user.files}" var="file">
					<tr>
						<td>${file.name}</td>
						<td>${file.type}</td>
						<td>${file.date}</td>
						<td>${file.reciever}</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>

