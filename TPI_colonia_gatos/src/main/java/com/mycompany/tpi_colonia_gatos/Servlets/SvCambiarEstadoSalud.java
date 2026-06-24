package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvCambiarEstadoSalud", urlPatterns = {"/SvCambiarEstadoSalud"})
public class SvCambiarEstadoSalud extends HttpServlet {

    @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) 
          throws ServletException, IOException {

      ControladorPersistente control = new ControladorPersistente();

      // Leemos los IDs
      int idGato = Integer.parseInt(request.getParameter("idGato"));
      int idHistorial = Integer.parseInt(request.getParameter("idHistorial"));
      String nuevoEstadoStr = request.getParameter("nuevoEstado");

      Gato g = control.obtenerGatoPorId(idGato);
      if (g != null) {
          g.setEstadoActual(Gato.EstadoSalud.valueOf(nuevoEstadoStr));
          control.editarGato(g);
      }

      // CORRECCIÓN: Nombre exacto del Servlet
      response.sendRedirect("SvVerDetalleHistorial?id=" + idHistorial);
  }
}