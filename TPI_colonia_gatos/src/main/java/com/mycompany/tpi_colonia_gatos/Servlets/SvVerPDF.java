package com.mycompany.tpi_colonia_gatos.Servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SvVerPDF")
public class SvVerPDF extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreArchivo = request.getParameter("archivo");
        String modoDescarga = request.getParameter("download"); // Nuevo parámetro
        
        String rutaBase = "C:/ColoniaGatos/ArchivosEstudios/";
        File fichero = new File(rutaBase + nombreArchivo);

        if (fichero.exists()) {
            response.setContentType("application/pdf");
            
            // Si viene el parámetro download=true, usamos 'attachment', sino 'inline' (abrir)
            String disposicion = (modoDescarga != null && modoDescarga.equals("true")) ? "attachment" : "inline";
            
            response.addHeader("Content-Disposition", disposicion + "; filename=" + nombreArchivo);
            response.setContentLength((int) fichero.length());

            try (FileInputStream fis = new FileInputStream(fichero);
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesLeidos;
                while ((bytesLeidos = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesLeidos);
                }
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Archivo no encontrado.");
        }
    }
}