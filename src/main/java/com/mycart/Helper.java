package com.mycart;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class Helper {

	public static String get10Words(String desc) {
		String []stars =desc.split(" ");
		if(stars.length>10)
		{
			String res="";
			for(int i=0;i<10;i++)
			{
				res=res+stars[i]+" ";
			}
			return (res+"...");
			
		}
		else 
		{
			return (desc+"...");
		}
	}
	
	public static Map<String,Long> getCount(SessionFactory factory)
	{
		Session s=factory.openSession();
		String q1="Select count(*) from User";
		String q2="Select count(*) from Product";

		Query query1=s.createQuery(q1);
		Query query2=s.createQuery(q2);

		//assumes that the result is a single value as it counts the total number of rows and
		//therefore in the list it assumes be as the first element
		//so get(0) method is used to extract the value on first index
		long userCount= (long) query1.list().get(0);
		long productCount= (long) query2.list().get(0);
		
		//map stores the count of both the rows of users and products with the key userCount and productCount
		Map<String,Long> map=new HashMap<>();
		map.put("userCount", userCount);
		map.put("productCount", productCount);
		
		s.close();
		return map;
	}
}
