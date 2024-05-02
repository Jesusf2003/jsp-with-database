<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insertar datos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" />

</head>
<body>
<div class="container">
    <h1 class="mt-5 mb-4">Lista de Estudiantes</h1>
    <table id="studentTable" class="table">
        <thead>
        </thead>
        <tbody id="studentTableBody">
        </tbody>
    </table>
</div>

<%@include file="edit.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let STUDENTS;

    document.addEventListener('DOMContentLoaded', function () {
        fetchStudents();
    });

    function fetchStudents() {
        fetch('/JSPDB/list')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Error HTTP! Estado: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                STUDENTS = data;
                renderStudents(STUDENTS);
                initDataTable();
            })
            .catch(error => {
                console.error('Error al obtener datos:', error);
            });
    }

    function renderStudents(studentsData) {
        const tableBody = document.getElementById('studentTableBody');
        tableBody.innerHTML = '';
        studentsData.forEach(function (student) {
            let detalleTabla = "<tr id='studentRow" + student.identificador + "'>";
            detalleTabla += "<td>" + student.nombres + "</td>";
            detalleTabla += "<td>" + student.apellidos + "</td>";
            detalleTabla += "<td>" + student.dni + "</td>";
            detalleTabla += "<td>" + student.celular + "</td>";
            detalleTabla += "<td>" + student.email + "</td>";
            detalleTabla += "<td>" + student.contrasena + "</td>";
            detalleTabla += "<td>";
            detalleTabla += "<a href='javascript:void(0);' class='btn btn-primary btn-sm' onclick='openEditModal(" + student.identificador + ");'>Editar</a> ";
            detalleTabla += "<a href='javascript:void(0);' class='btn btn-danger btn-sm' onclick='deleteStudent(" + student.identificador + ");'>Eliminar</a>";
            detalleTabla += "</td>";
            detalleTabla += "</tr>";
            tableBody.innerHTML += detalleTabla;
        });
    }

    function deleteStudent(studentId) {
        if (confirm("¿Estás seguro de que quieres eliminar este estudiante?")) {
            fetch('/JSPDB/delete?id=' + studentId, {method: 'DELETE'})
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Error HTTP! Estado: ${response.status}`);
                    }
                    const studentRow = document.getElementById('studentRow' + studentId);
                    if (studentRow) {
                        studentRow.remove();
                    }
                })
                .catch(error => {
                    console.error('Error al eliminar estudiante:', error);
                    alert("Error al eliminar el estudiante. Por favor, inténtalo de nuevo más tarde.");
                });
        }
    }

    function openEditModal(studentId) {
        const student = STUDENTS.find(s => s.identificador === studentId);
        if (student) {
            document.getElementById('editId').value = student.identificador;
            document.getElementById('editName').value = student.nombres;
            document.getElementById('editLastName').value = student.apellidos;
            document.getElementById('editDNI').value = student.dni;
            document.getElementById('editCelphone').value = student.celular;
            document.getElementById('editEmail').value = student.email;
            document.getElementById('editPassword').value = student.contrasena;

            var myModal = new bootstrap.Modal(document.getElementById('editModal'), {
                keyboard: false
            });
            myModal.show();
        } else {
            console.error('No se encontró al estudiante con el ID:', studentId);
        }
    }

    function initDataTable() {
        $('#studentTable').DataTable({
            paging: true,
            searching: true,
            pageLength: 10,
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.12.1/i18n/es-ES.json'
            },
            columns: [
                { title: "Nombres" },
                { title: "Apellidos" },
                { title: "DNI" },
                { title: "Celular" },
                { title: "Correo electrónico" },
                { title: "Contraseña" },
                { title: "Acciones" }
            ]
        });
    }
</script>
</body>
</html>
