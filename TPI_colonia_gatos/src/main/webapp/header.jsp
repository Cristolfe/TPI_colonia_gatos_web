<%-- 
    Document   : header
    Created on : 6 ene. 2026, 14:37:19
    Author     : wowle
--%>



<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.*" %>
<%@ page import="java.util.*" %>
<%
    // --- LÓGICA DE SEGURIDAD Y ROLES ---
    HttpSession sesionValidar = request.getSession(false);
    Usuario userHeader = (sesionValidar != null) ? (Usuario) sesionValidar.getAttribute("usuarioLogueado") : null;

    String uri = request.getRequestURI();
    String paginaActual = uri.substring(uri.lastIndexOf("/") + 1);

    // Bloqueo si no hay sesión (Corregido el nombre a login.jsp si fuera necesario, mantengo loing.jsp por tu archivo)
    if (userHeader == null && !paginaActual.equals("loing.jsp")) {
        response.sendRedirect("loing.jsp");
        return;
    }

    String rolVisible = "Usuario";
    if (userHeader != null) {
        List<String> paginasPermitidas = new ArrayList<>();
        // Páginas comunes para todos los logueados
        paginasPermitidas.add("SvLogout");

        if (userHeader instanceof Administrador) {
            rolVisible = "Administrador";
            paginasPermitidas.add("panel_admin.jsp");
            paginasPermitidas.add("gestionar_usuarios.jsp");
            paginasPermitidas.add("gestion_reportes.jsp");
            paginasPermitidas.add("registro_gato.jsp");
            paginasPermitidas.add("calendario.jsp");
            
        } else if (userHeader instanceof Veterinario) {
            rolVisible = "Veterinario";
            paginasPermitidas.add("SvDetalleHistorial");
            paginasPermitidas.add("SvCambiarEstadoSalud");
            paginasPermitidas.add("panel_veterinario.jsp");
            paginasPermitidas.add("gestion_historiales.jsp");
            paginasPermitidas.add("ver_detalle_historial.jsp");
            paginasPermitidas.add("SvVerDetalleHistorial");
            paginasPermitidas.add("SvListarHistoriales");
            paginasPermitidas.add("SvSubirEstudio");      
            paginasPermitidas.add("SvVerPDF");           
            paginasPermitidas.add("gestion_certificados.jsp");
            paginasPermitidas.add("SvListarCertificados");
            paginasPermitidas.add("SvCrearCertificado");

        } else if (userHeader instanceof Voluntario) {
            rolVisible = "Voluntario";
            paginasPermitidas.add("panel_voluntario.jsp");
            paginasPermitidas.add("registrar_tareas.jsp"); 
            paginasPermitidas.add("calendario.jsp");
            paginasPermitidas.add("registrar_gato.jsp");
            paginasPermitidas.add("SvRegistrarGato");
            paginasPermitidas.add("SvTareas");
            paginasPermitidas.add("form_registrar_actividad.jsp"); 
            paginasPermitidas.add("SvPreCargarTareas");
            paginasPermitidas.add("SvListarPostulaciones");
            paginasPermitidas.add("gestion_postulaciones.jsp");
           paginasPermitidas.add("registrar_hogar.jsp");
           paginasPermitidas.add("SvHogares");
            
        } else if (userHeader instanceof Familia) {
            rolVisible = "Familia";
            paginasPermitidas.add("vergatos.jsp");
        }

        // Validación de acceso por página
        // Corregido: Si es veterinario y va a su panel, no debe rebotar al de admin
        if (!paginasPermitidas.contains(paginaActual) && !paginaActual.isEmpty()) {
            
            String destinoRedireccion = "loing.jsp"; // Por defecto
            if (userHeader instanceof Administrador) destinoRedireccion = "panel_admin.jsp";
            else if (userHeader instanceof Veterinario) destinoRedireccion = "panel_veterinario.jsp";
            else if (userHeader instanceof Voluntario) destinoRedireccion = "panel_voluntario.jsp";
            
            response.sendRedirect(destinoRedireccion + "?error=sin_permiso");
            return;
        }
    }
%>

<style>
    :root { --navbar-height: 60px; }
    .navbar-custom {
        background-color: #0056b3; 
        color: white;
        height: var(--navbar-height);
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
        position: relative; 
        z-index: 1000;
    }
    .navbar-custom a { color: white; text-decoration: none; font-weight: bold; }
    .user-info { display: flex; align-items: center; gap: 10px; }
    .user-icon { width: 25px; height: 25px; filter: brightness(0) invert(1); }
    .badge-rol {
        font-size: 0.75em;
        background: rgba(255, 255, 255, 0.2);
        padding: 2px 8px;
        border-radius: 10px;
        margin-left: 5px;
        font-weight: normal;
        text-transform: uppercase;
    }
    .btn-salir {
        font-size: 0.8em;
        background: rgba(255,255,255,0.2);
        padding: 5px 12px;
        border-radius: 4px;
        margin-left: 10px;
        transition: 0.2s;
    }
    .btn-salir:hover { background: rgba(255,255,255,0.3); }
</style>

<div class="navbar-custom">
    <div class="logo">
        <% 
            String linkLogo = "loing.jsp";
            if(userHeader instanceof Administrador) linkLogo = "panel_admin.jsp";
            else if(userHeader instanceof Veterinario) linkLogo = "panel_veterinario.jsp";
            else if(userHeader instanceof Voluntario) linkLogo = "panel_voluntario.jsp";
        %>
        <a href="<%= linkLogo %>">Colonia de Gatos</a>
    </div>
    
    <div class="user-info">
        <% if (userHeader != null) { %>
            <img src="iconos/user-icon.png" class="user-icon" alt="user">
            <div style="display: flex; flex-direction: column;">
                <span><%= userHeader.getNombre() %></span>
                <span class="badge-rol"><%= rolVisible %></span>
            </div>
            <a href="SvLogout" class="btn-salir">Salir</a>
        <% } else { %>
            <a href="loing.jsp">Loguear</a>
        <% } %>
    </div>
</div>