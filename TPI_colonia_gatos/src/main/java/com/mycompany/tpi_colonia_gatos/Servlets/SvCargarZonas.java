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
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author wowle
 */
@WebServlet(name = "SvCargarZonas", urlPatterns = {"/SvCargarZonas"})
public class SvCargarZonas extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ControladorPersistente control = new ControladorPersistente();
        // Trae la lista de zonas de la BD
        List<ZonasAvistamientos> listaZonas = control.obtenerZonas();
  
        // Construimos un String manual para no depender de librerías JSON
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < listaZonas.size(); i++) {
            ZonasAvistamientos z = listaZonas.get(i);
            sb.append("{ \"nombre\": \"").append(z.getNombreZona()).append("\" }");
            if (i < listaZonas.size() - 1) sb.append(",");
        }
        sb.append("]");

        // Pasamos el String directamente
        request.setAttribute("zonasJson", sb.toString());
        request.getRequestDispatcher("mapa_zonas.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    String nombre = request.getParameter("nombreZona");
    ControladorPersistente control = new ControladorPersistente();
    
    try {
        // 1. Validar duplicados (Tu lógica de escritorio)
        List<ZonasAvistamientos> existentes = control.obtenerZonas();
        boolean duplicada = existentes.stream()
                .anyMatch(z -> z.getNombreZona().equalsIgnoreCase(nombre));

        if (duplicada) {
            // En la web usamos atributos para avisar al usuario
            request.setAttribute("error", "Ya existe una zona con el nombre: " + nombre);
        } else {
            ZonasAvistamientos nueva = new ZonasAvistamientos();
            nueva.setNombreZona(nombre);
            control.crearZona(nueva);
            request.setAttribute("mensaje", "Zona creada con éxito");
        }
    } catch (Exception e) {
        request.setAttribute("error", "Error al crear: " + e.getMessage());
    }

    // Volvemos al mapa a través del Servlet de listado para que se actualice
    request.getRequestDispatcher("SvMapaZonas").forward(request, response);
}
    
    
    
    
}