package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.modelo.HistorialMedico;
import edu.ugd.tpi_colonia_gatos.modelo.ZonasAvistamientos;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "SvRegistrarGato", urlPatterns = {"/SvRegistrarGato"})
public class SvRegistrarGato extends HttpServlet {

    // EL METODO GET ES EL QUE TRAE LAS ZONAS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ControladorPersistente control = new ControladorPersistente();
        
        // 1. Buscamos las zonas en la DB
        List<ZonasAvistamientos> listaZonas = control.obtenerZonas();
        
        // 2. Las enviamos al JSP con el nombre que espera: "listaZonas"
        request.setAttribute("listaZonas", listaZonas);
        
        // 3. Abrimos el JSP (importante: usamos forward)
        request.getRequestDispatcher("registrar_gato.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ControladorPersistente control = new ControladorPersistente();
        
        try {
            // Captura de datos
            String nombre = request.getParameter("nombre");
            String color = request.getParameter("color");
            String desc = request.getParameter("caracteristicas");
            String foto = request.getParameter("foto");
            
            Gato.EstadoSalud estado = Gato.EstadoSalud.valueOf(request.getParameter("estadoActual"));
            Gato.EstadoAdopcion situacion = Gato.EstadoAdopcion.valueOf(request.getParameter("estado_adopcion"));
            
            String nombreZona = request.getParameter("nombreZona");
            ZonasAvistamientos zonaSeleccionada = control.traerZonaPorNombre(nombreZona);

            // Crear el objeto Gato
            Gato nuevoGato = new Gato(nombre, color, desc, foto, estado, situacion);
            nuevoGato.setZonas(zonaSeleccionada);

            // Crear el Historial Médico (Evita el #N/A en la tabla)
            HistorialMedico medHistorial = new HistorialMedico();
            medHistorial.setDescripcion("Registro inicial de " + nombre);
            nuevoGato.setMedHistorial(medHistorial);

            // Guardar
            control.crearGato(nuevoGato);
            
            // Redirigir al éxito
            response.sendRedirect("exito_registrar_gato.jsp?id=" + nuevoGato.getIdGato());

        } catch (Exception e) {
            response.sendRedirect("registrar_gato.jsp?error=1");
        }
    }
}