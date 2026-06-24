/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.tpi_colonia_gatos.Servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import edu.ugd.tpi_colonia_gatos.modelo.*;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "SvUsuarios", urlPatterns = {"/SvUsuarios"})
public class SvUsuarios extends HttpServlet {
    
    ControladorPersistente control = new ControladorPersistente();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> listaUsuarios = control.obtenerUsuarios();
        HttpSession misession = request.getSession();
        misession.setAttribute("listaUsuarios", listaUsuarios);
        response.sendRedirect("gestionar_usuarios.jsp");
    }

        @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {

         ControladorPersistente control = new ControladorPersistente();
         String accion = request.getParameter("accion");

         // 1. CAPTURAR LOS DATOS DEL FORMULARIO
         int dniNuevo = Integer.parseInt(request.getParameter("dni"));
         String nombre = request.getParameter("nombre");
         String apellido = request.getParameter("apellido");
         String pass = request.getParameter("pass");
         String tipo = request.getParameter("tipoUsuario");

         // ESTA ES LA LÍNEA QUE SEGURO FALTABA:
         String direccion = request.getParameter("direccion"); 

         String fechaStr = request.getParameter("fechNac");
         java.util.Date fechaNac = null;
         try {
             java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
             fechaNac = sdf.parse(fechaStr);
         } catch (Exception e) { e.printStackTrace(); }

         // 2. LÓGICA DE ELIMINACIÓN/EDICIÓN
         if ("eliminar".equals(accion)) {
             control.eliminarUsuario(dniNuevo);
         } else {
             if ("confirmar_edicion".equals(accion)) {
                 int dniOriginal = Integer.parseInt(request.getParameter("dniOriginal"));
                 control.eliminarUsuario(dniOriginal);
             }

             // 3. CREAR EL OBJETO SEGÚN EL TIPO
             Usuario usu = switch (tipo) {
                 case "Administrador" -> new Administrador();
                 case "Veterinario" -> new Veterinario();
                 case "Familia" -> new Familia();
                 default -> new Voluntario();
             };

             // 4. ASIGNAR LOS DATOS (IMPORTANTE SETEAR LA DIRECCIÓN AQUÍ)
             usu.setDni(dniNuevo);
             usu.setNombre(nombre);
             usu.setApellido(apellido);
             usu.setPass(pass);
             usu.setFechNac(fechaNac);

             // ¡ESTO ES LO QUE HACE QUE SE GUARDE!
             usu.setDireccion(direccion); 

             control.crearUsuario(usu);
         }
         response.sendRedirect("SvUsuarios");
     }
}