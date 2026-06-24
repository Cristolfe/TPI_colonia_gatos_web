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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.google.gson.Gson;

/**
 *
 * @author wowle
 */

@WebServlet("/SvReportes")
public class SvReportes extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        ControladorPersistente control = new ControladorPersistente();
        Gson gson = new Gson();
        Object respuestaFinal = new ArrayList<>();

        try {
            if ("adoptados".equals(tipo)) {
                List<PostuladoParaAdopcion> lista = control.obtenerAdoptados();
                List<Map<String, Object>> data = new ArrayList<>();
                for (PostuladoParaAdopcion p : lista) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("id", p.getIdPostulacion());
                    m.put("gato", p.getGato().getNombre());
                    m.put("dni", p.getFamilia().getDni());
                    m.put("familia", p.getFamilia().getNombre());
                    data.add(m);
                }
                respuestaFinal = data;

            } else if ("zona".equals(tipo)) {
                List<Gato> gatos = control.obtenerGatos();
                Map<String, Long> conteo = gatos.stream().collect(Collectors.groupingBy(
                    g -> (g.getZonas() != null) ? g.getZonas().getNombreZona() : "Sin zona",
                    Collectors.counting()
                ));
                List<Map<String, Object>> data = new ArrayList<>();
                conteo.forEach((nombre, total) -> {
                    Map<String, Object> m = new HashMap<>();
                    m.put("zona", nombre);
                    m.put("total", total);
                    data.add(m);
                });
                respuestaFinal = data;

            } else if ("esterilizados".equals(tipo)) {
                List<Gato> gatos = control.obtenerGatos();
                List<Map<String, Object>> data = new ArrayList<>();
                for (Gato g : gatos) {
                    if (g.getEstadoActual() != null && g.getEstadoActual().toString().equals("ESTERILIZADO")) {
                        Map<String, Object> m = new HashMap<>();
                        m.put("id", g.getIdGato());
                        m.put("nombre", g.getNombre());
                        m.put("color", g.getColor());
                        m.put("zona", (g.getZonas() != null) ? g.getZonas().getNombreZona() : "Sin zona");
                        data.add(m);
                    }
                }
                respuestaFinal = data;
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(respuestaFinal));

        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("[]");
        }
    }
}