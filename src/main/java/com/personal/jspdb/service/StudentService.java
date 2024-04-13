package com.personal.jspdb.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.personal.jspdb.model.Student;
import com.personal.jspdb.util.DatabaseUtil;
import com.personal.jspdb.util.GenericRepository;

public class StudentService implements GenericRepository<Student, Long> {

	// Variables globales para volver a usar
	private Connection connection;

	// Constructor
	public StudentService() {
		try {
			// Inicializa la conexión con la base de datos
			this.connection = DatabaseUtil.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
			// Envía un mensaje a la consola cuando detecta este tipo de error (Si, en español)
			throw new RuntimeException("Falló al inicializar la conexión con la base de datos", e);
		}
	}

	// Lista todos los registros
	@Override
	public List<Student> findALL() {
		// Inicia la lista
		List<Student> entities = new ArrayList<>();
		// Prepara la conexión y ejecuta la sentencia
		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery("SELECT * FROM student")) {
			// Crea la lista de estudiantes traída de la base de datos
			while (rs.next()) {
				Student entity = new Student();
				entities.add(entity);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Falló al inicializar la conexión con la base de datos", e);
		}
		return entities;
	}

	// Busca por id de todos los registros
	@Override
	public Student findById(Long id) {
		Student entity = null;
		// Prepara la conexión y ejecuta la sentencia
		try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM student WHERE identificador = ?")) {
			// Envía el parámetro (el identificador en este caso)
			stmt.setLong(1, id);
			try (ResultSet rs = stmt.executeQuery()) {
				entity = createStudentFromResultSet(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Falló al inicializar la conexión con la base de datos", e);
		}
		return entity;
	}

	// Registra un nuevo estudiante
	@Override
	public Student save(Student entity) {
		String sql = "INSERT INTO student (nombres, apellidos, dni, celular, email, contrasena) VALUES (?, ?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			stmt.setString(1, entity.getNombres());
			stmt.setString(2, entity.getApellidos());
			stmt.setString(3, entity.getDni());
			stmt.setString(4, entity.getCelular());
			stmt.setString(5, entity.getEmail());
			stmt.setString(6, entity.getContrasena());
			int affectedRows = stmt.executeUpdate();
			if (affectedRows == 1) {
				ResultSet generatedKeys = stmt.getGeneratedKeys();
				if (generatedKeys.next()) {
					entity.setIdentificador(generatedKeys.getLong(1));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Falló al inicializar la conexión con la base de datos", e);
		}
		return entity;
	}

	@Override
	public void deleteById(Long id) {
		String sql = "DELETE FROM student WHERE identificador = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setLong(1, id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Falló al inicializar la conexión con la base de datos", e);
		}
	}

	// Mejor forma sugerida para mapear el objeto para ResultSet
	private Student createStudentFromResultSet(ResultSet rs) throws SQLException {
		Student entity = new Student();
		entity.setIdentificador(rs.getLong("identificador"));
		entity.setNombres(rs.getString("nombres"));
		entity.setApellidos(rs.getString("apellidos"));
		entity.setDni(rs.getString("dni"));
		entity.setCelular(rs.getString("celular"));
		entity.setEmail(rs.getString("email"));
		entity.setContrasena(rs.getString("contrasena"));
		return entity;
	}
}