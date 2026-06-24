<%-- 
    Document   : loing
    Created on : 6 ene. 2026, 13:44:11
    Author     : wowle
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Colonia de Gatos - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 2rem;
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            background-color: white;
        }
        .btn-main {
            background-color: #0056b3;
            border: none;
            border-radius: 50px;
            padding: 10px;
            font-weight: bold;
            transition: 0.3s;
        }
        .btn-main:hover {
            background-color: #004494;
            transform: translateY(-2px);
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            margin-bottom: 1rem;
        }
        .logo-text {
            color: #0056b3;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

    <div class="login-card text-center">
        <h1 class="logo-text">Colonia de Gatos</h1>
        
        <div class="mb-4">
            <h4 class="fw-bold">Inicio de sesión</h4>
            <p class="text-muted small">Ingresa tus credenciales para continuar</p>
        </div>

        <%-- MANEJO DE ERRORES DEL SERVLET --%>
        <% 
            String error = (String) request.getAttribute("error"); 
            if (error != null) { 
        %>
            <div class="alert alert-danger d-flex align-items-center py-2" role="alert" 
                 style="border-radius: 12px; font-size: 0.85rem;">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle-fill me-2" viewBox="0 0 16 16">
                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                </svg>
                <div><%= error %></div>
            </div>
        <% } %>

        <form action="SvLogin" method="POST">
            <div class="text-start">
                <label class="form-label small fw-bold">DNI</label>
                <input type="number" name="dni" class="form-control" placeholder="Ej: 12345678" required>
            </div>
            
            <div class="text-start">
                <label class="form-label small fw-bold">Contraseña</label>
                <input type="password" name="pass" class="form-control" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="btn btn-primary btn-main w-100 mt-3">Iniciar</button>
        </form>

        <hr class="my-4 text-muted">

        <div class="footer-link">
            <p class="small text-muted mb-2">¿No posees cuenta?</p>
            <a href="registro.jsp" class="btn btn-outline-secondary btn-sm w-100 rounded-pill">Registrarse</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>