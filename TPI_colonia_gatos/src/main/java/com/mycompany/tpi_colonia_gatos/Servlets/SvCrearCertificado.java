/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.CertificadosAdopcion;
import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.modelo.Veterinario;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;

/**
 *
 * @author wowle
 */
@WebServlet("/SvCrearCertificado")
public class SvCrearCertificado extends HttpServlet {
    
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    ControladorPersistente control = new ControladorPersistente();
    int idGato = Integer.parseInt(request.getParameter("idGato"));
    
    HttpSession misession = request.getSession();
    Veterinario veteLogueado = (Veterinario) misession.getAttribute("usuarioLogueado");
    
    Gato gato = control.obtenerGatoPorId(idGato);
    
    if (gato != null && veteLogueado != null) {
        // 1. Crear el Certificado de Aptitud
        CertificadosAdopcion nuevoCert = new CertificadosAdopcion(LocalDate.now(), gato, veteLogueado);
        
        // 2. CAMBIO CLAVE: El gato ahora es APTO para que aparezca en el catálogo
        gato.setEstado_adopcion(Gato.EstadoAdopcion.APTO);
        
        // 3. Persistir ambos cambios
        control.editarGato(gato);
        control.crearCertificadoAptitud(nuevoCert);
    }
    
    response.sendRedirect("SvListarCertificados?exito=1");
}
}