<%-- 
    Document   : ver_calendario
    Created on : 14 ene. 2026, 22:08:46
    Author     : wowle
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Importamos las clases para que el 'instanceof' funcione --%>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.Administrador" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.Voluntario" %>

<%
    // Recuperamos el objeto de la sesión usando el nombre de tu header
    Object userSesion = session.getAttribute("usuarioLogueado");

    // Redirección de seguridad si no hay sesión activa
    if (userSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calendario - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>

    <style>
        #calendar { 
            max-width: 100%; 
            margin-bottom: 20px;
            background: white;
            padding: 10px;
            border-radius: 15px;
            color: #333;
        }
        .btn-small-capsula {
            width: auto !important;
            padding: 5px 20px !important;
            font-size: 0.9rem !important;
            display: inline-block !important;
            text-decoration: none !important;
        }
        .fc-event { cursor: pointer; background-color: #0056b3 !important; border: none !important; }
        .fc-button-primary { background-color: #0056b3 !important; border: none !important; border-radius: 50px !important; }
        .fc-toolbar-title { color: #0056b3; font-weight: bold; }
    </style>
</head>
<body>

    <%@include file="header.jsp" %>

    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 900px;">
            <h2 class="panel-title mb-3">Calendario de Turnos</h2>

            <%-- VALIDACIÓN POR CLASE: Solo el Administrador ve el botón --%>
            <% if (userSesion instanceof Administrador) { %>
                <div class="text-center mb-4">
                    <form action="SvTurnos" method="POST">
                        <button type="submit" class="btn-confirmar-capsula btn-small-capsula">
                            Asignar Voluntario por Día
                        </button>
                    </form>
                </div>
            <% } %>

            <div id='calendar'></div>

            <div class="text-center mt-3">
                <%-- Botón volver dinámico según la clase --%>
                <% if (userSesion instanceof Administrador) { %>
                    <a href="panel_admin.jsp" class="btn-volver-capsula btn-small-capsula">Volver al Panel</a>
                <% } else { %>
                    <a href="panel_voluntario.jsp" class="btn-volver-capsula btn-small-capsula">Volver al Panel</a>
                <% } %>
            </div>
        </div>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          locale: 'es', 
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth'
          },
          events: 'SvTurnos', 
          eventClick: function(info) {
            alert('Tarea: ' + info.event.title);
          }
        });
        calendar.render();
      });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>