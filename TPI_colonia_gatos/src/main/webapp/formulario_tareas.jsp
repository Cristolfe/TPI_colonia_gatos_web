<%-- 
    Document   : formulario_tareas
    Created on : 7 ene. 2026, 19:51:45
    Author     : wowle
--%>

<%@ page import="java.util.List" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.ZonasAvistamientos" %>
<% 
    String tipo = request.getParameter("tipo"); 
    List<ZonasAvistamientos> zonas = (List<ZonasAvistamientos>) request.getAttribute("listaZonas");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar <%= tipo %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; padding: 50px; }
        .form-container { max-width: 500px; margin: auto; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .logo-text { color: #0056b3; font-weight: bold; margin-bottom: 25px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2 class="logo-text text-center">Registrar <%= tipo %></h2>
        <form action="SvTareas" method="POST">
            <input type="hidden" name="tipoTarea" value="<%= tipo %>">

            <div class="mb-3">
                <label class="form-label fw-bold">Seleccionar Zona</label>
                <select name="idZona" class="form-select" required>
                    <% if(zonas != null) { for(ZonasAvistamientos z : zonas) { %>
                        <option value="<%= z.getIdAvistamiento() %>"><%= z.getNombreZona() %></option>
                    <% } } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Ubicación / Detalle</label>
                <input type="text" name="ubicacion" class="form-control" required placeholder="Detalle la ubicación exacta">
            </div>

            <% if (tipo.equals("CapturaCastracion") || tipo.equals("ControlVeterinario") || tipo.equals("VisitaSeguimiento")) { %>
                <div class="mb-3">
                    <label class="form-label fw-bold text-primary">ID Gato</label>
                    <input type="number" name="idExtra" class="form-control" placeholder="Ingrese ID del gato" required>
                </div>
            <% } else if (tipo.equals("AsignarGatoFamilia")) { %>
                <div class="mb-3">
                    <label class="form-label fw-bold text-primary">ID Postulación</label>
                    <input type="number" name="idExtra" class="form-control" placeholder="Ingrese ID de postulación" required>
                </div>
            <% } else if (tipo.equals("TrasporteHogar")) { %>
                <div class="mb-3">
                    <label class="form-label fw-bold text-primary">ID Hogar</label>
                    <input type="number" name="idExtra" class="form-control" placeholder="Ingrese ID del hogar" required>
                </div>
            <% } %>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-primary py-2 rounded-pill fw-bold">Aceptar</button>
                <a href="registrar_tareas.jsp" class="btn btn-outline-secondary rounded-pill py-2">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>