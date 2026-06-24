/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "SvLogout", urlPatterns = {"/SvLogout"})
public class SvLogout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener la sesión actual
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. Eliminar los datos y destruir la sesión
            session.invalidate();
        }
        
        // 3. Redirigir a la página de login o inicio
        // Usamos un parámetro para avisar que cerró sesión con éxito
        response.sendRedirect("loing.jsp?logout=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Por lo general, el logout se hace por GET al clickear un enlace, 
        // pero podemos llamar al doGet por seguridad si se usa POST.
        doGet(request, response);
    }
}