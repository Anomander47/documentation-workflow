<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/taglib.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	$(".triggerDisable").click(function(e) {
		e.preventDefault();
		$("#modalDisableUser .disableBtn").attr("href", $(this).attr("href"));
		$("#modalDisableUser").modal();
	});
});
</script>

<table class="table table-bordered table-hover table-striped">
	<thead>
		<tr>
			<th>user name</th>
			<th>actions</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${users}" var="user">
			<tr>
				<td>
					<a href='<spring:url value="/users/${user.id}.html" />'>
						<c:out value="${user.name}" />
					</a>
				</td>
				<td>
					<a href='<spring:url value="/users/disable/${user.id}.html" />' class="btn btn-danger triggerDisable">
						disable
					</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- Modal -->
<div class="modal fade" id="modalDisableUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Disable user</h4>
      </div>
      <div class="modal-body">
       Are you sure to disable this user?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <a href="" class="btn btn-danger disableBtn">Disable</a>
      </div>
    </div>
  </div>
</div>