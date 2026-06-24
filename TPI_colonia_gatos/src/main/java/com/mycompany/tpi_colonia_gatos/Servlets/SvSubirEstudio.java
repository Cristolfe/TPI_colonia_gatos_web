/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Estudios;
import edu.ugd.tpi_colonia_gatos.modelo.HistorialMedico;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author wowle
 */

@WebServlet(name = "SvSubirEstudio", urlPatterns = {"/SvSubirEstudio"})
@MultipartConfig
public class SvSubirEstudio extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Capturamos el ID del historial y la fecha del form
        int idHistorial = Integer.parseInt(request.getParameter("idHistorial"));
        String fechaStr = request.getParameter("fecha");
        LocalDate fecha = LocalDate.parse(fechaStr);

        // Capturamos el archivo PDF
        Part filePart = request.getPart("archivoPDF");
        if (filePart != null && filePart.getSize() > 0) {
            // Nombre del archivo: usamos el ID y tiempo para que sea único
            String fileName = "Gato_" + idHistorial + "_" + System.currentTimeMillis() + ".pdf";

            // Ruta física donde se guardará (Crea esta carpeta en tu PC)
            String path = "C:/ColoniaGatos/ArchivosEstudios/";
            File dir = new File(path);
            if(!dir.exists()) dir.mkdirs();

            filePart.write(path + fileName);

            // PERSISTENCIA
            ControladorPersistente control = new ControladorPersistente();

            // Creamos el estudio respetando tu constructor original
            // Recordar: guardamos el NOMBRE DEL ARCHIVO en la 'descripcion'
            Estudios nuevoEstudio = new Estudios(fecha, fileName);

            // Buscamos el historial por ID
            HistorialMedico historial = control.findHistorialMedico(idHistorial);

            // Usamos el método de tu clase: public void setEstudio(Estudios e) { this.estudios.add(e); }
            historial.setEstudio(nuevoEstudio);

            try {
                // Actualizamos el historial en la base de datos
                control.editarHistorial(historial);
            } catch (Exception ex) {
                Logger.getLogger(SvSubirEstudio.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        response.sendRedirect("SvListarHistoriales");
    }
 
    

}
