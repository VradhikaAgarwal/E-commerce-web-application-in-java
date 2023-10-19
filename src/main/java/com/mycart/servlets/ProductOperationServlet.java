package com.mycart.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.mycart.FactoryProvider;
import com.mycart.dao.CategoryDAO;
import com.mycart.dao.ProductDAO;
import com.mycart.entities.Category;
import com.mycart.entities.Product;

// this annotation is used as we are fetching image in our form 

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out=response.getWriter()) {
			
			// this servlet has two operations 
			// 1. fetching add Category 2. fetching add Product 
			// therefore, we use if-else to do this task
			
			String op=request.getParameter("operation");
			if(op.trim().equals("addCategory")) {
				//fetching category data
				String title=request.getParameter("catTitle");
				String description=request.getParameter("catDescription");
				
				
				//call category class where setters and getters are made to set the value
				Category category=new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);
				
				//save category details in database
				//make CategoryDAO class
				CategoryDAO categoryDao=new CategoryDAO(FactoryProvider.getFactory());
				int catId=categoryDao.saveCategory(category);
				//out.println("Category saved");
				
				HttpSession httpSession=request.getSession();
				httpSession.setAttribute("message", "Category added successfully: " +catId);
				response.sendRedirect("admin.jsp");
				return;
				
				
			}else if(op.trim().equals("addProduct")) {
				//fetching product data			
				String pName=request.getParameter("pName");
				String pDesc=request.getParameter("pDesc");
				double pPrice=Double.parseDouble(request.getParameter("pPrice"));
				int pDiscount=Integer.parseInt(request.getParameter("pDiscount"));
				int pQuant=Integer.parseInt(request.getParameter("pQuant"));
				int catId=Integer.parseInt(request.getParameter("catId"));
				// for fetching picture
				Part part=request.getPart("pPic");
				
				Product p=new Product();
				p.setpName(pName);
				p.setpDesc(pDesc);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpPhoto(part.getSubmittedFileName());
				p.setpQuantity(pQuant);
				
				// get Category by Id
				CategoryDAO cdao=new CategoryDAO(FactoryProvider.getFactory());
				Category category =cdao.getCategoryById(catId);
				
				p.setCategory(category);
				
				//save product in database
				// make ProductDAO class
				ProductDAO pdao=new ProductDAO(FactoryProvider.getFactory());
			    pdao.saveProduct(p);
				
				//find out the path to upload pic. here we are linking image name with the images uploaded in products folder.
			    //in database only names of images are stored and pic of products are stored in products folder which is linked with that name in database.
			    
				String path = request.getRealPath("img") +File.separator+ ("products") +File.separator+ part.getSubmittedFileName();
				System.out.println(path);
				// uploading the code
				try {
				FileOutputStream fos=new FileOutputStream(path);
				InputStream in =part.getInputStream();
				
				//reading data
				byte[] data=new byte[in.available()];
				in.read(data);
				
			    //writing data
				fos.write(data);
				fos.close();
				
				}
				catch(Exception ex) {
					ex.printStackTrace();
				}
			    
				HttpSession httpSession=request.getSession();
				httpSession.setAttribute("message", "Product is added successfully: ");
				response.sendRedirect("admin.jsp");
				return;
				 
		}
		
	  }
	}
}

