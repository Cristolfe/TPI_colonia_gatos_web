<%-- 
    Document   : gestion_historiales
    Created on : 22 ene. 2026, 18:25:39
    Author     : wowle
--%>


<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historiales Médicos - Sistema Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
</head>
<body>

    <%-- 1. Inclusión del Header (Seguridad por especialización) --%>
    <%@include file="header.jsp" %>

    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 95%; width: 1000px;">
            <h2 class="panel-title">Gestión de Historiales Médicos</h2>
            
            <div class="table-responsive">
                <table class="table table-hover align-middle mt-3">
                    <thead style="background-color: #0056b3; color: white;">
                        <tr>
                            <th>ID Historial</th>
                            <th>Gato (ID)</th>
                            <th>Nombre</th>
                            <th>Color</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                   <tbody>
                        <%
                            List<Gato> listaGatos = (List<Gato>) request.getAttribute("listaGatos");
                            if (listaGatos != null && !listaGatos.isEmpty()) {
                                for (Gato g : listaGatos) {

                                    int idH = 0;
                                    // USAMOS EL MÉTODO REAL DE TU CLASE: getMedHistorial()
                                    HistorialMedico historial = g.getMedHistorial(); 

                                    if (historial != null) {
                                        idH = historial.getIdHistorial();
                                    }
                        %>
                        <tr>
                            <td><strong>#<%= (idH > 0) ? idH : "N/A" %></strong></td>
                            <td><%= g.getIdGato() %></td>
                            <td><%= g.getNombre() %></td>
                            <td><%= g.getColor() %></td>
                            <td class="text-center">
                                <% if (idH > 0) { %>
                                    <a href="SvVerDetalleHistorial?id=<%= idH %>" class="btn btn-sm btn-primary">
                                        🔍 Ver Detalle
                                    </a>
                                    <button class="btn btn-sm btn-success" 
                                            onclick="prepararSubida(<%= idH %>, '<%= g.getNombre() %>')">
                                        ➕ Subir Estudio PDF
                                    </button>
                                <% } else { %>
                                    <span class="text-muted small">Sin Historial</span>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                            <tr><td colspan="5" class="text-center text-muted">No se encontraron gatos para listar.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="mt-4">
                <a href="panel_veterinario.jsp" class="btn-volver-capsula">Volver al Panel</a>
            </div>
        </div>
    </div>

    <%-- MODAL PARA SUBIR PDF --%>
    <div class="modal fade" id="modalSubirPDF" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="SvSubirEstudio" method="POST" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title">Subir Estudio: <span id="nombreGatoModal" class="text-primary"></span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="idHistorial" id="idHistorialModal">
                        
                        <div class="mb-3">
                            <label class="form-label">Fecha del Estudio</label>
                            <%-- Eliminamos el código Java de aquí para evitar el error del IDE --%>
                            <input type="date" name="fecha" id="inputFechaEstudio" class="form-control" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Archivo PDF del Estudio</label>
                            <input type="file" name="archivoPDF" class="form-control" accept="application/pdf" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar Estudio</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        /**
         * Función que prepara el modal antes de mostrarlo
         */
        function prepararSubida(id, nombre) {
            // Seteamos los datos del gato
            document.getElementById('idHistorialModal').value = id;
            document.getElementById('nombreGatoModal').innerText = nombre;
            
            // Seteamos la fecha actual usando JS (Formato YYYY-MM-DD)
            const hoy = new Date();
            const fechaFormateada = hoy.toISOString().split('T')[0];
            document.getElementById('inputFechaEstudio').value = fechaFormateada;
            
            // Mostramos el modal de Bootstrap
            var myModal = new bootstrap.Modal(document.getElementById('modalSubirPDF'));
            myModal.show();
        }
    </script>
</body>
</html>