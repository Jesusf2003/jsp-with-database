<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<div class="container d-flex align-items-center justify-content-center"
		style="height: 100vh;">
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
                console.log('Students:', students);
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
                    row.innerHTML = `
                        <td>${index + 1}</td>
                        <td>${student.nombres}</td>
                        <td>${student.apellidos}</td>
                        <td>${student.dni}</td>
                        <td>${student.celular}</td>
                        <td>${student.email}</td>
                        <td>${student.contrasena}</td>
                    `;
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