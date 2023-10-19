package com.mycart.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.mycart.entities.Category;

public class CategoryDAO {
     private SessionFactory factory;

	public CategoryDAO(SessionFactory factory) {
		super();
		this.factory = factory;
	}
	
     // saves the category to db
	public int saveCategory(Category cat) {
		Session session=this.factory.openSession();
		Transaction tx=session.beginTransaction();
		
		int catId=(int)session.save(cat);
		tx.commit();
		session.close();
		return catId;
		}
	
	
	public List<Category> getCategories(){
		Session s=this.factory.openSession();
		Query q=s.createQuery("from Category");
		List<Category> list=q.list();
		return list;
	}
	public Category getCategoryById(int cid) {
		Category cat=null;
		try {
			Session s=this.factory.openSession();
			
//			The get method looks in the database for a Category record that matches the provided cid.
//			If a record with the given ID is found, it retrieves that record and returns it as a Category object.
//			If no matching record is found, it returns null.
	
			cat=s.get(Category.class,cid);
			s.close();
			
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return cat;
	}
     
}
