/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Familia;
import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.modelo.PostuladoParaAdopcion;
import edu.ugd.tpi_colonia_gatos.modelo.Usuario;
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
 * 
 */


@WebServlet("/SvPostular")
public class SvPostular extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        ControladorPersistente controlador = new ControladorPersistente();

        if (usuario == null || !(usuario instanceof Familia)) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int idGato = Integer.parseInt(request.getParameter("idGato"));
            Gato gato = controlador.obtenerGatoPorId(idGato);

            if (gato != null) {
                PostuladoParaAdopcion post = new PostuladoParaAdopcion(
                    gato,
                    (Familia) usuario,
                    java.time.LocalDate.now(),
                    false 
                );

                controlador.crearPostulacion(post);
                
                // UN SOLO REDIRECT con todos los parámetros necesarios
                // Usamos & para separar parámetros si quieres enviar más de uno
                response.sendRedirect("vergatos?exito=true"); 
            }
        } catch (Exception e) {
            // Si algo falla, es bueno volver con un error
            response.sendRedirect("vergatos?error=true");
        }
    }
}