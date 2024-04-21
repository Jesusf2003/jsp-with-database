package com.personal.jspdb.controller;

import com.personal.jspdb.model.Student;
import com.personal.jspdb.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit")
public class StudentEditServlet extends HttpServlet {

    private StudentService service;

    @Override
    public void init() throws ServletException {
        super.init();
        this.service = new StudentService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long identificador = Long.parseLong(req.getParameter("id"));

            Student updatedStudent = new Student();
            updatedStudent.setIdentificador(identificador);
            updatedStudent.setNombres(req.getParameter("name"));
            updatedStudent.setApellidos(req.getParameter("lastName"));
            updatedStudent.setDni(req.getParameter("documentDNI"));
            updatedStudent.setCelular(req.getParameter("celphone"));
            updatedStudent.setEmail(req.getParameter("email"));
            updatedStudent.setContrasena(req.getParameter("password"));

            service.update(updatedStudent);
            resp.sendRedirect("congratulations.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error occurred while updating student");
        }
    }

}
