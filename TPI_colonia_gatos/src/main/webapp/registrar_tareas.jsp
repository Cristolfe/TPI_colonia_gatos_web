<%-- 
    Document   : registrar_tareas
    Created on : 7 ene. 2026, 19:38:47
    Author     : wowle
--%>



<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seleccionar Tarea - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
</head>
<body>
   
    <%@include file="header.jsp" %>

    <%-- Estructura unificada: main-wrapper + panel-card --%>
    <div class="main-wrapper">
        <div class="panel-card">
            <h2 class="panel-title">Registrar Tarea</h2>
            
            <%-- Usamos la clase .btn-panel que definiste en tu CSS --%>
            <a href="SvPreCargarTareas?tipo=Alimentacion" class="btn-panel">Alimentación</a>
            <a href="SvPreCargarTareas?tipo=CapturaCastracion" class="btn-panel">Captura Castración</a>
            <a href="SvListarPostulaciones" class="btn-panel">Asignar Gato a Familia</a>
            <a href="SvPreCargarTareas?tipo=TrasporteHogar" class="btn-panel">Transporte a Hogar</a>
            <a href="SvPreCargarTareas?tipo=VisitaSeguimiento" class="btn-panel">Visita de Seguimiento</a>
            <a href="SvPreCargarTareas?tipo=ControlVeterinario" class="btn-panel">Control Veterinario</a>
            
            <hr class="my-4">
            <a href="panel_voluntario.jsp" class="btn btn-outline-secondary w-100 rounded-pill">Volver</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>