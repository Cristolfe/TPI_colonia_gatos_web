/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author wowle
 */
@WebServlet(name = "SvVerPerfil", urlPatterns = {"/SvVerPerfil"})
public class SvVerPerfil extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ControladorPersistente control = new ControladorPersistente();
       try {
            int id = Integer.parseInt(request.getParameter("id"));
            Gato gatoEncontrado = control.obtenerGatoPorId(id); 

            if (gatoEncontrado != null) {
                request.setAttribute("gato", gatoEncontrado);
                request.getRequestDispatcher("perfil_gato.jsp").forward(request, response);
            } else {
                // Si entra aquí, el ID no existe en la DB
                response.sendRedirect("error.jsp?msj=Gato_ID_" + id + "_no_existe");
            }
        } catch (Exception e) {
            // ESTO ES CLAVE: Imprime el error en la consola de NetBeans (Output)
            e.printStackTrace(); 
            response.sendRedirect("error.jsp?msj=" + e.getMessage());
        }
    }
}
