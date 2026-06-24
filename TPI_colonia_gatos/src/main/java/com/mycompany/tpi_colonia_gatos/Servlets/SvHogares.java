/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.HogarAdopcion;
import edu.ugd.tpi_colonia_gatos.modelo.HogarTransito;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author wowle
 */

@WebServlet(name = "SvHogares", urlPatterns = {"/SvHogares"})
public class SvHogares extends HttpServlet {
    ControladorPersistente control = new ControladorPersistente();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String direccion = request.getParameter("direccion");
        String tipoHogar = request.getParameter("tipoHogar");

        if (tipoHogar.equals("TRANSITO")) {
            HogarTransito ht = new HogarTransito();
            ht.setDireccion(direccion);
            control.crearHogar(ht); // Tu controladora debe recibir el objeto padre o genérico
        } else {
            HogarAdopcion ha = new HogarAdopcion();
            ha.setDireccion(direccion);
            control.crearHogar(ha);
        }

        response.sendRedirect("registrar_hogar.jsp?status=ok");
    }
}