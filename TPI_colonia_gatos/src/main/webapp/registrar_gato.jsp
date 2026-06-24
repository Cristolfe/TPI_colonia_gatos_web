<%-- 
    Document   : registrar_gato
    Created on : 7 ene. 2026, 19:19:19
    Author     : wowle
--%>


<%@ page import="java.util.List" %>
<%@ page import="edu.ugd.tpi_colonia_gatos.modelo.ZonasAvistamientos" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Nuevo Gato</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <style>
        body { background-color: #f4f7f6; margin: 0; }
        .content-wrapper { padding-top: 40px; padding-bottom: 40px; }
        .card { 
            border-radius: 20px; 
            border: none; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.1); 
        }
        .form-label { font-weight: 600; color: #495057; }
    </style>
</head>
<body>

    <%-- 1. Incluimos el Header (Asegura que SvRegistrarGato esté en paginasPermitidas) --%>
    <%@include file="header.jsp" %>

    <div class="container content-wrapper">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">
                <div class="card p-4">
                    <h2 class="text-center mb-4" style="color: #0056b3;">Registro de Nuevo Paciente</h2>
                    
                    <form action="SvRegistrarGato" method="POST">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Nombre del Gato</label>
                                <input type="text" name="nombre" class="form-control" placeholder="Ej: Bigotes" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Color predominante</label>
                                <input type="text" name="color" class="form-control" placeholder="Ej: Atigrado, Blanco..." required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Link de Foto (URL)</label>
                                <input type="text" name="foto" class="form-control" placeholder="http://...">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Estado de Salud</label>
                                <select name="estadoActual" class="form-select" required>
                                    <option value="SANO">Sano</option>
                                    <option value="ENFERMO">Enfermo</option>
                                    <option value="EN_TRATAMIENTO">En Tratamiento</option>
                                    <option value="ESTERILIZADO">Esterilizado</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Situación de Adopción</label>
                                <select name="estado_adopcion" class="form-select" required>
                                    <option value="NOAPTO">No Apto</option>
                                    <option value="APTO">Apto para Adopción</option>
                                    <option value="ADOPTADO">Ya Adoptado</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Zona de Avistamiento / Residencia</label>
                            <select name="nombreZona" class="form-select" required>
                                <% 
                                    // Obtenemos la lista que DEBE enviar el Servlet SvRegistrarGato (doGet)
                                    List<ZonasAvistamientos> lista = (List<ZonasAvistamientos>) request.getAttribute("listaZonas");
                                    String zonaPrevia = request.getParameter("zona");
                                    
                                    if(lista != null && !lista.isEmpty()) {
                                        for(ZonasAvistamientos z : lista) {
                                            String selected = (zonaPrevia != null && zonaPrevia.equals(z.getNombreZona())) ? "selected" : "";
                                %>
                                    <option value="<%= z.getNombreZona() %>" <%= selected %>><%= z.getNombreZona() %></option>
                                <% 
                                        }
                                    } else { 
                                %>
                                    <option disabled selected>⚠️ Error: No se cargaron zonas (use SvRegistrarGato)</option>
                                <% } %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Características / Notas Clínicas iniciales</label>
                            <textarea name="caracteristicas" class="form-control" rows="3" placeholder="Descripción física, temperamento o señas particulares..."></textarea>
                        </div>

                        <div class="mt-4 d-flex gap-2">
                             <button type="submit" class="btn-confirmar-capsula flex-grow-1">
                                Confirmar Registro
                            </button>
                             <a href="panel_veterinario.jsp" class="btn-volver-capsula flex-grow-1 text-center" style="text-decoration: none;">
                                 Cancelar
                             </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>