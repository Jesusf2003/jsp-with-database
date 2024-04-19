<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.personal.jspdb.controller.StudentListServlets"%>
<jsp:useBean id="chartMast"
	class="com.personal.jspdb.controller.StudentListServlets"
	scope="session" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Lab05 | Insertion of data</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body>
	<div class="container d-flex align-items-center justify-content-center">
		<table id="studentTable" class="table">
			<thead>
				<tr>
					<th scope="col">Nombres</th>
					<th scope="col">Apellidos</th>
					<th scope="col"># DNI</th>
					<th scope="col">Celular</th>
					<th scope="col">Correo electrónico</th>
					<th scope="col">Contraseña</th>
				</tr>
			</thead>
			<tbody id="studentTableBody">
			</tbody>
		</table>
	</div>
	<script>
        document.addEventListener('DOMContentLoaded', function() {
            fetch('/Main/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(students => {
                renderStudents(students);
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
        });

        function renderStudents(students) {
            const tableBody = document.getElementById('studentTableBody');
            tableBody.innerHTML = ''; // Clear existing content
            if (Array.isArray(students)) {
                // Iterate through students array
                students.forEach((student, index) => {
                	const row = document.createElement('tr');

                    // Create and append table cells for each student property
                    const cellIndex = document.createElement('td');
                    cellIndex.textContent = index + 1;
                    row.appendChild(cellIndex);

                    const cellNombres = document.createElement('td');
                    cellNombres.textContent = student.nombres;
                    row.appendChild(cellNombres);

                    const cellApellidos = document.createElement('td');
                    cellApellidos.textContent = student.apellidos;
                    row.appendChild(cellApellidos);

                    const cellDni = document.createElement('td');
                    cellDni.textContent = student.dni;
                    row.appendChild(cellDni);

                    const cellCelular = document.createElement('td');
                    cellCelular.textContent = student.celular;
                    row.appendChild(cellCelular);

                    const cellEmail = document.createElement('td');
                    cellEmail.textContent = student.email;
                    row.appendChild(cellEmail);

                    const cellContrasena = document.createElement('td');
                    cellContrasena.textContent = student.contrasena;
                    row.appendChild(cellContrasena);

                    // Append the fully constructed row to the table body
                    tableBody.appendChild(row);
                });
            } else {
                console.error('Data is not in expected format:', students);
            }
            console.log('Table updated successfully');
        }
    </script>
</body>
</html>