<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee List</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.8.2.js"></script>
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
<script
	src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- Header -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- Button -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">ADD</button>
				<button class="btn btn-danger">DELETE</button>
			</div>
		</div>
		<!-- table -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Department</th>
						<th>Option</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName}</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									EDIT
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									DELETE
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- page navigator -->
		<div class="row">
			<!-- text information for page navigation -->
			<div class="col-md-6">Page ${pageInfo.getPageNum() },
				${pageInfo.getPages() } pages in total, ${pageInfo.getTotal() }
				records in total.</div>
			<!-- page navigation bars -->
			<div class="col-md-6">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<li><a href="${APP_PATH }/emps?pn=1">First Page</a></li>
						<c:if test="${pageInfo.hasPreviousPage }">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
							<c:if test="${page_Num==pageInfo.pageNum }">
								<li class="active"><a class="page-link" href="#">${page_Num }</a></li>
							</c:if>
							<c:if test="${page_Num!=pageInfo.pageNum }">
								<li><a class="page-link"
									href="${APP_PATH}/emps?pn=${page_num } }">${page_Num }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage }">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">Last
								Page</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>