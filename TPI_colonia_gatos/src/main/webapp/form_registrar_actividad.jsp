<%-- 
    Document   : form_registrar_actividad
    Created on : 23 ene. 2026, 09:19:33
    Author     : wowle
--%>


<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Actividad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <style>
        .titulo-tarea { color: #0056b3; font-weight: bold; }
        .label-azul-claro { color: #3a86ff; font-weight: 500; }
        .border-azul-suave { border: 1px solid #cfe2ff !important; }
        /* Ajuste para que los botones queden alineados */
        .btn-volver {
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    <%
        Usuario usuLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        String tipo = (String) request.getAttribute("tipoTarea");
        if (usuLogueado == null || tipo == null) { response.sendRedirect("loing.jsp"); return; }
    %>

    <div class="main-wrapper">
        <div class="panel-card" style="max-width: 600px;">
            <h2 class="panel-title titulo-tarea">Nueva Tarea: <%= tipo %></h2>
            <p class="text-center text-muted">Voluntario: <%= usuLogueado.getNombre() %></p>
            <hr>

            <form action="SvTareas" method="POST">
                <input type="hidden" name="tipoTarea" value="<%= tipo %>">

                <%-- ZONA: Solo para Alimentación y Captura --%>
                <% if (tipo.equals("Alimentacion") || tipo.equals("CapturaCastracion")) { %>
                <div class="mb-4">
                    <label class="form-label label-azul-claro">Zona de Avistamiento</label>
                    <select name="idZona" class="form-select border-azul-suave" required>
                        <% List<ZonasAvistamientos> zonas = (List<ZonasAvistamientos>) request.getAttribute("listaZonas");
                           if(zonas != null) {
                               for(ZonasAvistamientos z : zonas) { %>
                                <option value="<%= z.getIdAvistamiento() %>"><%= z.getNombreZona() %></option>
                        <%     } 
                           } %>
                    </select>
                </div>
                <% } %>

                <%-- GATO: Control, Seguimiento, Captura --%>
                <% if (tipo.equals("ControlVeterinario") || tipo.equals("VisitaSeguimiento") || tipo.equals("CapturaCastracion")) { %>
                <div class="mb-4">
                    <label class="form-label label-azul-claro">Seleccionar Gato</label>
                    <select name="idGato" class="form-select border-azul-suave" required>
                        <option value="" disabled selected>Seleccione el gato...</option>
                        <% List<Gato> gatos = (List<Gato>) request.getAttribute("listaGatos");
                           if(gatos != null) {
                               for(Gato g : gatos) { %>
                                <option value="<%= g.getIdGato() %>"><%= g.getNombre() %></option>
                        <%     }
                           } %>
                    </select>
                </div>
                <% } %>

                <%-- HOGAR: Transporte, Seguimiento --%>
                <% if (tipo.equals("TrasporteHogar") || tipo.equals("VisitaSeguimiento")) { %>
                <div class="mb-4">
                    <label class="form-label label-azul-claro">Seleccionar Hogar</label>
                    <select name="idHogar" class="form-select border-azul-suave" required>
                        <option value="" disabled selected>Seleccione el hogar...</option>
                        <% List<Hogares> hogares = (List<Hogares>) request.getAttribute("listaHogares");
                           if(hogares != null) {
                               for(Hogares h : hogares) { %>
                                <option value="<%= h.getIdHogar() %>"><%= h.getDireccion() %></option>
                        <%     }
                           } %>
                    </select>
                </div>
                <% } %>

                <div class="mb-4">
                    <label class="form-label label-azul-claro">Descripción / Detalles Adicionales</label>
                    <textarea name="descripcionLibre" class="form-control border-azul-suave" rows="3" required placeholder="Escriba aquí los detalles..."></textarea>
                </div>

                <%-- --- AQUÍ ESTÁ EL FRAGMENTO DE LOS BOTONES --- --%>
                <div class="row g-3 mt-2">
                    <div class="col-md-6">
                        <a href="registrar_tareas.jsp" class="btn btn-outline-secondary w-100 rounded-pill py-2 btn-volver">
                             &larr; Volver
                        </a>
                    </div>
                    <div class="col-md-6">
                        <button type="submit" class="btn-panel w-100 m-0 py-2">
                            Confirmar Registro
                        </button>
                    </div>
                </div>
                <%-- --- FIN DEL FRAGMENTO --- --%>

            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>