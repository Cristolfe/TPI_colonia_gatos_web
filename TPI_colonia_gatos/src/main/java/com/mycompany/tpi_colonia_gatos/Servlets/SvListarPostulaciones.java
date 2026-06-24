/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.PostuladoParaAdopcion;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author wowle
 */
@WebServlet(name = "SvListarPostulaciones", urlPatterns = {"/SvListarPostulaciones"})
public class SvListarPostulaciones extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ControladorPersistente control = new ControladorPersistente();
        
        // Asumiendo que tienes este método en tu controlador
        List<PostuladoParaAdopcion> lista = control.obtenerPostulaciones(); 
        
        // Filtramos para mostrar solo las pendientes
        List<PostuladoParaAdopcion> pendientes = lista.stream()
                .filter(p -> !p.getAceptado())
                .collect(Collectors.toList());

        request.setAttribute("listaPostulaciones", pendientes);
        request.getRequestDispatcher("gestion_postulaciones.jsp").forward(request, response);
    }
}