<%-- 
    Document   : mapa_zonas
    Created on : 14 ene. 2026, 22:11:25
    Author     : wowle
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mapa de Zonas - Campo Ramón</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="css/estilos_paneles.css">
    <link rel="stylesheet" href="css/style.css"> 
    
    <style>
        /* Reconfiguración del body para que el header NO se descentre */
        body { 
            background-color: #f8f9fa; 
            display: flex; 
            flex-direction: column; /* Elementos uno debajo del otro */
            align-items: center; 
            min-height: 100vh; 
            margin: 0; 
        }

        /* Estilo de la tarjeta principal */
        .task-card { 
            width: 95%; 
            max-width: 1000px; 
            padding: 2.5rem; 
            border-radius: 20px; 
            background: white; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.1); 
            margin: 40px 0; /* Espaciado arriba y abajo */
        }

        #map { 
            height: 500px; 
            width: 100%; 
            border-radius: 15px; 
            border: 2px solid #0056b3; 
        }
        
        /* Etiquetas de texto dentro del mapa */
        .etiqueta-zona { 
            background: none; 
            border: none; 
            box-shadow: none; 
            font-weight: bold; 
            color: #333; 
            text-shadow: 1px 1px 2px white; 
        }

        /* Forzar que el header ocupe el 100% si el include no lo tiene */
        header, .navbar {
            width: 100%;
        }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" /> 

    <div class="task-card text-center">
        <h2 class="mb-4" style="color: #0056b3; font-weight: bold;">Zonas de Avistamiento</h2>
        
        <div id="map" class="mb-4"></div>

        <div style="display: flex; gap: 20px; justify-content: center; align-items: center; width: 100%; max-width: 700px; margin: 0 auto;">

            <a href="panel_admin.jsp" 
               class="btn-volver-capsula d-flex align-items-center justify-content-center" 
               style="flex: 1; height: 50px; text-decoration: none; padding: 0; margin: 0 !important;">
               Volver al Panel
            </a>

            <a href="#" 
               class="btn-confirmar-capsula d-flex align-items-center justify-content-center" 
               data-bs-toggle="modal" data-bs-target="#modalNuevaZona"
               style="flex: 1; height: 50px; text-decoration: none; padding: 0; margin: 0 !important;">
               Registrar Nueva Zona
            </a>

        </div>
    </div>

    <div class="modal fade" id="modalNuevaZona" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 20px; border: none; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
                
                <div class="modal-header" style="background-color: #0056b3; color: white; border: none; padding: 20px;">
                    <h5 class="modal-title" style="font-weight: bold;">Registrar Nueva Zona</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" style="filter: invert(1); border:none;"></button>
                </div>

                <form action="SvCargarZonas" method="POST">
                    <div class="modal-body" style="padding: 30px; text-align: left; background-color: white;">
                        <div class="mb-3">
                            <label class="form-label fw-bold" style="color: #333;">Nombre de la Zona</label>
                            <input type="text" name="nombreZona" class="form-control" 
                                   placeholder="Ej: Zona Norte" required 
                                   style="border-radius: 10px; padding: 12px; border: 1px solid #ced4da;">
                        </div>
                    </div>

                    <div class="modal-footer" style="border: none; padding: 20px; display: flex; justify-content: space-between; background-color: white;">
                        <button type="button" class="btn-volver-capsula" data-bs-dismiss="modal" 
                                style="width: 140px; height: 45px; display: flex; align-items: center; justify-content: center; text-decoration: none; border: 1px solid #6c757d;">
                            Cancelar
                        </button>
                        <button type="submit" class="btn-confirmar-capsula d-flex align-items-center justify-content-center" 
                                style="width: 160px; height: 45px; font-weight: bold; border: 1px solid #0056b3; cursor: pointer; background-color: #0056b3; color: white;">
                            Guardar Zona
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        var vLat = -27.4520; 
        var vLng = -55.0150; 
        var map = L.map('map').setView([vLat, vLng], 14);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

        var jsonZonas = '${zonasJson}';

        if (jsonZonas && jsonZonas !== "") {
            try {
                var datosZonas = JSON.parse(jsonZonas);
                datosZonas.forEach(function(zona) {
                    var nombre = zona.nombre.toUpperCase();
                    var puntosArea;
                    var colorZ = "#3498db"; 
                    var s = 0.008;

                    if (nombre.includes("NORTE")) {
                        puntosArea = [[vLat, vLng], [vLat+s, vLng], [vLat+s, vLng+s], [vLat, vLng+s]];
                        colorZ = "#e74c3c";
                    } else if (nombre.includes("SUR")) {
                        puntosArea = [[vLat-s, vLng], [vLat-s*2, vLng], [vLat-s*2, vLng+s], [vLat-s, vLng+s]];
                        colorZ = "#2ecc71";
                    } else if (nombre.includes("ESTE")) {
                        puntosArea = [[vLat, vLng+s], [vLat-s, vLng+s], [vLat-s, vLng+s*2], [vLat, vLng+s*2]];
                        colorZ = "#f1c40f";
                    } else if (nombre.includes("OESTE")) {
                        puntosArea = [[vLat, vLng], [vLat-s, vLng], [vLat-s, vLng-s], [vLat, vLng-s]];
                        colorZ = "#9b59b6";
                    } else {
                        puntosArea = [[vLat, vLng], [vLat-s, vLng], [vLat-s, vLng+s], [vLat, vLng+s]];
                    }

                    L.polygon(puntosArea, {
                        color: colorZ,
                        fillColor: colorZ,
                        fillOpacity: 0.3,
                        weight: 2
                    }).addTo(map).bindTooltip(zona.nombre, {
                        permanent: true, 
                        direction: 'center',
                        className: 'etiqueta-zona'
                    }).openTooltip();
                });
            } catch (e) {
                console.error("Error al procesar zonasJson", e);
            }
        }
    </script>
</body>
</html>