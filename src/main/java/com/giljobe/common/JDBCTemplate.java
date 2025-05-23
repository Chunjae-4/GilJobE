package com.giljobe.common;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCTemplate {
	
	public static Connection getConnection() {
		
		Connection conn = null;
		Properties prop = new Properties();
		
		String path = JDBCTemplate.class.getResource("/driver.properties").getPath();
		
		try {
			FileReader fr = new FileReader(path);
			prop.load(fr);
			Class.forName(prop.getProperty("className"));
			conn = DriverManager.getConnection(prop.getProperty("url"),prop.getProperty("user"),prop.getProperty("password"));
			conn.setAutoCommit(false);
		} catch (IOException|ClassNotFoundException|SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	public static void commit(Connection val) {
		
		try {
			if(val!=null&&!val.isClosed()) {
				val.commit();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public static void rollback(Connection val) {
		
		try {
			if(val!=null&&!val.isClosed()) {
				val.rollback();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public static void close(Object val) {
		
		try {
			if(val instanceof Connection) {
				((Connection)val).close();
			}else if(val instanceof ResultSet){
				((ResultSet)val).close();
			}else if(val instanceof PreparedStatement){
				((PreparedStatement)val).close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	


}
