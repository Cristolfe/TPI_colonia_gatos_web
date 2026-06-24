<%-- 
    Document   : panel_voluntario
    Created on : 7 ene. 2026, 18:44:10
    Author     : wowle
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Voluntario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
</head>
<body>
    <%@include file="header.jsp" %>

    <div class="main-wrapper">
        <div class="panel-card">
            <h2 class="panel-title">Panel Voluntario</h2>
            
            <a href="SvRegistrarGato" class="btn-panel">Registrar Nuevo Gato</a>
            <a href="registrar_tareas.jsp?destino=tarea" class="btn-panel">Registrar Tarea</a>
            <a href="registrar_hogar.jsp" class="btn-panel">Registrar Hogar</a>
            <a href="calendario.jsp" class="btn-panel">Calendario de Tareas</a>
            <hr class="my-4">
            <a href="SvLogout" class="btn btn-outline-danger w-100 rounded-pill">Cerrar Sesión</a>
        </div>
    </div>
</body>
</html>>