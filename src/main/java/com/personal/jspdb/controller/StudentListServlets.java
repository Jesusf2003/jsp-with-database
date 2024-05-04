package com.personal.jspdb.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.personal.jspdb.model.Student;
import com.personal.jspdb.service.StudentService;

@WebServlet("/list/students")
public class StudentListServlets extends HttpServlet {
	
	private StudentService service;
	
	@Override
	public void init() throws ServletException {
		super.init();
		this.service = new StudentService();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Gson json = new Gson();
			String list = json.toJson(service.findALL());
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(list);
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving student data");
		}
	}
}