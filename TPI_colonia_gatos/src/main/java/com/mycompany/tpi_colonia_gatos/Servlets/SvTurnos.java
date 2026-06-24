/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Turno;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author wowle
 */

@WebServlet("/SvTurnos")
public class SvTurnos extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ControladorPersistente control = new ControladorPersistente();
        List<Turno> listaTurnos = control.traerTurnos();
        
        // Formateo manual a JSON para FullCalendar
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < listaTurnos.size(); i++) {
            Turno t = listaTurnos.get(i);
            json.append("{")
                .append("\"title\":\"").append(t.getTitulo()).append("\",")
                .append("\"start\":\"").append(sdf.format(t.getFechaHora())).append("\"")
                .append("}");
            if (i < listaTurnos.size() - 1) json.append(",");
        }
        json.append("]");

        response.setContentType("application/json");
        response.getWriter().write(json.toString());
    }

    // El método POST genera los turnos (Acción del botón)
   
  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Verificar el rol desde la sesión
    HttpSession misession = request.getSession();
    String rol = (String) misession.getAttribute("rol");

    // 2. Si no es Admin, no dejarlo pasar
    if (rol != null && rol.equals("Admin")) {
        ControladorPersistente control = new ControladorPersistente();
        control.generarTurnosAutomaticos();
        response.sendRedirect("calendario.jsp?success=true");
    } else {
        // Redirigir a una página de error o al login si intenta hackear
        response.sendRedirect("login.jsp");
    }
}
}
