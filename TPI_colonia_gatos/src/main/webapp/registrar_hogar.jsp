<%-- 
    Document   : registrar_hogar
    Created on : 23 ene. 2026, 10:46:23
    Author     : wowle
--%>


<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Hogar - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <style>
        .titulo-azul { color: #0056b3; font-weight: bold; }
        .label-azul-claro { color: #3a86ff; font-weight: 500; }
        .border-azul-suave { border: 1px solid #cfe2ff !important; }
        
        body { margin: 0 !important; padding: 0 !important; }
        .main-wrapper { padding-top: 50px; }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>

    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 550px;">
           
            <% 
                String status = request.getParameter("status");
                if ("ok".equals(status)) { 
            %>
                <div class="alert alert-success border-0 shadow-sm text-center mb-4" 
                     style="background-color: #e7f1ff; color: #0056b3; border-radius: 50px;">
                    <i class="bi bi-check-circle-fill me-2"></i> ¡Hogar registrado correctamente!
                </div>
            <% } %>


            
            <h2 class="panel-title titulo-azul text-center">Registrar Nuevo Hogar</h2>
            <p class="text-center text-muted mb-4">Ingrese la ubicación y el tipo de especialización.</p>
            <hr>

            <form action="SvHogares" method="POST">
                <div class="mb-4">
                    <label class="form-label label-azul-claro">Dirección Completa</label>
                    <input type="text" name="direccion" class="form-control border-azul-suave" 
                           placeholder="Ej: Av. Corrientes 1234" required>
                </div>

                <div class="mb-4">
                    <label class="form-label label-azul-claro">Tipo de Hogar</label>
                    <select name="tipoHogar" class="form-select border-azul-suave" required>
                        <option value="" disabled selected>Seleccione una opción...</option>
                        <option value="TRANSITO">Hogar de Tránsito (Temporal)</option>
                        <option value="ADOPCION">Hogar de Adopción (Permanente)</option>
                    </select>
                </div>

                <div class="row g-3 mt-2">
                    <div class="col-md-6">
                        <%-- Usando tu formato de botón volver centrado --%>
                        <a href="panel_voluntario.jsp" class="btn btn-outline-secondary w-100 rounded-pill py-2 d-flex align-items-center justify-content-center text-decoration-none">
                             &larr; Volver
                        </a>
                    </div>
                    <div class="col-md-6">
                        <button type="submit" class="btn-panel w-100 m-0 py-2">
                            Guardar Hogar
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>