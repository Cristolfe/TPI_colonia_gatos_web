/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.ZonasAvistamientos;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author wowle
 */
    @WebServlet(name = "/SvPreCargarGato", urlPatterns = {"/SvPreCargarGato"})
    public class SvPreCargarGato extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            ControladorPersistente control = new ControladorPersistente();

            // Traemos todas las zonas de la base de datos
            List<ZonasAvistamientos> listaZonas = control.obtenerZonas();

            // Enviamos la lista al JSP
            request.setAttribute("listaZonas", listaZonas);
            request.getRequestDispatcher("registrar_gato.jsp").forward(request, response);
        }
}