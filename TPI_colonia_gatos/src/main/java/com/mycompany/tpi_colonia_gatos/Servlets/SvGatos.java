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
import java.util.ArrayList;
import java.util.List;



@WebServlet("/vergatos")
public class SvGatos extends HttpServlet {

    @Override
 protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    ControladorPersistente control = new ControladorPersistente();
    
    // 1. Obtenemos todos los gatos de la BD
    List<Gato> todosLosGatos = control.obtenerGatos(); // Asumo que tienes este método
    
    // 2. Obtenemos todas las postulaciones actuales
    List<PostuladoParaAdopcion> postulaciones = control.obtenerPostulaciones();
    
    // 3. Creamos una lista para los gatos que S? vamos a mostrar
    List<Gato> gatosDisponibles = new ArrayList<>();

    for (Gato g : todosLosGatos) {
        // Regla A: Que el estado de adopción sea APTO (no ADOPTADO ni NOAPTO)
        boolean esApto = (g.getEstado_adopcion() == Gato.EstadoAdopcion.APTO);
        
        // Regla B: Que no tenga ninguna postulación pendiente
        boolean tienePostulacion = false;
        for (PostuladoParaAdopcion p : postulaciones) {
            if (p.getGato().getIdGato() == g.getIdGato()) {
                tienePostulacion = true;
                break;
            }
        }

        // Si cumple ambas, lo agregamos a la lista que verá el usuario
        if (esApto && !tienePostulacion) {
            gatosDisponibles.add(g);
        }
    }

    // 4. Enviamos solo los disponibles al JSP
    request.setAttribute("gatos", gatosDisponibles);
    request.getRequestDispatcher("vergatos.jsp").forward(request, response);
}
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Recoger parámetros del formulario
    String nombre = request.getParameter("nombreGato");
    
    // 2. Crear el objeto
    Gato nuevoGato = new Gato();
    nuevoGato.setNombre(nombre);
    
    // 3. Persistir
    ControladorPersistente ctrl = new ControladorPersistente();
    ctrl.crearGato(nuevoGato);
    
    // 4. Redirigir a la lista para ver el cambio
    response.sendRedirect("vergatos");
}

}
