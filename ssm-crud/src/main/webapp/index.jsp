<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.5.1.min.js"></script>
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
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>Department</th>
							<th>Option</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- page navigator -->
		<div class="row">
			<!-- text information for page navigation -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- page navigation bars -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		//After page loading, useing ajax to send a request to get page information
		$(function() {
			//go the the first page after page loading
			to_page(1);
		});

		//A function for ajax request.
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1. parse the employee information
					build_emp_table(result);
					//2. parse the page information
					build_page_info(result);
					//3. parse page navigation information
					build_page_nav(result);
				}
			});
		}

		//A function to build body of a table
		function build_emp_table(result) {
			//empty the table before building it
			$("#emps_table tbody").empty();
			//build the table
			var emps = result.extend.pageInfo.list;
			$.each(emps,
					function(index, item) {
						var empIdTd = $("<td></td>").append(item.empId);
						var empNameTd = $("<td></td>").append(item.empName);
						var genderTd = $("<td></td>").append(item.gender);
						var emailTd = $("<td></td>").append(item.email);
						var departmentTd = $("<td></td>").append(
								item.department.deptName);
						var editBtn = $("<button></button").addClass(
								"btn btn-primary btn-sm").append(
								"<span></span>").addClass(
								"glyphicon glyphicon-pencil").append("EDIT");
						var deleteBtn = $("<button></button").addClass(
								"btn btn-danger btn-sm")
								.append("<span></span>").addClass(
										"glyphicon glyphicon-trash").append(
										"DELETE");
						var btnTd = $("<td></td>").append(editBtn).append(" ")
								.append(deleteBtn);
						$("<tr></tr>").append(empIdTd).append(empNameTd)
								.append(genderTd).append(emailTd).append(
										departmentTd).append(btnTd).appendTo(
										"#emps_table tbody");
					});
		}

		//A function for building page information
		function build_page_info(result) {
			//empty before building page info area
			$("#page_info_area").empty();
			var page_num = result.extend.pageInfo.pageNum;
			var pages = result.extend.pageInfo.pages;
			var total = result.extend.pageInfo.total;
			/**
			Page  pages in total, records in total.
			 */
			$("#page_info_area").append(
					"Page " + page_num + ", " + pages + " in total, " + total
							+ " records in total");
		}

		//A function for build page navigation bar
		function build_page_nav(result) {
			//empty page nava area before building it
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("First page").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageinfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("Last page").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var nav = $("<nav></nav>").append(ul).appendTo("#page_nav_area");
		}
	</script>
</body>
</html>