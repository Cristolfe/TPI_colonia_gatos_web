/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.*;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvPreCargarTareas", urlPatterns = {"/SvPreCargarTareas"})
public class SvPreCargarTareas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ControladorPersistente control = new ControladorPersistente();
        String tipo = request.getParameter("tipo");

        try {
            // 1. Cargamos Zonas (Para Alimentación y Captura)
            if (tipo.equals("Alimentacion") || tipo.equals("CapturaCastracion")) {
                request.setAttribute("listaZonas", control.obtenerZonas());
            }

            // 2. Cargamos Gatos (Asegúrate que el método se llame así en tu Control)
            if (tipo.equals("ControlVeterinario") || tipo.equals("VisitaSeguimiento") || tipo.equals("CapturaCastracion")) {
                // Si el error persiste, verifica si en tu controlador es "traerGatos" o "obtenerGatos"
                request.setAttribute("listaGatos", control.obtenerGatos()); 
            }

            // 3. Cargamos Hogares
            if (tipo.equals("TrasporteHogar") || tipo.equals("VisitaSeguimiento")) {
                request.setAttribute("listaHogares", control.traerHogares());
            }

            request.setAttribute("tipoTarea", tipo);
            request.getRequestDispatcher("form_registrar_actividad.jsp").forward(request, response);

        } catch (Exception e) {
            // Si hay un error de base de datos o de nombres de métodos, te manda atrás
            response.sendRedirect("registrar_tareas.jsp?error=metodo_no_encontrado");
        }
    }
}