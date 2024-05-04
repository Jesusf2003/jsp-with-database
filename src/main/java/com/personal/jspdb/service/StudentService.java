package com.personal.jspdb.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.personal.jspdb.model.Career;
import com.personal.jspdb.model.Student;
import com.personal.jspdb.util.DatabaseUtil;
import com.personal.jspdb.util.GenericRepository;

public class StudentService implements GenericRepository<Student, Long> {

	private Connection connection;

	public StudentService() {
		try {
			this.connection = DatabaseUtil.getConnection();
		} catch (SQLException e) {
			throw new RuntimeException("Falló al inicializar la conexión con la base de datos", e);
		}
	}

	@Override
	public List<Student> findALL() {
		List<Student> entities = new ArrayList<>();

		try (PreparedStatement stmt = connection.prepareStatement(
				"SELECT s.*, c.* FROM student s LEFT JOIN career c ON s.carrera_codigo = c.codigo");
			 ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Student entity = createStudentFromResultSet(rs);
				entities.add(entity);
			}
		} catch (SQLException e) {
			throw new RuntimeException("Failed to fetch data from the database", e);
		}

		return entities;
	}

	@Override
	public Student findById(Long id) {
		Student entity = null;
		try (PreparedStatement stmt = connection.prepareStatement(
				"SELECT s.*, c.* FROM student s LEFT JOIN career c ON s.carrera_codigo = c.codigo WHERE s.identificador = ?")) {
			stmt.setLong(1, id);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					entity = createStudentFromResultSet(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("Falló al ejecutar la consulta en la base de datos", e);
		}
		return entity;
	}

	@Override
	public Student save(Student entity) {
		String sql = "INSERT INTO student (nombres, apellidos, dni, celular, email, carrera_codigo) VALUES (?, ?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			stmt.setString(1, entity.getNombres());
			stmt.setString(2, entity.getApellidos());
			stmt.setString(3, entity.getDni());
			stmt.setString(4, entity.getCelular());
			stmt.setString(5, entity.getEmail());
			stmt.setString(6, entity.getCareer().getCodigo()); // Establecemos el código de carrera
			int affectedRows = stmt.executeUpdate();
			if (affectedRows == 1) {
				try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						entity.setIdentificador(generatedKeys.getLong(1));
					}
				}
			}
			return entity;
		} catch (SQLException e) {
			throw new RuntimeException("Falló al insertar el estudiante en la base de datos", e);
		}
	}

	@Override
	public Student update(Student entity) {
		String sql = "UPDATE student SET nombres=?, apellidos=?, dni=?, celular=?, email=?, carrera_codigo=? WHERE identificador=?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, entity.getNombres());
			stmt.setString(2, entity.getApellidos());
			stmt.setString(3, entity.getDni());
			stmt.setString(4, entity.getCelular());
			stmt.setString(5, entity.getEmail());
			stmt.setString(6, entity.getCareer().getCodigo()); // Establecemos el código de carrera
			stmt.setLong(7, entity.getIdentificador());
			int affectedRows = stmt.executeUpdate();
			if (affectedRows == 0) {
				throw new RuntimeException("No se pudo actualizar el estudiante, no se encontró el ID: " + entity.getIdentificador());
			}
		} catch (SQLException e) {
			throw new RuntimeException("Falló al actualizar el estudiante en la base de datos", e);
		}
		return entity;
	}

	@Override
	public void deleteById(Long id) {
		try (PreparedStatement stmt = connection.prepareStatement("DELETE FROM student WHERE identificador = ?")) {
			stmt.setLong(1, id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Error al eliminar el estudiante", e);
		}
	}

	private Student createStudentFromResultSet(ResultSet rs) throws SQLException {
		Student entity = new Student();
		entity.setIdentificador(rs.getLong("identificador"));
		entity.setNombres(rs.getString("nombres"));
		entity.setApellidos(rs.getString("apellidos"));
		entity.setDni(rs.getString("dni"));
		entity.setCelular(rs.getString("celular"));
		entity.setEmail(rs.getString("email"));

		Career career = new Career();
		career.setCodigo(rs.getString("codigo"));
		career.setNombre(rs.getString("nombre"));
		career.setDescripcion(rs.getString("descripcion"));
		entity.setCareer(career);

		return entity;
	}
}