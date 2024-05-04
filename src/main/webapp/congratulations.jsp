<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>DataTables estilo Bootstrap 5 - JSP</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap5.min.css">
    <style>
        table.dataTable thead {
            background-color: #0d6efd;
            color: aliceblue;
        }
    </style>
</head>
<body>
<div class="container justify-content-center align-items-center p-4">
    <div class="mx-auto">
        <h2 class="text-start mb-4 font-weight-bold">GESTIÓN DE ESTUDIANTES</h2>
        <div class="shadow p-3 mb-3 bg-white rounded">
            <div class="row">
                <div class="col-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <button id="btnCrear" class="btn bg-primary text-white">Registrar Estudiante</button>
                        <div>
                            <select id="careerFilter" class="form-control w-auto">
                                <option value="">-- Listar todas las Carreras --</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="shadow p-3 mb-2 bg-white rounded">
            <table id="tablaEstudiantes" class="flex table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>DNI</th>
                    <th>Celular</th>
                    <th>Email</th>
                    <th>Carrera</th>
                    <th class="text-center">Acciones</th>
                </tr>
                </thead>
                <tbody>
                <!-- Aquí irán los datos de los estudiantes -->
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@include file="form.jsp" %>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.0.2/dist/sweetalert2.all.min.js"></script>
<script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.22/js/dataTables.bootstrap5.min.js"></script>
<script>

    // Definición de constantes
    const APP_CONTEXT = '/JSPDB';
    const GET_STUDENT_URL = APP_CONTEXT + '/list/students';
    const GET_CAREER_URL = APP_CONTEXT + '/list/careers';
    const DELETE_STUDENT_URL = APP_CONTEXT + '/delete/student';
    const SAVE_STUDENT_URL = APP_CONTEXT + '/register/student';
    const EDIT_STUDENT_URL = APP_CONTEXT + '/edit/student';

    // Inicialización de DataTable
    let studentsTable = $('#tablaEstudiantes').DataTable({
        "ajax":{
            "url": GET_STUDENT_URL,
            "dataSrc":""
        },
        "columns":[
            {"data":"nombres"},
            {"data":"apellidos"},
            {"data":"dni"},
            {"data":"celular"},
            {"data":"email"},
            {"data":"career.nombre"},
            {"defaultContent":
                    "<button class='btn text-white bg-primary btn-sm btnEditar '>Editar</button>" +
                    "<button class='btn text-white btn-danger btn-sm btnBorrar ml-2'>Eliminar</button>"
            }
        ],
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.12.1/i18n/es-ES.json'
        },
    });

    // Funciones auxiliares
    function fillCareerSelect(careerSelected) {
        $('#carrera').empty().append('<option value="" disabled selected>Seleccione una carrera</option>');
        $('#careerFilter').empty().append('<option value="">-- Listar todas las Carreras --</option>');
        $.getJSON(GET_CAREER_URL, function(data) {
            $.each(data, function(key, val) {
                let option = '<option value="' + val.codigo + '">' + val.nombre + '</option>';
                if (val.nombre === careerSelected) {
                    $('#carrera').append('<option value="' + val.codigo + '" selected>' + val.nombre + '</option>');
                } else {
                    $('#carrera').append(option);
                    $('#careerFilter').append(option);
                }
            });
        });
    }

    function submitStudentForm(url) {
        let studentData = {
            id: $("#id").val(),
            name: $("#nombres").val(),
            lastName: $("#apellidos").val(),
            documentDNI: $("#dni").val(),
            celphone: $("#celular").val(),
            email: $("#email").val(),
            careerCode: $("#carrera").val()
        };

        $.ajax({
            url: url,
            type: "POST",
            data: studentData,
            success: function(data) {
                studentsTable.ajax.reload(null, false);
                $('#modalCRUD').modal('hide');
                let message = (studentData.id === "") ? "Estudiante creado correctamente!" : "Estudiante editado correctamente!";
                Swal.fire('¡Éxito!', message, 'success');
            }
        });
    }

    function filterByCareer() {
        let careerCode = $('#careerFilter').val();
        $.getJSON(GET_STUDENT_URL, function(data) {
            let filteredData;
            if (careerCode !== "") {
                filteredData = data.filter(student => student.career.codigo === careerCode);
            } else {
                filteredData = data;
            }
            studentsTable.clear().rows.add(filteredData).draw();
        });
    }

    // Eventos
    $(document).on("click", "#btnCrear", function(){
        $("#formEstudiantes").trigger("reset");
        fillCareerSelect("");
        $(".modal-title").text("Crear Estudiante");
        $('#modalCRUD').modal('show');
    });

    $(document).on("click", ".btnEditar", function(){
        let row = $(this).closest("tr");
        let student = studentsTable.row(row).data();
        $("#id").val(student.identificador);
        $("#nombres").val(student.nombres);
        $("#apellidos").val(student.apellidos);
        $("#dni").val(student.dni);
        $("#celular").val(student.celular);
        $("#email").val(student.email);
        fillCareerSelect(student.career.nombre);
        $(".modal-title").text("Editar Estudiante");
        $('#modalCRUD').modal('show');
    });

    $("#formEstudiantes").submit(function(e){
        e.preventDefault();
        let id = $("#id").val();
        let url = (id === "") ? SAVE_STUDENT_URL : EDIT_STUDENT_URL;
        submitStudentForm(url);
    });

    $(document).on("click", ".btnBorrar", function(){
        let row = $(this);
        let student = studentsTable.row(row.parents('tr')).data();
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡No podrás revertir esto!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, bórralo!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: DELETE_STUDENT_URL + '?id=' + student.identificador,
                    type: "DELETE",
                    success: function() {
                        studentsTable.row(row.parents('tr')).remove().draw();
                        Swal.fire('¡Eliminado!', '¡El estudiante ha sido eliminado.', 'success');
                    }
                });
            }
        });
    });

    $('#careerFilter').change(function() {
        filterByCareer();
    });

    fillCareerSelect("");
</script>
</body>
</html>