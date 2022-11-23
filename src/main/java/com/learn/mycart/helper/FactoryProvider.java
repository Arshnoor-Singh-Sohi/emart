package com.learn.mycart.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider 
{
        private static SessionFactory factory;
        
        public static SessionFactory getFactory()
        {
            try
            {
                if(factory == null) //sigleton design pattern -- if factory value is null then only object will be created
                {
                    factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
                }
                
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        
            return factory;
        }
}
