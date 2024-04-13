package com.personal.jspdb.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.personal.jspdb.model.Student;
import com.personal.jspdb.service.StudentService;

public class StudentServlets extends HttpServlet {
	
	private StudentService service;
	
	@Override
	public void init() throws ServletException {
		super.init();
		this.service = new StudentService();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Student entity = new Student();
		entity.setNombres(req.getParameter("firstName"));
		entity.setApellidos(req.getParameter("lastName"));
		entity.setDni(req.getParameter("documentDNI"));
		entity.setCelular(req.getParameter("celphone"));
		entity.setEmail(req.getParameter("email"));
		entity.setContrasena(req.getParameter("password"));
		try {
			service.save(entity);
			resp.sendRedirect("congratulations.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}