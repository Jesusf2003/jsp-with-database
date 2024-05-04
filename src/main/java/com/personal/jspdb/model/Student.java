package com.personal.jspdb.model;

import lombok.Data;

@Data
public class Student {

	private Long identificador;
	private String nombres;
	private String apellidos;
	private String dni;
	private String celular;
	private String email;
	private Career career;
}