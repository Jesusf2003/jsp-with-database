package com.personal.jspdb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.personal.jspdb.model.Career;
import com.personal.jspdb.model.Student;
import com.personal.jspdb.service.StudentService;

@WebServlet("/register/student")
public class StudentRegisterServlets extends HttpServlet {
	
	private StudentService service;
	
	@Override
	public void init() throws ServletException {
		super.init();
		this.service = new StudentService();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Student student = new Student();
		student.setNombres(req.getParameter("name"));
		student.setApellidos(req.getParameter("lastName"));
		student.setDni(req.getParameter("documentDNI"));
		student.setCelular(req.getParameter("celphone"));
		student.setEmail(req.getParameter("email"));
		Career career = new Career();
		career.setCodigo(req.getParameter("careerCode"));
		student.setCareer(career);
		try {
			service.save(student);
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("Error ocurred while registering student");
		}
	}
}