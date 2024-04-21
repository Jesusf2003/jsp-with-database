<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Editar Estudiante</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editForm" action="/Main/edit" method="post">
                    <input type="hidden" id="editId" name="id">
                    <div class="mb-3">
                        <label for="editName" class="form-label">Nombres:</label>
                        <input type="text" class="form-control" id="editName" name="name">
                    </div>
                    <div class="mb-3">
                        <label for="editLastName" class="form-label">Apellidos:</label>
                        <input type="text" class="form-control" id="editLastName" name="lastName">
                    </div>
                    <div class="mb-3">
                        <label for="editDNI" class="form-label">DNI:</label>
                        <input type="text" class="form-control" id="editDNI" name="documentDNI">
                    </div>
                    <div class="mb-3">
                        <label for="editCelphone" class="form-label">Celular:</label>
                        <input type="text" class="form-control" id="editCelphone" name="celphone">
                    </div>
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Correo electrónico:</label>
                        <input type="email" class="form-control" id="editEmail" name="email">
                    </div>
                    <div class="mb-3">
                        <label for="editPassword" class="form-label">Contraseña:</label>
                        <input type="password" class="form-control" id="editPassword" name="password">
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</div>
