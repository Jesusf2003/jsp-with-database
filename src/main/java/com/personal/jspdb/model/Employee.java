package com.personal.jspdb.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class Employee implements Serializable {

	private static final long serialVersionUID = 1L;

	private String firstName;
	private String lastName;
	private String username;
	private String password;
	private String address;
	private String contact;
}