/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Familia;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author wowle
 */

@WebServlet(name = "SvRegistroFamiliar", urlPatterns = {"/SvRegistroFamiliar"})
public class SvRegistroFamiliar extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ControladorPersistente controlador = new ControladorPersistente();

        try {
            // 1. Capturamos los datos del formulario JSP/HTML
            int dni = Integer.parseInt(request.getParameter("dni"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String direccion = request.getParameter("direccion");
            String pass = request.getParameter("pass");
            
            // 2. Manejo de la fecha (HTML5 date envía yyyy-MM-dd)
            String fechaStr = request.getParameter("fechaNac");
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNac = formato.parse(fechaStr);

            // 3. Creamos el objeto Familia (Igual que en tu código de escritorio)
            Familia nuevoFamiliar = new Familia();
            nuevoFamiliar.setDni(dni);
            nuevoFamiliar.setNombre(nombre);
            nuevoFamiliar.setApellido(apellido);
            nuevoFamiliar.setDireccion(direccion);
            nuevoFamiliar.setPass(pass);
            nuevoFamiliar.setFechNac(fechaNac);

            // 4. Guardamos en la base de datos
            controlador.crearFamilia(nuevoFamiliar);

            // 5. Redirigimos al login con un mensaje de éxito
            response.sendRedirect("loing.jsp?registro=ok");

        } catch (Exception e) {
            // Si hay error, volvemos al registro con un aviso
            response.sendRedirect("registro.jsp?error=datos");
        }
    }
}