package com.personal.jspdb.controller;


import com.personal.jspdb.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete/student")
public class StudentDeleteServlet extends HttpServlet {

    private StudentService service;

    @Override
    public void init() throws ServletException {
        super.init();
        this.service = new StudentService();
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long studentId = Long.parseLong(req.getParameter("id"));
            service.deleteById(studentId);
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de estudiante no válido");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error eliminando estudiante");
        }
    }

}
