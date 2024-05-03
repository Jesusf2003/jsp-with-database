<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Modal para CRUD -->
<div id="modalCRUD" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white" id="exampleModalLabel"></h5>
            </div>
            <form id="formEstudiantes">
                <div class="modal-body">
                    <input id="id" name="id" hidden>

                    <label for="nombres" class="col-form-label">Nombres:</label>
                    <input type="text" class="form-control" id="nombres" name="name">

                    <label for="apellidos" class="col-form-label">Apellidos:</label>
                    <input id="apellidos" type="text" class="form-control" name="lastName">

                    <label for="dni" class="col-form-label">DNI:</label>
                    <input id="dni" type="text" class="form-control" name="documentDNI">

                    <label for="celular" class="col-form-label">Celular:</label>
                    <input id="celular" type="text" class="form-control" name="celphone">

                    <label for="email" class="col-form-label">Email:</label>
                    <input id="email" type="email" class="form-control" name="email">

                    <label for="carrera" class="col-form-label">Carrera:</label>
                    <select id="carrera" class="form-control" name="careerCode">
                        <option value="" disabled selected>Seleccione una carrera</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" id="btnGuardar" class="btn btn-dark">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>
