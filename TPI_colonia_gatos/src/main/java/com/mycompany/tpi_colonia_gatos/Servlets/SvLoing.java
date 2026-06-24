/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Administrador;
import edu.ugd.tpi_colonia_gatos.modelo.Familia;
import edu.ugd.tpi_colonia_gatos.modelo.Usuario;
import edu.ugd.tpi_colonia_gatos.modelo.Veterinario;
import edu.ugd.tpi_colonia_gatos.modelo.Voluntario;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author wowle
 */

@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLoing extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Obtener datos del formulario
        int dni = Integer.parseInt(request.getParameter("dni"));
        String pass = request.getParameter("pass");

        // 2. Usar tu lógica existente
        ControladorPersistente controlador = new ControladorPersistente(); // O como lo inicialices
        Usuario usuario = controlador.autenticarUsuario(dni, pass);

        // 3. Validaciones
        if (usuario == null || !usuario.getPass().equals(pass)) {
            request.setAttribute("error", "DNI o Contraseña incorrectos");
            request.getRequestDispatcher("loing.jsp").forward(request, response);
            return;
        }

        // 4. Guardar usuario en la SESIÓN (para que no se pierda al navegar)
        HttpSession session = request.getSession();
        session.setAttribute("usuarioLogueado", usuario);

        // 5. Redirección por roles (Tu lógica de Tab_Principal)
        if (usuario instanceof Administrador) {
            response.sendRedirect("panel_admin.jsp");
        } else if (usuario instanceof Veterinario) {
            response.sendRedirect("panel_veterinario.jsp");
        } else if (usuario instanceof Voluntario) {
            response.sendRedirect("panel_voluntario.jsp");
        } else if (usuario instanceof Familia) {
            response.sendRedirect("vergatos");
        }
    }
}