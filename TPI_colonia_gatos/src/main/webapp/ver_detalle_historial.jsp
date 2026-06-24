<%-- 
    Document   : ver_detalle_historial
    Created on : 22 ene. 2026, 18:30:26
    Author     : wowle
--%>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle Clínico - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <style>
        .section-title { border-bottom: 2px solid #0056b3; padding-bottom: 5px; margin-top: 25px; color: #0056b3; }
        .card-diag { border-left: 5px solid #28a745; margin-bottom: 15px; }
        .btn-volver-capsula {
            display: inline-block; padding: 10px 25px; background-color: #6c757d;
            color: white !important; border-radius: 50px; text-decoration: none;
            font-weight: bold; transition: 0.3s;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>

    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 900px; margin: 20px auto; padding: 20px;">
            
            <% 
                HistorialMedico h = (HistorialMedico) request.getAttribute("historial"); 
                Gato gato = (Gato) request.getAttribute("gato"); 

                if (h != null && gato != null) {
            %>
                <h2 class="text-center">Historial de <%= gato.getNombre() %></h2>
                <p class="text-center text-muted">ID Historial: #<%= h.getIdHistorial() %></p>
                <hr>

                <div class="card mb-4 border-info shadow-sm">
                    <div class="card-body bg-light">
                        <form action="SvCambiarEstadoSalud" method="POST" class="row align-items-center">
                            <input type="hidden" name="idGato" value="<%= gato.getIdGato() %>">
                            <input type="hidden" name="idHistorial" value="<%= h.getIdHistorial() %>">
                            
                            <div class="col-md-5">
                                <b>Estado Actual:</b> <span class="badge bg-info text-dark"><%= gato.getEstadoActual() %></span>
                            </div>
                            <div class="col-md-4">
                                <select name="nuevoEstado" class="form-select form-select-sm">
                                    <% for (Gato.EstadoSalud es : Gato.EstadoSalud.values()) { %>
                                        <option value="<%= es %>" <%= (es == gato.getEstadoActual()) ? "selected" : "" %>><%= es %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-info btn-sm w-100 text-white">Actualizar Salud</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card mb-4 shadow-sm border-primary">
                    <div class="card-header bg-primary text-white">➕ Nuevo Diagnóstico</div>
                    <div class="card-body">
                        <form action="SvAgregarDiagnostico" method="POST">
                            <input type="hidden" name="idHistorial" value="<%= h.getIdHistorial() %>">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <input type="text" name="diagnostico" class="form-control" placeholder="Diagnóstico" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <input type="text" name="tratamiento" class="form-control" placeholder="Tratamiento" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Guardar Registro</button>
                        </form>
                    </div>
                </div>

                <h4 class="section-title">Evolución Clínica</h4>
                <% if (h.getDiagnosticos() != null) { 
                    for (Diagnosticos diag : h.getDiagnosticos()) { %>
                    <div class="card card-diag shadow-sm p-3">
                        <h6><strong>Diagnóstico:</strong> <%= diag.getDescripcion() %></h6>
                        <p class="mb-0 text-success"><strong>Tratamiento:</strong> <%= (diag.getTratamiento() != null) ? diag.getTratamiento().getDescripcion() : "N/A" %></p>
                    </div>
                <% } } %>

                <h4 class="section-title">Estudios (PDF)</h4>
                <table class="table table-striped mt-3">
                    <thead class="table-dark">
                        <tr><th>Fecha</th><th>Descripción</th><th>Acción</th></tr>
                    </thead>
                    <tbody>
                        <% if (h.getEstudios() != null) { 
                            for (Estudios est : h.getEstudios()) { %>
                            <tr>
                                <td><%= est.getFecha() %></td>
                                <td><%= est.getDescripcion() %></td>
                                <td><a href="SvVerPDF?archivo=<%= est.getDescripcion() %>" target="_blank" class="btn btn-sm btn-outline-danger">Abrir</a></td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>

            <% } else { %>
                <div class="alert alert-danger text-center">No se encontraron los datos solicitados.</div>
            <% } %>

            <div class="text-center mt-4">
                <a href="SvListarHistoriales" class="btn-volver-capsula">Volver a la Lista</a>
            </div>
        </div>
    </div>
</body>
</html>