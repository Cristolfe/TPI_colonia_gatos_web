<%-- 
    Document   : gestion_postulaciones
    Created on : 23 ene. 2026, 10:13:23
    Author     : wowle
--%>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Adopciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <style>
        .ancho-gestion {
            width: 95% !important;
            max-width: 1100px !important;
            margin-bottom: 30px;
        }
        .titulo-azul { color: #0056b3; font-weight: bold; }
        
        /* Ajuste para que el body no tenga espacio arriba */
        body { margin: 0 !important; padding: 0 !important; }

        /* Estilo para el botón volver centrado tipo cápsula */
        .contenedor-volver {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .btn-volver-capsula-centrado {
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            width: 300px; /* Ancho controlado para que se vea como en tus capturas */
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>

    <div class="main-wrapper" style="padding-top: 50px;">
        <div class="panel-card ancho-gestion">
            <h2 class="titulo-azul text-center">Postulaciones para Adopción</h2>
            <p class="text-center text-muted mb-4">Seleccione una familia para concretar la adopción.</p>
            
            <div class="table-container">
                <table class="table-custom">
                    <thead>
                        <tr class="text-center">
                            <th>Fecha</th>
                            <th>Gato</th>
                            <th>Familia Postulante</th>
                            <th>DNI</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<PostuladoParaAdopcion> lista = (List<PostuladoParaAdopcion>) request.getAttribute("listaPostulaciones");
                            if (lista != null && !lista.isEmpty()) {
                                for (PostuladoParaAdopcion p : lista) {
                        %>
                        <tr class="text-center">
                            <td><%= p.getFecha() %></td>
                            <td><span class="etiqueta-zona"><%= p.getGato().getNombre() %></span></td>
                            <td class="fw-bold"><%= p.getFamilia().getNombre() %></td>
                            <td><%= p.getFamilia().getDni() %></td>
                            <td>
                                <div style="display: flex; gap: 10px; justify-content: center;">
                                    <%-- Corregido: Pasamos los datos con comillas simples escapadas para evitar errores --%>
                                    <button class="btn-secondary" style="border-radius: 5px; font-size: 13px;" 
                                            onclick="verFamilia('<%= p.getFamilia().getNombre().replace("'", "\\'") %>', '<%= p.getFamilia().getDni() %>')">
                                        Ver Perfil
                                    </button>
                                    
                                    <form action="SvAceptarAdopcion" method="POST" style="margin:0;">
                                        <input type="hidden" name="idPostulacion" value="<%= p.getIdPostulacion() %>">
                                        <button type="submit" class="btn-main" style="border-radius: 5px; background: #28a745; color: white; border: none; font-size: 13px;">
                                            Aceptar
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <%      } 
                            } else { %>
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 60px; color: #888;">
                                    No hay postulaciones pendientes actualmente.
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="contenedor-volver">
                <a href="registrar_tareas.jsp" class="btn btn-outline-secondary rounded-pill py-2 btn-volver-capsula-centrado">
                     &larr; Volver
                </a>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalFamilia" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 15px; border: none;">
                <div class="modal-header" style="background: #0056b3; color: white; border-radius: 15px 15px 0 0;">
                    <h5 class="modal-title fw-bold">Datos de la Familia</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div id="contenidoModal">
                        <p class="mb-2"><strong>Responsable:</strong> <span id="spanNombre" class="text-muted"></span></p>
                        <p class="mb-0"><strong>DNI:</strong> <span id="spanDni" class="text-muted"></span></p>
                        <hr>
                        <p class="small text-muted text-center">Verifique la información antes de la adopción.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function verFamilia(nombre, dni) {
            // Seteamos los textos en los elementos específicos para evitar que fallen
            document.getElementById('spanNombre').innerText = nombre;
            document.getElementById('spanDni').innerText = dni;
            
            // Inicializamos y mostramos el modal de Bootstrap
            var myModal = new bootstrap.Modal(document.getElementById('modalFamilia'));
            myModal.show();
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>