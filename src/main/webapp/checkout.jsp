   <%
   User user = (User) session.getAttribute("current-user");
   if (user == null) {
   	session.setAttribute("message", "You are not logged in !! Login First to access checkout page");
   	response.sendRedirect("login.jsp");
   	return;
   }
   %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout Page</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container">

		<div class="row mt-5">

			<div class="col-md-6">

				<!-- card -->
				<div class="card">

					<div class="card-body">

						<h3 class="text-center mb-3">Your Selected Items</h3>

						<div class="cart-body"></div>

					</div>

				</div>

			</div>

			<div class="col-md-6">
				<!-- form-details -->

				<div class="card">

					<div class="card-body">

						<h3 class="text-center mb-3">Enter your details</h3>
						<form action="#!">

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input value="<%= user.getUserEmail() %>"
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>
							<div class="form-group">
								<label for="name">Name</label> <input value="<%= user.getUserName() %>" type="text"
									class="form-control" id="name" aria-describedby="emailHelp"
									placeholder="Enter name">

							</div>
							<div class="form-group">
								<label for="phoneNumber">Mobile Number</label> <input value="<%= user.getUserPhone() %>" type="number"
									class="form-control" id="phone" aria-describedby="emailHelp"
									placeholder="Enter phn number">

							</div>				
							
							<div class="form-group">
								<label for="exampleFormControlTextarea1">Shipping address
									</label>
								<textarea value="<%= user.getUserAddress() %>" class="form-control" id="exampleFormControlTextarea1" placeholder="Enter your addess"
									rows="3"></textarea>
							</div>
							<div class="container text-center">
							   <button class="btn btn-outline-success">Order Now</button>
							   <button class="btn btn-outline-primary">Continue Shopping</button>
							</div>

						</form>

					</div>

				</div>

			</div>


		</div>

	</div>



	<%@include file="components/common_modals.jsp"%>
</body>
</html>
