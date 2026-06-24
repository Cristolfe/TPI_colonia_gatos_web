/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import edu.ugd.tpi_colonia_gatos.modelo.Diagnosticos;
import edu.ugd.tpi_colonia_gatos.modelo.HistorialMedico;
import edu.ugd.tpi_colonia_gatos.modelo.Tratamiento;
import edu.ugd.tpi_colonia_gatos.persistencia.ControladorPersistente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author wowle
 */
@WebServlet("/SvAgregarDiagnostico")
public class SvAgregarDiagnostico extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Recogemos los datos del formulario
        int idHistorial = Integer.parseInt(request.getParameter("idHistorial"));
        String descDiag = request.getParameter("diagnostico");
        String descTrat = request.getParameter("tratamiento");

        ControladorPersistente control = new ControladorPersistente();

        // 1. Crear el Tratamiento
        Tratamiento nuevoTratamiento = new Tratamiento();
        nuevoTratamiento.setDescripcion(descTrat);

        // 2. Crear el Diagnóstico
        Diagnosticos nuevoDiag = new Diagnosticos();
        nuevoDiag.setDescripcion(descDiag);
        
        // 3. Vincularlos (Ahora que arreglaste el Setter esto funcionará)
        nuevoDiag.setTratamiento(nuevoTratamiento);

        // 4. Buscar el historial y añadir el diagnóstico a la lista
        HistorialMedico historial = control.findHistorialMedico(idHistorial);
        
        // Usamos el método setDiagnostico que tienes en tu clase HistorialMedico
        // que hace un this.diagnosticos.add(diagnosticos);
        historial.setDiagnostico(nuevoDiag);

        try {
            // 5. Persistir los cambios
            control.editarHistorial(historial);
        } catch (Exception ex) {
            Logger.getLogger(SvAgregarDiagnostico.class.getName()).log(Level.SEVERE, null, ex);
        }

        // 6. Redirigir de nuevo al detalle para ver el nuevo registro
        response.sendRedirect("SvVerDetalleHistorial?id=" + idHistorial);
    }
}