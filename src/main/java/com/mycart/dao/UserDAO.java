package com.mycart.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.mycart.entities.User;

public class UserDAO {
    private SessionFactory factory;

	public UserDAO(SessionFactory factory) {
		super();
		this.factory = factory;
	}
  
	//get user by email and password
	public User getEmailAndPassword(String email,String password)
	{
		User user=null;
		try {
			//HQL
			String query="from User where userEmail=:e and userPassword=:p";
			Session session=this.factory.openSession();
			Query q=session.createQuery(query);
			q.setParameter("e", email);
			q.setParameter("p", password);
			
			//firing a query
			user=(User) q.uniqueResult();	
			session.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}
