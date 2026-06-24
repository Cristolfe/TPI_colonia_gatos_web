<%-- 
    Document   : gestionar_usuarios
    Created on : 19 ene. 2026, 21:41:24
    Author     : wowle
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - Colonia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <style>
        .panel-card { background: white; border-radius: 20px; padding: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        /* Estilos para inputs estilo "cápsula" suave */
        .modal-body input, .modal-body select { 
            border-radius: 12px !important; 
            border: 1px solid #dee2e6; 
            padding: 12px;
            background-color: #f8f9fa;
        }
        .modal-body input:focus { background-color: #fff; box-shadow: 0 0 0 0.25 hide-rem #0d6efd25; }
        .label-form { font-weight: 600; color: #495057; font-size: 0.85rem; margin-bottom: 5px; margin-left: 5px; }
        
        /* Botón Guardar Celeste como en la imagen */
        .btn-guardar-celeste {
            background-color: #e1efff;
            color: #0056b3;
            font-weight: bold;
            border: none;
            border-radius: 50px;
            padding: 10px 30px;
            transition: 0.3s;
        }
        .btn-guardar-celeste:hover { background-color: #0056b3; color: white; }
        
        body { background-color: #f4f7f6; margin: 0; }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    <% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); %>

    <div class="main-wrapper" style="padding-top: 50px;">
        <div class="container">
            <div class="panel-card mx-auto" style="max-width: 1100px;">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 style="color: #333; font-weight: bold;">Gestión de Usuarios</h2>
                    <button type="button" class="btn-confirmar-capsula" style="width: auto; padding: 10px 25px;" 
                            data-bs-toggle="modal" data-bs-target="#modalAlta">
                        + Nuevo Usuario
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead style="background-color: #212529; color: white;">
                            <tr>
                                <th>DNI</th>
                                <th>Nombre Completo</th>
                                <th>Dirección</th>
                                <th>Tipo</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Usuario> lista = (List<Usuario>) session.getAttribute("listaUsuarios");
                                if (lista != null) {
                                    for (Usuario u : lista) {
                                        String fNac = (u.getFechNac() != null) ? sdf.format(u.getFechNac()) : "";
                                        String dir = (u.getDireccion() != null) ? u.getDireccion() : "";
                            %>
                            <tr>
                                <td><%= u.getDni() %></td>
                                <td class="fw-bold"><%= u.getNombre() %> <%= u.getApellido() %></td>
                                <td><%= dir %></td>
                                <td><span class="badge bg-light text-dark border"><%= u.getClass().getSimpleName() %></span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-warning rounded-pill px-3"
                                            onclick="prepararEdicion('<%= u.getDni() %>', '<%= u.getNombre() %>', '<%= u.getApellido() %>', '<%= u.getPass() %>', '<%= u.getClass().getSimpleName() %>', '<%= dir %>', '<%= fNac %>')">
                                        Editar
                                    </button>
                                    <form action="SvUsuarios" method="POST" style="display:inline;">
                                        <input type="hidden" name="dni" value="<%= u.getDni() %>">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <button type="submit" class="btn btn-sm btn-danger rounded-pill px-3" onclick="return confirm('¿Borrar usuario?')">Borrar</button>
                                    </form>
                                </td>
                            </tr>
                            <%      } 
                                } %>
                        </tbody>
                    </table>
                </div>
                <div class="text-center mt-4">
                    <a href="panel_admin.jsp" class="btn btn-outline-secondary rounded-pill px-4">&larr; Volver al Panel</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalAlta" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content" style="border-radius: 20px; border: none; overflow: hidden;">
                <div class="modal-header" style="background-color: #0056b3; color: white; border: none;">
                    <h5 class="modal-title fw-bold">Registrar Nuevo Usuario</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="SvUsuarios" method="POST">
                    <div class="modal-body p-4">
                        <input type="hidden" name="accion" value="crear">
                        
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="label-form">DNI (ID Acceso)</label>
                                <input type="number" name="dni" class="form-control" placeholder="Ej: 45678..." required>
                            </div>
                            <div class="col-md-4">
                                <label class="label-form">Nombre</label>
                                <input type="text" name="nombre" class="form-control" placeholder="Ej: Juan" required>
                            </div>
                            <div class="col-md-4">
                                <label class="label-form">Apellido</label>
                                <input type="text" name="apellido" class="form-control" placeholder="Ej: Pérez" required>
                            </div>

                            <div class="col-12">
                                <label class="label-form">Dirección Particular</label>
                                <input type="text" name="direccion" class="form-control" placeholder="Calle, Número y Ciudad" required>
                            </div>

                            <div class="col-md-6">
                                <label class="label-form">Fecha de Nacimiento</label>
                                <input type="date" name="fechNac" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="label-form">Contraseña</label>
                                <input type="password" name="pass" class="form-control" placeholder="***" required>
                            </div>

                            <div class="col-12">
                                <label class="label-form">Rol / Tipo de Usuario</label>
                                <select name="tipoUsuario" class="form-select">
                                    <option value="Voluntario">Voluntario</option>
                                    <option value="Administrador">Administrador</option>
                                    <option value="Veterinario">Veterinario</option>
                                    <option value="Familia">Familia</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0 p-4 pt-0">
                        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal" style="color: #999;">Cancelar</button>
                        <button type="submit" class="btn-guardar-celeste">Guardar Usuario</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalEditar" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content" style="border-radius: 20px; border: none; overflow: hidden;">
                <div class="modal-header" style="background-color: #0056b3; color: white;">
                    <h5 class="modal-title fw-bold">Modificar Usuario</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="SvUsuarios" method="POST">
                    <div class="modal-body p-4">
                        <input type="hidden" name="accion" value="confirmar_edicion">
                        <input type="hidden" name="dniOriginal" id="edit_dniOriginal">
                        
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="label-form">DNI</label>
                                <input type="number" name="dni" id="edit_dni" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="label-form">Nombre</label>
                                <input type="text" name="nombre" id="edit_nombre" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="label-form">Apellido</label>
                                <input type="text" name="apellido" id="edit_apellido" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <label class="label-form">Dirección</label>
                                <input type="text" name="direccion" id="edit_direccion" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="label-form">Fecha de Nacimiento</label>
                                <input type="date" name="fechNac" id="edit_fechNac" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="label-form">Contraseña</label>
                                <input type="password" name="pass" id="edit_pass" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <label class="label-form">Tipo</label>
                                <select name="tipoUsuario" id="edit_tipo" class="form-select">
                                    <option value="Voluntario">Voluntario</option>
                                    <option value="Administrador">Administrador</option>
                                    <option value="Veterinario">Veterinario</option>
                                    <option value="Familia">Familia</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0 p-4 pt-0">
                        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btn-guardar-celeste">Actualizar Datos</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function prepararEdicion(dni, nombre, apellido, pass, tipo, direccion, fechNac) {
            document.getElementById('edit_dniOriginal').value = dni;
            document.getElementById('edit_dni').value = dni;
            document.getElementById('edit_nombre').value = nombre;
            document.getElementById('edit_apellido').value = apellido;
            document.getElementById('edit_pass').value = pass;
            document.getElementById('edit_tipo').value = tipo;
            document.getElementById('edit_direccion').value = direccion;
            document.getElementById('edit_fechNac').value = fechNac;
            
            var myModal = new bootstrap.Modal(document.getElementById('modalEditar'));
            myModal.show();
        }
    </script>
</body>
</html>