package com.mycart;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
//single design pattern- has only one instance and provides a global point of access to it.
public class FactoryProvider {
	
	    private static SessionFactory factory;
	    public static SessionFactory getFactory()
	    {
	    	try {
	    		if(factory==null) {
	    			factory= new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
	    		}
	    		
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}
	    	return factory;
	    }
	}


