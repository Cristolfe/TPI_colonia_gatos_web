<%-- 
    Document   : exito_registrar_gato
    Created on : 7 ene. 2026, 18:59:27
    Author     : wowle
--%>
<%-- --%>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registro Exitoso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">

    <div class="card shadow-lg p-4 text-center" style="max-width: 450px; border-radius: 20px;">
        <h2 class="text-success fw-bold">✔ ¡Gato Guardado!</h2>
        <p class="text-muted">Escanea con tu celular desde cualquier lugar.</p>
        
        <% 
            String idGato = request.getParameter("id");
            if (idGato == null) { idGato = "0"; }

           //link de ngrok
            String urlPublica = "https://diacritically-univalent-clarita.ngrok-free.dev"; 
            
         
            String linkPerfil = urlPublica + "/TPI_colonia_gatos/SvVerPerfil?id=" + idGato;
            
            // Generador de QR
            String urlQR = "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=" + URLEncoder.encode(linkPerfil, "UTF-8");
        %>

        <div class="my-3 p-3 bg-white border rounded">
            <img src="<%= urlQR %>" alt="QR Ngrok" style="width: 250px; height: 250px;">
        </div>

        <div class="mt-2 mb-4">
            <small class="text-secondary">Enlace de acceso:</small><br>
            <code style="font-size: 0.75rem;"><%= linkPerfil %></code>
        </div>

        <a href="panel_voluntario.jsp" class="btn btn-primary w-100 shadow-sm">Volver al Panel</a>
    </div>

</body>
</html>













<%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Exitoso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .contenedor-exito { max-width: 450px; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); text-align: center; }
        .qr-wrapper { background: #fff; border: 1px solid #eee; padding: 15px; display: inline-block; margin: 20px 0; border-radius: 10px; }
    </style>
</head>
<body>
    <div class="contenedor-exito">
        <h2 class="fw-bold text-success">✔ ¡Gato Registrado!</h2>
        <p class="text-muted">Escanea este código con tu celular conectado al mismo WiFi.</p>
        
        <% 
            String idGato = request.getParameter("id");
            if (idGato == null || idGato.isEmpty()) { idGato = "0"; }

            // Tu IP real confirmada por ipconfig
            String ipLocal = "192.168.1.101"; 
            
            // Link local para tu red
            String linkPerfil = "http://" + ipLocal + ":8080/TPI_colonia_gatos/SvVerPerfil?id=" + idGato;
            
            // Generador de QR (API QRServer)
            String urlQR = "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=" + URLEncoder.encode(linkPerfil, "UTF-8");
        %>

        <div class="qr-wrapper shadow-sm">
            <img src="<%= urlQR %>" alt="QR Local" style="width: 250px; height: 250px;">
        </div>

        <div class="mt-2">
            <small class="text-secondary">Link generado:</small><br>
            <code style="font-size: 0.8rem;"><%= linkPerfil %></code>
        </div>

        <div class="d-grid gap-2 mt-4">
            <a href="panel_voluntario.jsp" class="btn btn-primary">Volver al Panel</a>
        </div>
    </div>
</body>
</html>


%--%>