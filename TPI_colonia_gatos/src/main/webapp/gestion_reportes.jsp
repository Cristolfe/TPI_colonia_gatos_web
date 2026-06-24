<%-- 
    Document   : gestion_reportes
    Created on : 21 ene. 2026, 13:11:59
    Author     : wowle
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Reportes - Campo Ramón</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos_paneles.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>

    <style>
        body { background-color: #f8f9fa; min-height: 100vh; margin: 0; display: flex; flex-direction: column; align-items: center; }
        .report-container { width: 95%; max-width: 1200px; background: white; padding: 2rem; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); margin-top: 30px; }
        .table-container { height: 400px; overflow-y: auto; border: 1px solid #dee2e6; border-radius: 10px; }
        .btn-reporte { width: 100%; margin-bottom: 15px; border: 1px solid #0056b3; transition: 0.3s; }
        .info-label { font-weight: bold; color: #0056b3; font-size: 1.1rem; }
        /* Estilo para el botón de PDF */
        .btn-pdf { background-color: #e74c3c; color: white; border: none; border-radius: 50px; padding: 5px 20px; font-weight: bold; margin-bottom: 10px; display: none; }
        .btn-pdf:hover { background-color: #c0392b; }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="report-container">
        <h2 class="text-center mb-4" style="color: #0056b3; font-weight: bold;">Gestión de Reportes</h2>
        
        <div class="row">
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <div id="labelReporte" class="info-label">Seleccione un reporte para visualizar</div>
                    <button id="btnDescargarPDF" onclick="descargarPDF()" class="btn-pdf">
                        PDF ⬇
                    </button>
                </div>

                <div class="table-container">
                    <table class="table table-striped table-hover" id="tablaReportes">
                        <thead class="table-dark" style="background-color: #0056b3; border: none;">
                            <tr id="cabeceraTabla">
                                <th>Esperando reporte...</th>
                            </tr>
                        </thead>
                        <tbody id="cuerpoTabla">
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-md-3">
                <button onclick="generarReporte('zona')" class="btn-confirmar-capsula btn-reporte">Gatos por Zona</button>
                <button onclick="generarReporte('esterilizados')" class="btn-confirmar-capsula btn-reporte">Gatos Esterilizados</button>
                <button onclick="generarReporte('adoptados')" class="btn-confirmar-capsula btn-reporte">Gatos Adoptados</button>
                
                <div class="mt-5">
                    <a href="panel_admin.jsp" class="btn-volver-capsula d-flex align-items-center justify-content-center" style="text-decoration: none; height: 45px;">
                        Volver
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Función para cargar los datos (la que ya tenías)
        function generarReporte(tipo) {
            fetch('SvReportes?tipo=' + tipo)
                .then(response => response.json())
                .then(data => {
                    actualizarTabla(tipo, data);
                    // Mostrar el botón de PDF si hay datos
                    document.getElementById('btnDescargarPDF').style.display = data.length > 0 ? 'block' : 'none';
                })
                .catch(error => alert("Error al generar reporte: " + error));
        }

        function actualizarTabla(tipo, data) {
            const cabecera = document.getElementById('cabeceraTabla');
            const cuerpo = document.getElementById('cuerpoTabla');
            const label = document.getElementById('labelReporte');
            cuerpo.innerHTML = "";
            
            if (tipo === 'adoptados') {
                cabecera.innerHTML = "<tr><th>ID</th><th>Gato</th><th>DNI Familia</th><th>Nombre Familia</th></tr>";
                label.innerText = "Reporte: Gatos Adoptados (Total: " + data.length + ")";
                data.forEach(p => {
                    cuerpo.innerHTML += `<tr><td>\${p.id}</td><td>\${p.gato}</td><td>\${p.dni}</td><td>\${p.familia}</td></tr>`;
                });
            } else if (tipo === 'zona') {
                cabecera.innerHTML = "<tr><th>Zona</th><th>Total de Gatos</th></tr>";
                label.innerText = "Reporte: Población por Zona";
                data.forEach(z => {
                    cuerpo.innerHTML += `<tr><td>\${z.zona}</td><td>\${z.total}</td></tr>`;
                });
            } else if (tipo === 'esterilizados') {
                cabecera.innerHTML = "<tr><th>ID</th><th>Nombre</th><th>Color</th><th>Zona</th></tr>";
                label.innerText = "Reporte: Gatos Esterilizados (Total: " + data.length + ")";
                data.forEach(g => {
                    cuerpo.innerHTML += `<tr><td>\${g.id}</td><td>\${g.nombre}</td><td>\${g.color}</td><td>\${g.zona}</td></tr>`;
                });
            }
        }

        // --- FUNCIÓN PARA DESCARGAR PDF ---
        function descargarPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            const titulo = document.getElementById('labelReporte').innerText;
            
            // Título del documento
            doc.setFontSize(18);
            doc.setTextColor(0, 86, 179); // Azul Campo Ramón
            doc.text("Gestión de Gatos", 14, 20);
            
            doc.setFontSize(12);
            doc.setTextColor(100);
            doc.text(titulo, 14, 30);
            
            // Generar tabla
            doc.autoTable({
                html: '#tablaReportes',
                startY: 35,
                theme: 'grid',
                headStyles: { fillColor: [0, 86, 179] }, // Header azul
                styles: { fontSize: 10 }
            });
            
            doc.save('Reporte_' + titulo.replace(/ /g, "_") + '.pdf');
        }
    </script>
</body>
</html>