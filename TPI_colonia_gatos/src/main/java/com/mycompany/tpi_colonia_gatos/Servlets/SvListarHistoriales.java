package com.mycompany.tpi_colonia_gatos.Servlets;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
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
@WebServlet("/SvListarHistoriales")
public class SvListarHistoriales extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Instanciar tu controlador de persistencia/lógica
        ControladorPersistente control = new ControladorPersistente();
        
        // 2. Traer todos los gatos de la BD
        List<Gato> listaGatos = control.obtenerGatos();
        
        // 3. Poner la lista en el request con el nombre exacto que usa el JSP
        request.setAttribute("listaGatos", listaGatos);
        
        // 4. Redirigir al JSP
        request.getRequestDispatcher("gestion_historiales.jsp").forward(request, response);
    }
}