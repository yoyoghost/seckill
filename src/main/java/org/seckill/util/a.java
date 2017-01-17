package org.seckill.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class a {
	public static void main(String args[])  
    {  
          
            String url = "jdbc:mysql://127.0.0.1:3306/seckill?useUnicode=true&characterEncoding=utf8";  
            String driver = "com.mysql.jdbc.Driver";  
            try{  
                Class.forName(driver);  
            }catch(Exception e){  
                System.out.println("无法加载驱动");  
            }  
              
    try {  
            Connection con = DriverManager.getConnection(url,"root","root");  
            if(!con.isClosed())  
                System.out.println("success");  
        } catch (Exception e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        }  
    }  
}
