/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.modelo.PostuladoParaAdopcion;
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
 * 
 */

@WebServlet(name = "SvAceptarAdopcion", urlPatterns = {"/SvAceptarAdopcion"})
public class SvAceptarAdopcion extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ControladorPersistente control = new ControladorPersistente();
        int id = Integer.parseInt(request.getParameter("idPostulacion"));

        try {
            PostuladoParaAdopcion postulacion = control.obtenerPostulacionPorId(id);
            
            if (postulacion != null) {
                // 1. Aceptar postulación
                postulacion.setAceptado(true);
                control.editarPostulacion(postulacion);

                // 2. Actualizar estado del gato
                Gato gato = postulacion.getGato();
                gato.setEstado_adopcion(Gato.EstadoAdopcion.ADOPTADO);
                control.editarGato(gato);

                response.sendRedirect("SvListarPostulaciones?msg=success");
            }
        } catch (Exception e) {
            response.sendRedirect("SvListarPostulaciones?msg=error");
        }
    }
}