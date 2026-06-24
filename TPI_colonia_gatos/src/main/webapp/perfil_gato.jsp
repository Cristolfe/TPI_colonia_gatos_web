<%-- 
    Document   : perfil_gato
    Created on : 7 ene. 2026, 18:56:56
    Author     : wowle
--%>

<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.Gato" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% Gato g = (Gato) request.getAttribute("gato"); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil de <%= g.getNombre() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .profile-header { background: #0056b3; color: white; padding: 30px 0; border-radius: 0 0 30px 30px; }
        .cat-img { width: 150px; height: 150px; object-fit: cover; border: 5px solid white; border-radius: 50%; margin-top: -75px; background: white;}
        .info-card { border-radius: 20px; border: none; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <div class="profile-header text-center">
        <h1 class="fw-bold"><%= g.getNombre() %></h1>
        <p>ID: #<%= g.getIdGato() %></p>
    </div>

    <div class="container text-center mt-5">
        <img src="<%= g.getFoto() %>" class="cat-img shadow" alt="Foto de <%= g.getNombre() %>">
        
        <div class="row mt-4">
            <div class="col-12">
                <div class="card info-card p-4">
                    <h5 class="text-muted small fw-bold text-uppercase">Estado de Salud</h5>
                    <p class="fs-4 fw-bold text-primary"><%= g.getEstadoActual() %></p>
                    <hr>
                    <h5 class="text-muted small fw-bold text-uppercase">Características</h5>
                    <p><%= g.getCaracteristicas() %></p>
                    <hr>
                    <h5 class="text-muted small fw-bold text-uppercase">Zona habitual</h5>
                   
                    <p class="badge bg-info text-dark fs-6">
                        <%= (g.getZonas() != null) ? g.getZonas().getNombreZona() : "Sin zona asignada" %>
                    </p>
                </div>
            </div>
        </div>
        
        <a href="index.html" class="btn btn-outline-primary mt-4 rounded-pill">Volver al inicio</a>
    </div>
</body>
</html>