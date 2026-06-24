package com.mycompany.tpi_colonia_gatos.Servlets;

import edu.ugd.tpi_colonia_gatos.modelo.Gato;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvListarCertificados", urlPatterns = {"/SvListarCertificados"})
public class SvListarCertificados extends HttpServlet {

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    ControladorPersistente control = new ControladorPersistente();
    
    // 1. Traemos todos los gatos de la base de datos
    List<Gato> todosLosGatos = control.obtenerGatos();
    
    // 2. Filtramos: Solo queremos los que NO son aptos todavía
    // (Y que no hayan sido adoptados ya, por seguridad)
    List<Gato> gatosParaCertificar = todosLosGatos.stream()
        .filter(g -> g.getEstado_adopcion() == Gato.EstadoAdopcion.NOAPTO)
        .collect(Collectors.toList());
    
    // 3. Enviamos la lista filtrada al JSP
    request.setAttribute("gatosAptos", gatosParaCertificar);
    request.getRequestDispatcher("gestion_certificados.jsp").forward(request, response);
}
}