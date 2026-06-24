<%-- 
    Document   : registro
    Created on : 6 ene. 2026, 15:37:07
    Author     : wowle
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Colonia de Gatos - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; margin: 0; }
        .register-card { width: 100%; max-width: 500px; padding: 2.5rem; border: none; border-radius: 25px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); background-color: white; }
        .btn-main { background-color: #0056b3; color: white; border: none; border-radius: 50px; padding: 12px; font-weight: bold; transition: 0.3s; }
        .btn-main:hover { background-color: #004494; transform: translateY(-2px); color: white; }
        .form-control { border-radius: 10px; padding: 10px; background-color: #fcfcfc; }
        .logo-text { color: #0056b3; font-weight: bold; text-align: center; margin-bottom: 0.5rem; }
    </style>
</head>
<body>

    <div class="register-card">
        <h1 class="logo-text">Crear Cuenta</h1>
        <p class="text-center text-muted mb-4">Ingresa tus datos personales</p>

        <form action="SvRegistroFamiliar" method="POST">
            <div class="mb-3">
                <label class="form-label small fw-bold">DNI</label>
                <input type="number" name="dni" class="form-control" placeholder="Documento de identidad" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label small fw-bold">Apellido</label>
                    <input type="text" name="apellido" class="form-control" placeholder="Pérez" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label small fw-bold">Nombre</label>
                    <input type="text" name="nombre" class="form-control" placeholder="Juan" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label small fw-bold">Fecha de Nacimiento</label>
                <input type="date" name="fechaNac" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label small fw-bold">Dirección</label>
                <input type="text" name="direccion" class="form-control" placeholder="Calle, Número, Ciudad" required>
            </div>

            <div class="mb-4">
                <label class="form-label small fw-bold">Contraseña</label>
                <input type="password" name="pass" class="form-control" placeholder="Crea tu clave" required>
            </div>

            <button type="submit" class="btn btn-main w-100 shadow-sm">Registrarse</button>
        </form>

        <div class="text-center mt-4">
            <p class="small text-muted">¿Ya tienes cuenta? <a href="loing.jsp" class="fw-bold text-decoration-none" style="color: #0056b3;">Inicia sesión aquí</a></p>
        </div>
    </div>

</body>
</html>