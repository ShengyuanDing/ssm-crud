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
	<!-- Updating employee Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Update Employee Information</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">Name</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@hotmail.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_add_input" class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> Male
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F">
									Female
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="department_add_input" class="col-sm-2 control-label">Department</label>
							<div class="col-sm-5">
								<!-- Only submit the department Id -->
								<select class="form-control" id="dept_update_selects" name="dId"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_upadte_btn">Update</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Adding employee Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Adding an Employee</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">Name</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="Employee name"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@hotmail.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_add_input" class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> Male
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> Female
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="department_add_input" class="col-sm-2 control-label">Department</label>
							<div class="col-sm-5">
								<!-- Only submit the department Id -->
								<select class="form-control" id="dept_add_selects" name="dId"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
				</div>
			</div>
		</div>
	</div>
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
				<button class="btn btn-primary" id="emp_add_modal_btn">ADD</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">DELETE</button>
			</div>
		</div>
		<!-- table -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
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
		//Define a global variable to record the total records
		var totalRecords;
		var currentPage;
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
			$
					.each(
							emps,
							function(index, item) {
								var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var genderTd = $("<td></td>").append(
										item.gender);
								var emailTd = $("<td></td>").append(item.email);
								var departmentTd = $("<td></td>").append(
										item.department.deptName);
								var editBtn = $("<button></button").addClass(
										"btn btn-primary btn-sm edit_btn")
										.append("<span></span>").addClass(
												"glyphicon glyphicon-pencil")
										.append("EDIT");
								editBtn.attr("edit-id", item.empId);
								var deleteBtn = $("<button></button").addClass(
										"btn btn-danger btn-sm delete_btn")
										.append("<span></span>").addClass(
												"glyphicon glyphicon-trash")
										.append("DELETE");
								deleteBtn.attr("delete-id", item.empId);
								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(deleteBtn);
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
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
			totalRecords = total;
			currentPage = page_num;
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
					to_page(result.extend.pageInfo.pageNum - 1);
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

		//Define a function to reset the form before add an emp
		function reset_form(element) {
			//clear the input data
			$(element)[0].reset();
			//clear the style
			$(element).find("*").removeClass("has-success has-error");
			$(element).find(".help-block").text("");
		}

		//Binding click event on ADD button to pop up add employee modal
		$("#emp_add_modal_btn").click(function() {
			//empty the form
			reset_form("#empAddModal form");
			// Send an ajax to get department information and show them on the selects
			//before popping up modal
			getDepartments("#empAddModal select");
			//Pop up modal
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});

		//Define a function to send ajax request to get department information
		function getDepartments(element) {
			$(element).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//get the department information
					//console.log(result);
					//1. traverse the department information
					var depts = result.extend.departments;
					$.each(depts, function() {
						var optionElement = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionElement.appendTo(element);
					});
				}
			});
		}

		//Binding a change event to Add button to test whether an empName already exists.
		$("#empName_add_input").change(
				function() {
					//Send a ajax request to test if an empName already exists.
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkname",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							if (result.code == 100) {
								show_validation_msg("#empName_add_input",
										"success", "name can be used");
								$("#emp_save_btn").attr("val_name", "success");
							} else if (result.code == 200) {
								show_validation_msg("#empName_add_input",
										"error", "name already exists.");
								$("#emp_save_btn").attr("val_name", "error");
							}
						}
					});
				});

		//Binding a change event to Add button to test whether an email already exists.
		$("#email_add_input")
				.change(
						function() {
							//Send a ajax request to test if an empName already exists.
							var email = this.value;
							$
									.ajax({
										url : "${APP_PATH}/checkemail",
										data : "email=" + email,
										type : "POST",
										success : function(result) {
											if (result.code == 100) {
												show_validation_msg(
														"#email_add_input",
														"success",
														"email can be used");
												$("#emp_save_btn").attr(
														"val_email", "success");
											} else if (result.code == 200) {
												show_validation_msg(
														"#email_add_input",
														"error",
														"email already exists.");
												$("#emp_save_btn").attr(
														"val_email", "error");
											}
										}
									});
						});
		//Define a function to validate input data
		function validate_add_form() {
			//1. Get the name input value
			var empName = $("#empName_add_input").val();
			var regName = /^[a-zA-Z0-9_-]{3,16}$/;
			if (!regName.test(empName)) {
				show_validation_msg("#empName_add_input", "error",
						"Name has to be 3 to 16 characters");
				return false;
			} else {
				show_validation_msg("#empName_add_input", "success", "");
			}
			//2. Get the email input value
			validate_email("#email_add_input");
			return true;
		}

		//A function to show message after validation of input data
		function show_validation_msg(element, status, msg) {
			//1.Clear the validation status and message before validation
			$(element).parent().removeClass("has-success has-error");
			$(element).next("span").text("");
			//2. Validate the input data	
			if ("success" == status) {
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			} else if ("error" == status) {
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}
		}

		//Binding click event to save button, when it's clicked, dubmit the form in modal
		$("#emp_save_btn").click(
				function() {
					//1.Validate the input data before sending a post request
					if (!validate_add_form()) {
						return false;
					}
					;
					//2.Validate whether empName or email already exists
					if (($(this).attr("val_name") == "error")
							|| ($(this).attr("val_email") == "error")) {
						return false;
					}
					//3.Send a post request
					$.ajax({
						url : "${APP_PATH}/emp",
						type : "POST",
						data : $("#empAddModal form").serialize(),
						success : function(result) {
							//alert(result.message);
							if (result.code == 100) {
								//1. close modal
								$("#empAddModal").modal("hide");
								//2. send ajax request to show the last page
								to_page(totalRecords);
							} else if (result.code == 200) {
								console.log(result);
							}
						}
					});
				});

		//Binding click event to edit button
		$(document).on("click", ".edit_btn", function() {
			//alert("edit");
			//1.Get the Department information to show them on the select
			getDepartments("#empUpdateModal select");
			//2.Get the information of the employee to be updated
			var id = $(this).attr("edit-id");
			get_emp(id);
			//3.Pass the id to update button
			$("#emp_upadte_btn").attr("edit-id", id);
			//4.Pop up modal
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		//Define a function to send an ajax request to get employee information
		function get_emp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//show the information to the modal after a successful request
					if (result.code == 100) {
						show_employee(result);
					}
				}
			});
		}

		//Define a function to show data in update Modal
		function show_employee(result) {
			var emp = result.extend.employee
			$("#empName_update_static").text(emp.empName);
			$("#email_update_input").val(emp.email);
			$("#empUpdateModal input[name=gender]").val([ emp.gender ]);
			$("#empUpdateModal select").val([ emp.dId ]);
		}

		//Bind a click event to update button
		$("#emp_upadte_btn").click(function() {
			//1. Validate email information
			validate_email("#email_update_input");
			var id = $(this).attr("edit-id");

			//2. Send ajax request
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "PUT",
				data : $("#empUpdateModal form").serialize(),
				success : function(result) {
					//alert(result.message);
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});

		});

		//Define a function to validate email
		function validate_email(element) {
			var email = $(element).val();
			var regEmail = /^([a-zA-Z0-9_\.-]+)@([a-zA-Z0-9-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validation_msg(element, "error", "invalid email address");
				return false;
			} else {
				show_validation_msg(element, "success", "");
			}
		}

		//Bind click event to Delete button
		$(document).on("click", ".delete_btn", function() {
			//1. Pop up confirm window
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var id = $(this).attr("delete-id");
			if (confirm("Confirm to delete [ " + empName + " ]?")) {
				//2. Send request to delete the employee
				$.ajax({
					url : "${APP_PATH}/emp/" + id,
					type : "DELETE",
					success : function(result) {
						alert(result.message);
						to_page(currentPage);
					}
				});
			}
		});

		//binding click event on check_all check box
		$("#check_all").click(function() {
			$(".check_item").prop("checked", $(this).prop("checked"));
		});

		//binding click eveent on check_item check box
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							// get the number of checked chechbox
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});

		//binding click event on delete all button
		$("#emp_delete_all_btn")
				.click(
						function() {
							//1.get the empName of the checked items
							var empNames = "";
							var empIds = "";
							$.each($(".check_item:checked"), function() {
								empNames += $(this).parents("tr").find(
										"td:eq(2)").text()
										+ ",";
								empIds += $(this).parents("tr")
										.find("td:eq(1)").text()
										+ "-";
							});
							empNames = empNames.substring(0,
									empNames.length - 1);
							empIds = empIds.substring(0, empIds.length - 1);

							if (confirm("Are you sure to delete [ " + empNames
									+ " ]?")) {
								$.ajax({
									url : "${APP_PATH}/emp/" + empIds,
									type : "DELETE",
									success : function(result) {
										alert(result.message);
										to_page(currentPage);
										$("#check_all").prop("checked", false);
									}
								});
							}
						});
	</script>
</body>
</html>