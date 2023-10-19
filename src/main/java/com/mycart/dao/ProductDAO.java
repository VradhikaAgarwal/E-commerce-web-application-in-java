package com.mycart.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.mycart.entities.Product;

public class ProductDAO {
	  private SessionFactory factory;

		public ProductDAO(SessionFactory factory) {
			super();
			this.factory = factory;
		}
		
		public boolean saveProduct(Product product) {
			boolean f=false;
			try {
				Session s=this.factory.openSession();
				Transaction tx=s.beginTransaction();
				s.save(product);
				
				tx.commit();
				s.close();
				f=true;
			}
			catch(Exception ex) {
				ex.printStackTrace();
				f=false;
			}
			return f;
		}
		//get all products
		
		public List<Product> getAllProducts()
		{
			Session s=this.factory.openSession();
			Query q=s.createQuery("from Product");
			List<Product> list=q.list();
			return list;
		}
		
		// get all products by given category Id
		public List<Product> getAllProductsById(int cid)
		{
			Session s=this.factory.openSession();
			
			//return all the products of given category
			Query q=s.createQuery("from Product as p where p.category.categoryId =: id ");
			
			//set the value of cid into id with the help of query q.
			
			q.setParameter("id", cid);
			List<Product> list=q.list();
			return list;
		}
}
