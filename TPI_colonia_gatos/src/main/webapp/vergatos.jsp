<%-- 
    Document   : vergatos
    Created on : 5 ene. 2026, 13:58:33
    Author     : wowle
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.Gato" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.Usuario" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.Familia" %>

<%
    List<Gato> gatos = (List<Gato>) request.getAttribute("gatos");
    Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Adopción - Colonia de Gatos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card-img-top { height: 280px; object-fit: cover; background-color: #e9ecef; }
        .card { border: none; border-radius: 20px; overflow: hidden; transition: 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .card:hover { transform: translateY(-10px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        .main-container { padding-top: 40px; }
        /* Animación suave para el cartel */
        .alert-success { border-radius: 15px; border: none; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container main-container">
    
    <%-- BLOQUE DEL CARTEL DE ÉXITO --%>
    <% if (request.getParameter("exito") != null) { %>
        <div class="alert alert-success alert-dismissible fade show text-center mb-5" role="alert">
            <h4 class="alert-heading fw-bold">¡Su postulación ha sido exitosa!</h4>
            <p class="mb-0">En breves nos comunicaremos con Usted.</p>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <h2 class="mb-5 text-center fw-bold">Gatitos que buscan un hogar</h2>

    <div class="row">
        <% 
        if (gatos != null) { 
            for (Gato g : gatos) { 
                String fotoAMostrar = (g.getFoto() != null && !g.getFoto().trim().isEmpty()) ? g.getFoto() : "fotos/nofoto.png";
                String caracJS = (g.getCaracteristicas() != null) ? g.getCaracteristicas().replace("'", "\\'") : "Sin descripción.";
                String colorJS = (g.getColor() != null) ? g.getColor().replace("'", "\\'") : "No especificado";
        %>
            <div class="col-md-4 mb-5">
                <div class="card h-100 text-center">
                    <img src="<%= fotoAMostrar %>" class="card-img-top" onerror="this.onerror=null;this.src='fotos/nofoto.png';">
                    <div class="card-body d-flex flex-column justify-content-center">
                        <h5 class="card-title fw-bold text-dark"><%= g.getNombre() %></h5>
                        <button class="btn btn-primary rounded-pill px-4" 
                                onclick="verDetalle('<%= g.getNombre() %>', '<%= g.getIdGato() %>', '<%= fotoAMostrar %>', '<%= colorJS %>', '<%= caracJS %>')">
                            Ver Detalles
                        </button>
                    </div>
                </div>
            </div>
        <%  } 
        } %>
    </div>
</div>

<div class="modal fade" id="modalDetalle" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 25px;">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title fw-bold w-100 text-center" id="tituloGato" style="font-size: 1.8rem;"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center p-4">
        <img id="detFoto" src="" class="img-fluid rounded-4 shadow-sm mb-4" style="max-height: 280px; width: 100%; object-fit: cover;">
        
        <div class="text-start bg-light p-3 rounded-4 mb-4">
            <p class="mb-2"><strong>🎨 Color:</strong> <span id="detColor"></span></p>
            <p class="mb-1"><strong>📝 Sobre mí:</strong></p>
            <p id="detCarac" class="text-muted small mb-0" style="line-height: 1.5;"></p>
        </div>

        <% if (userLogueado instanceof Familia) { %>
            <form action="SvPostular" method="POST">
                <input type="hidden" name="idGato" id="inputGatoId">
                <button type="submit" class="btn btn-success btn-lg w-100 rounded-pill fw-bold">¡Quiero Adoptarlo!</button>
            </form>
        <% } else { %>
            <div class="alert alert-secondary rounded-pill py-2 small">
                Inicia sesión como <b>Familia</b> para postularte.
            </div>
        <% } %>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function verDetalle(nombre, id, foto, color, carac) {
        document.getElementById('tituloGato').innerText = nombre;
        document.getElementById( 'detFoto').src = foto;
        document.getElementById('detColor').innerText = color;
        document.getElementById('detCarac').innerText = carac;
        document.getElementById('inputGatoId').value = id;
        new bootstrap.Modal(document.getElementById('modalDetalle')).show();
    }
</script>
</body>
</html>