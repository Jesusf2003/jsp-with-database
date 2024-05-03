package com.personal.jspdb.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.personal.jspdb.model.Career;
import com.personal.jspdb.util.DatabaseUtil;
import com.personal.jspdb.util.GenericRepository;

public class CareerService implements GenericRepository<Career, String> {

    private Connection connection;

    public CareerService() {
        try {
            this.connection = DatabaseUtil.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    public List<Career> findALL() {
        List<Career> careers = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM career");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Career career = createCareerFromResultSet(rs);
                careers.add(career);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch data from the database", e);
        }

        return careers;
    }

    @Override
    public Career findById(String codigo) {
        Career career = null;

        try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM career WHERE codigo = ?")) {
            stmt.setString(1, codigo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    career = createCareerFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to execute query in the database", e);
        }

        return career;
    }

    @Override
    public Career save(Career career) {
        String sql = "INSERT INTO career (codigo, nombre, descripcion, estado) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, career.getCodigo());
            stmt.setString(2, career.getNombre());
            stmt.setString(3, career.getDescripcion());
            stmt.setString(4, career.getEstado());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save career to the database", e);
        }

        return career;
    }

    @Override
    public Career update(Career career) {
        String sql = "UPDATE career SET nombre=?, descripcion=?, estado=? WHERE codigo=?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, career.getNombre());
            stmt.setString(2, career.getDescripcion());
            stmt.setString(3, career.getEstado());
            stmt.setString(4, career.getCodigo());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update career in the database", e);
        }

        return career;
    }

    @Override
    public void deleteById(String codigo) {
        try (PreparedStatement stmt = connection.prepareStatement("DELETE FROM career WHERE codigo = ?")) {
            stmt.setString(1, codigo);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting career", e);
        }
    }

    private Career createCareerFromResultSet(ResultSet rs) throws SQLException {
        Career career = new Career();
        career.setCodigo(rs.getString("codigo"));
        career.setNombre(rs.getString("nombre"));
        career.setDescripcion(rs.getString("descripcion"));
        career.setEstado(rs.getString("estado"));
        return career;
    }
}