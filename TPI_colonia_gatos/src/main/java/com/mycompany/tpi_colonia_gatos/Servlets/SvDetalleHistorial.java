/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.modelo.HistorialMedico;
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
 *
 */

@WebServlet("/SvVerDetalleHistorial")
public class SvDetalleHistorial extends HttpServlet {
 @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    ControladorPersistente control = new ControladorPersistente();
    String idStr = request.getParameter("id");

    if (idStr == null || idStr.isEmpty()) {
        response.sendRedirect("SvListarHistoriales");
        return;
    }

    int idHistorialBusca = Integer.parseInt(idStr);
    HistorialMedico historial = control.findHistorialMedico(idHistorialBusca);
    
    // Buscamos el gato que tiene este objeto medHistorial
    List<Gato> listaGatos = control.obtenerGatos();
    Gato gatoEncontrado = null;
    
    for (Gato g : listaGatos) {
        // Usamos el nombre correcto de tu atributo: medHistorial
        if (g.getMedHistorial() != null && g.getMedHistorial().getIdHistorial() == idHistorialBusca) {
            gatoEncontrado = g;
            break;
        }
    }
    
    request.setAttribute("historial", historial);
    request.setAttribute("gato", gatoEncontrado);
    request.getRequestDispatcher("ver_detalle_historial.jsp").forward(request, response);
}
}