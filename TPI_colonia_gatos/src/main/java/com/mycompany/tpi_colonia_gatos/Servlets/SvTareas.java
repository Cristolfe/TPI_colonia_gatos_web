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
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet(name = "SvTareas", urlPatterns = {"/SvTareas"})
public class SvTareas extends HttpServlet {
     @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

    ControladorPersistente control = new ControladorPersistente();
    HttpSession session = request.getSession();

    try {
        // 1. Obtenemos el usuario de la sesión (usando el nombre de tu header)
        Usuario usuSesion = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuSesion == null) {
            response.sendRedirect("loing.jsp");
            return;
        }

        // 2. Traemos el objeto completo y hacemos el cast a Voluntario
        Usuario usuDB = control.obtenerUsuarioConDNI(usuSesion.getDni());
        Voluntario voluntario = (Voluntario) usuDB;

        // 3. Captura de datos del formulario
        String tipoTarea = request.getParameter("tipoTarea");
        String ubicacionManual = request.getParameter("ubicacion"); // Detalle escrito
        String idExtra = request.getParameter("idExtra"); // ID de Gato u Hogar
        int idAvistamiento = Integer.parseInt(request.getParameter("idZona")); // ID de la Zona

        // 4. Búsqueda automática de la Zona para el detalle final
        ZonasAvistamientos zona = control.traerZona(idAvistamiento);
        String ubicacionFinal = (zona != null ? zona.getNombreZona() : "Sin Zona") + " - " + ubicacionManual;

        // 5. Generación AUTOMÁTICA de Fecha y Hora
        LocalDate fecha = LocalDate.now();
        LocalTime hora = LocalTime.now();

        Tarea tareaFinal = null;

        // 6. Lógica de creación según el tipo
        switch (tipoTarea) {
            case "Alimentacion":
                tareaFinal = new Alimentacion(voluntario, fecha, hora, ubicacionFinal);
                break;
                
            case "ControlVeterinario":
                ControlVeterinario cv = new ControlVeterinario(voluntario, fecha, hora, ubicacionFinal);
                if (idExtra != null) cv.setGato(control.obtenerGatoPorId(Integer.parseInt(idExtra)));
                tareaFinal = cv;
                break;
                
            case "TrasporteHogar":
                TrasporteHogar th = new TrasporteHogar(voluntario, fecha, hora, ubicacionFinal);
                if (idExtra != null) th.setHogar(control.traerHogar(Integer.parseInt(idExtra)));
                tareaFinal = th;
                break;
                
            case "CapturaCastracion":
                CapturaCastracion cc = new CapturaCastracion(voluntario, fecha, hora, ubicacionFinal);
                if (idExtra != null) cc.setGato(control.obtenerGatoPorId(Integer.parseInt(idExtra)));
                tareaFinal = cc;
                break;
                
            case "AsignarGatoFamilia":
                tareaFinal = new AsignarGatoFamilia(voluntario, fecha, hora, ubicacionFinal);
                break;
        }

        // 7. Persistencia
        if (tareaFinal != null) {
            control.crearTarea(tareaFinal);
        }

        response.sendRedirect("panel_voluntario.jsp?tarea=ok");

    } catch (ClassCastException e) {
        response.sendRedirect("panel_voluntario.jsp?error=no_es_voluntario");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("registrar_tareas.jsp?error=1");
    }
}

}