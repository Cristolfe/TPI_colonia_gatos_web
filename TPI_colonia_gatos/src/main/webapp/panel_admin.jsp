<%-- 
    Document   : panel_admin
    Created on : 19 ene. 2026, 18:59:00
    Author     : wowle
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Administrador - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Cargamos tus estilos que ya funcionan en el panel voluntario --%>
    <link rel="stylesheet" href="css/estilos_paneles.css">
</head>
<body>

    <%-- 1. El Header que ya tenemos --%>
    <%@include file="header.jsp" %>

    <%-- 2. Estructura idéntica al Panel Voluntario --%>
    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 500px;">
            <h2 class="panel-title">Gestión de Administrador</h2>

            <%-- Botones de Gestión (Usando btn-panel que ya creamos) --%>
            <div class="mb-4">
                <a href="SvUsuarios" class="btn-panel">Gestión de Usuarios</a>
                <a href="SvCargarZonas" class="btn-panel">Gestión de Zonas</a>
                <a href="gestion_reportes.jsp" class="btn-panel">Gestión de Reportes</a>
                <a href="calendario.jsp" class="btn-panel">Calendario de Tareas</a>
            </div>

            <hr class="my-4" style="opacity: 0.1;">

            <%-- Acción de Salir (Estilo Cápsula Gris) --%>
            <a href="SvLogout" class="btn-volver-capsula">
                Salir
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>