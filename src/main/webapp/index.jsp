<%@page import="com.mycart.Helper"%>
<%@page import="com.mycart.entities.Category"%>
<%@page import="com.mycart.dao.CategoryDAO"%>
<%@page import="com.mycart.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.mycart.dao.ProductDAO"%>
<%@page import="com.mycart.FactoryProvider"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyCart - Home</title>
<%@include file="components/common_css_js.jsp"%>

</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-3 mx-2">

			<%
			String cat = request.getParameter("category");
			//out.println(cat);

			ProductDAO dao = new ProductDAO(FactoryProvider.getFactory());

			List<Product> list = null;

			if (cat == null || cat.trim().equals("all")) {
				list = dao.getAllProducts();
			}

			//give all the products of given category id
			else {
				int cid = Integer.parseInt(cat.trim());
				// call dao
				list = dao.getAllProductsById(cid);
			}

			CategoryDAO cdao = new CategoryDAO(FactoryProvider.getFactory());
			List<Category> clist = cdao.getCategories();
			%>
			<!-- show categories -->

			<div class="col-md-2">

				<div class="list-group mt-4">
					<a href="index.jsp?category=all"
						class="list-group-item list-group-item-action active"> All
						Products </a>


				</div>
				<%
				for (Category c : clist) {
				%>


				<a href="index.jsp?category=<%=c.getCategoryId()%>"
					class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%></a>

				<%
				}
				%>


			</div>
			<!-- show products -->
			<div class="col-md-10">

				<!-- row -->

				<div class="row mt-4">

					<div class="col-md-12">

						<div class="card-columns">

							<!-- traversing products -->
							<%
							for (Product pr : list) {
							%>
							<!-- product card -->
							<div class="card product-card">

								<div class="container text-center">
									<img style="max-height: 280px; max-width: 100%; width: auto;"
										class="card-img-top m-2"
										src="img/products/<%=pr.getpPhoto()%>" alt="laptop_img">

								</div>

								<div class="card-body">
									<h5 class="card-title"><%=pr.getpName()%></h5>
									<p class="card-text">
										<%=Helper.get10Words(pr.getpDesc())%>


									</p>
								</div>
								<div class="card-footer text-center">
									<button class="btn custom-bg text-white"
										onclick="add_to_cart(<%=pr.getpId()%> ,'<%=pr.getpName()%>',<%=pr.getpPrice()%> )">
										Add to Cart</button>

									<button class="btn btn-outline-success">
										&#8377
										<%=pr.getPriceAfterDiscount()%>/- <span
											class="text-secondary discount-label"> &#8377 <%=pr.getpPrice()%>,
											<%=pr.getpDiscount()%>% off
										</span>
									</button>

								</div>

							</div>

							<%
							}
							if (list.size() == 0) {
							out.println("<h3>No items in this category</h3>");
							}
							%>
						</div>

					</div>


				</div>

			</div>


		</div>
	</div>
	
	<%@include file="components/common_modals.jsp" %>

</body>
</html>