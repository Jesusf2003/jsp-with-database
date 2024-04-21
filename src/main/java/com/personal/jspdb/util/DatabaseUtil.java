package com.personal.jspdb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

	// Inicializa el Driver necesario para usar MySQL
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("MySQL JDBC Driver no encontrado", e);
		}
	}

	// Permite acceder a la base de datos
	public static Connection getConnection() throws SQLException {
		String url = "jdbc:mysql://localhost:3306/dbInstitute?allowPublicKeyRetrieval=true&useSSL=false";
		String user = "root";
		String pswd = "root";
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(url, user, pswd);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Falló al establecer la conexión con la base de datos", e);

		}
		return connection;
	}

	// Cierra la conexión con la base de datos
	public static void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}