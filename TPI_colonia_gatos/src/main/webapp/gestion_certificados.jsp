<%-- 
    Document   : gestion_certificados
    Created on : 22 ene. 2026, 19:50:45
    Author     : wowle
--%>

<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Certificados de Adopción</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-volver-capsula {
            display: inline-block;
            padding: 10px 25px;
            background-color: #6c757d;
            color: white !important;
            border-radius: 50px;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-volver-capsula:hover {
            background-color: #495057;
            transform: scale(1.05);
        }
        .contenedor-blanco {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
    </style>
</head>
<body style="background-color: #f8f9fa;">

    <%@include file="header.jsp" %>

    <div class="container">
        <div class="contenedor-blanco">
            
            <h2 class="text-center mb-4" style="color: #0056b3;">Gestión de Certificados de Adopción</h2>

            <div class="table-responsive">
                <table class="table table-striped align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Estado Salud</th>
                            <th class="text-center">Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Gato> listaAptos = (List<Gato>) request.getAttribute("gatosAptos");
                            if (listaAptos != null && !listaAptos.isEmpty()) {
                                for (Gato g : listaAptos) {
                        %>
                        <tr>
                            <td><%= g.getIdGato() %></td>
                            <td><%= g.getNombre() %></td>
                            <td><%= g.getEstadoActual() %></td>
                            <td class="text-center">
                                <button class="btn btn-success btn-sm" 
                                        onclick="confirmarCertificado(<%= g.getIdGato() %>, '<%= g.getNombre() %>')">
                                    📜 Crear Certificado
                                </button>
                            </td>
                        </tr>
                        <%      } 
                            } else { %>
                        <tr>
                            <td colspan="4" class="text-center">No hay gatos pendientes (Estado NOAPTO).</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div> <hr class="my-4">
            <div class="d-flex justify-content-center">
                <a href="panel_veterinario.jsp" class="btn-volver-capsula">
                    ← Volver al Panel Principal
                </a>
            </div>

        </div> </div> <form id="formCertificado" action="SvCrearCertificado" method="POST" style="display:none;">
        <input type="hidden" name="idGato" id="idGatoCert">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmarCertificado(id, nombre) {
            Swal.fire({
                title: '¿Confirmar Certificado?',
                text: "El gato " + nombre + " pasará a ser APTO.",
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí, confirmar'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('idGatoCert').value = id;
                    document.getElementById('formCertificado').submit();
                }
            })
        }
    </script>
</body>
</html>