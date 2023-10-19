<%@page import="java.util.Map"%>
<%@page import="com.mycart.Helper"%>
<%@page import="com.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycart.FactoryProvider"%>
<%@page import="com.mycart.dao.CategoryDAO"%>
<%@page import="com.mycart.entities.User"%>


<%
User user = (User) session.getAttribute("current-user");
if (user == null) {
	session.setAttribute("message", "You are not logged in !! Login First");
	response.sendRedirect("login.jsp");
	return;

} else {

	if (user.getUserType().equals("normal")) {
		session.setAttribute("message", "You are not an Admin !! Do not access this page");
		response.sendRedirect("login.jsp");
		return;
	}
}
%>
                        <%
                        // getting count of categories
						CategoryDAO cDao = new CategoryDAO(FactoryProvider.getFactory());
						List<Category> list = cDao.getCategories();
						
						//getting count of users and product
						Map<String,Long> m = Helper.getCount(FactoryProvider.getFactory());
						%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>

<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container admin">

		<div class="container-fluid mt-3">
			<%@include file="components/message.jsp"%>

		</div>


		<div class="row mt-3">

			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 120px" class="img-fluid" alt="user_icon"
								src="img/teamwork.png">

						</div>
						<h1><%= m.get("userCount") %></h1>
						<h1 class="text-uppercase text-muted">Users</h1>
					</div>
				</div>

			</div>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px" class="img-fluid round-circle"
								alt="category_icon" src="img/clipboard.png">
						</div>
						<h1><%= list.size() %></h1>
						<h1 class="text-uppercase text-muted">categories</h1>

					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 120px" class="img-fluid round-circle"
								alt="product_icon" src="img/delivery-box.png">

						</div>
						<h1><%= m.get("productCount") %></h1>
						<h1 class="text-uppercase text-muted">Products</h1>

					</div>
				</div>
			</div>
		</div>

		<!--second row   -->
		<div class="row mt-3">
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 120px" class="img-fluid round-circle"
								alt="add_category_icon" src="img/category.png">

						</div>
						<p class="mt-2">Click here to add new Categories</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>

					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 120px" class="img-fluid round-circle"
								alt="add_product_icon" src="img/plus.png">

						</div>
						<p class="mt-2">Click here to add new Products</p>

						<h1 class="text-uppercase text-muted">Add Products</h1>

					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- add category modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Category
						Details</h5>

					<span aria-hidden="true">&times;</span>

				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post">
						<input type="hidden" name="operation" value="addCategory">

						<div class="form-group">
							<input type="text" class="form-control" name="catTitle"
								placeholder="Enter Category Title" required>

						</div>
						<div class="form-group">
							<textarea style="height: 300px" class="form-control"
								placeholder="Enter category description" name="catDescription"
								required></textarea>


						</div>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
							<button type="button" class="btn btn-outline-success"
								data-dismiss="modal">Close</button>
						</div>

					</form>

				</div>

			</div>
		</div>
	</div>

	<!-- end of category modal -->

	<!-- start of product modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Product
						Details</h5>

					<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
					<input type="hidden" name="operation" value="addProduct">
					
						<div class="form-group">
							<input type="text" class="form-control" name="pName"
								placeholder="Enter Product Name" required>
						</div>
						<div class="form-group">
							<textarea style="height: 150px" class="form-control"
								placeholder="Enter product description" name="pDesc" required></textarea>

						</div>
						<div class="form-group">
							<input type="number" class="form-control" name="pPrice"
								placeholder="Enter product price" required>
						</div>
						<div class="form-group">
							<input type="number" class="form-control" name="pDiscount"
								placeholder="Enter product discount" required>
						</div>
						<div class="form-group">
							<input type="number" class="form-control" name="pQuant"
								placeholder="Enter Product Quantity" required>
						</div>
						
						<div class="form-group">
							<select name="catId" class="form-control" >
								<%
								for (Category c : list) {
								%>

								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>

								<%
								}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="pPic">Select image for your product</label> <br>
							<input type="file" name="pPic" id="pPic" required>
						</div>

						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>
							<button type="button" class="btn btn-outline-success"
								data-dismiss="modal">Close</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

	<!-- end of product modal -->
	<%@include file="components/common_modals.jsp" %>
</body>
</html>