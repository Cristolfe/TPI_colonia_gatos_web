<%-- 
    Document   : panel_veterinario
    Created on : 22 ene. 2026, 18:17:49
    Author     : wowle
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Veterinario - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Cargamos tus estilos existentes --%>
    <link rel="stylesheet" href="css/estilos_paneles.css">
</head>
<body>

    <%-- 1. El Header (Incluye la validación de sesión y rol) --%>
    <%@include file="header.jsp" %>

    <%-- 2. Estructura del Panel --%>
    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 500px;">
            <h2 class="panel-title">Gestión Veterinaria</h2>

            <%-- Botones de Gestión Específicos para Veterinario --%>
            <div class="mb-4">
                <%-- Botón para ver historiales médicos --%>
                <a href="SvListarHistoriales" class="btn-panel">Ver Historiales Médicos</a>
                
                <%-- Botón para generar certificados (podría ser un servlet o reporte específico) --%>
                <a href="SvListarCertificados" class="btn-panel">Certificados de Adopción</a>
                
                
            </div>

            <hr class="my-4" style="opacity: 0.1;">

            <%-- Acción de Salir (Estilo Cápsula que ya manejas) --%>
            <a href="SvLogout" class="btn-volver-capsula">
                Salir
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
