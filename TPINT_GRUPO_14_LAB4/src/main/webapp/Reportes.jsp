<%@ page import="java.util.List" %>
<%@ page import= "entidad.ReporteCuotas" %>
<%@ page import= "entidad.ReporteAprobacion" %>
<%@ page import= "entidad.ReporteTransferencia" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes del Sistema - Admin Banking</title>
    
    <!-- Chart.js para gráficos -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 260px;
            background: rgba(185, 28, 28, 0.9);
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .menu-title {
            color: white;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            letter-spacing: 1px;
        }

        .menu-item {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .menu-item.active {
            background: rgba(255, 255, 255, 0.2);
        }

        .logout-btn {
            margin-top: auto;
            background: #991b1b;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #7f1d1d;
            transform: translateY(-2px);
        }

        .main-content {
            flex: 1;
            padding: 0;
            background: linear-gradient(135deg, #fca5a5, #f87171);
            display: flex;
            flex-direction: column;
        }

        .header {
            background: #dc2626;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            font-size: 24px;
            font-weight: 300;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .content-area {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }

        .btn-back {
            background: #6b7280;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }

        .btn-back:hover {
            background: #4b5563;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .report-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .section-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f3f4f6;
        }

        .section-title {
            color: #dc2626;
            font-size: 22px;
            font-weight: bold;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-subtitle {
            color: #6b7280;
            font-size: 14px;
            margin: 8px 0 0 0;
        }

        .form-container {
            background: #f9fafb;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #dc2626;
        }

        .form-group {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .form-group label {
            font-weight: 600;
            color: #374151;
            white-space: nowrap;
        }

        .form-control {
            padding: 8px 12px;
            border: 2px solid #e5e7eb;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #dc2626;
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: #dc2626;
            color: white;
        }

        .btn-primary:hover {
            background: #b91c1c;
            transform: translateY(-1px);
        }

        .table-container {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table thead th {
            background: #f8fafc;
            color: #374151;
            font-weight: 600;
            border-bottom: 2px solid #e5e7eb;
            padding: 12px;
            text-align: left;
            font-size: 13px;
        }

        .table tbody td {
            padding: 12px;
            border-bottom: 1px solid #f3f4f6;
            font-size: 14px;
        }

        .table tbody tr:hover {
            background-color: #f9fafb;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f8fafc;
        }

        .month-name {
            font-weight: 600;
            color: #374151;
        }

        .currency {
            font-weight: 500;
            color: #059669;
        }

        .chart-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .chart-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .chart-title {
            color: #374151;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
            text-align: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-left: 4px solid #dc2626;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #dc2626;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #6b7280;
            font-size: 14px;
            font-weight: 500;
        }

        .info-note {
            background: #eff6ff;
            border: 1px solid #3b82f6;
            border-radius: 6px;
            padding: 12px;
            margin-bottom: 15px;
            font-size: 12px;
            color: #1e40af;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #6b7280;
            font-style: italic;
        }

        .pie-chart-container {
            position: relative;
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }

        @media (max-width: 768px) {
            .chart-container {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }
        }
        
        circle{
			fill: none;
			stroke-width: 20;
			transform: rotate(-90deg);
			transform-origin: 50%;
			stroke-dasharray: 100 100;
			stroke: green;
		}
		circle:nth-child(2){
		stroke: grey;
		stroke-dasharray: var(--porcentaje) 100;
		}
		circle:nth-child(3){
		stroke: red;
		stroke-dasharray: var(--porcentaje) 100;
		}
		
		.año{
		width:90%;
		background-color:grey;
		}
		.mes{
		text-align:right;
		padding:10px;
		color:white;
		font-weight:bold;
		}
		.cantidad{
		background-color:red;
		width:var(--porcentaje);
		}
		.total{
		background-color:red;
		width:var(--porcentaje);
		}
		.promedio{
		background-color:red;
		width:var(--porcentaje);
		}
		.maximo{
		background-color:red;
		width:var(--porcentaje);
		}
    </style>
</head>
<body>

<% 
    List<ReporteCuotas> listaCuotas = null;
    if(request.getAttribute("listaCuotas")!=null)
    {
        listaCuotas = (List<ReporteCuotas>) request.getAttribute("listaCuotas");
    }
    
    ReporteAprobacion ap = null;
    if(request.getAttribute("Aprobacion")!=null)
    {
        ap = (ReporteAprobacion)request.getAttribute("Aprobacion");
    }
    
    ReporteTransferencia rt = null;
    if(request.getAttribute("Transferencias")!=null)
    {
        rt = (ReporteTransferencia)request.getAttribute("Transferencias");
    }
 %>

    <div class="sidebar">
        <div class="menu-title">MENÚ ADMIN</div>
        <a href="Admin" class="menu-item">Panel Principal</a>
        <a href="Admin?opcion=clientes" class="menu-item">Gestión de clientes</a>
        <a href="Admin?opcion=prestamos" class="menu-item">Gestión de préstamos</a>
        <a href="ServletAltaCuentas" class="menu-item">Alta de cuentas</a>
        <a href="ServletAlta" class="menu-item">Alta de usuarios</a>
        <a href="ServletReportes?año=2025" class="menu-item active">Reportes</a>
        <form action="ServletLogout" method="post" style="margin-top: auto;">
            <button type="submit" class="logout-btn">Cerrar sesión</button>
        </form>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>🏦 Admin Banking - Reportes del Sistema</h1>
            <div class="admin-info">
                <span>👤 ${sessionScope.usuarioLogueado.usuario}</span>
                <span>Admin</span>
            </div>
        </div>

        <div class="content-area">
            <!-- Botón volver -->
            <a href="Admin" class="btn-back">
                ← Volver al Panel Principal
            </a>

            <!-- Reporte de cuotas por año -->
            <div class="report-section">
                <div class="section-header">
                    <h2 class="section-title">📅 Reporte de Cuotas por Año</h2>
                    <p class="section-subtitle">
                        Análisis mensual de cuotas con vencimiento en el año seleccionado
                    </p>
                </div>

                <div class="info-note">
                    <span>ℹ️</span>
                    <span>
                        Este reporte muestra las cuotas con vencimiento en cada mes del año, 
                        incluyendo cantidad de cuotas pagadas y pendientes, montos cobrados y por cobrar, 
                        y el total ganado por cobro de intereses.
                    </span>
                </div>

                <div class="form-container">
                    <form method="get" action="ServletReportes">
                        <div class="form-group">
                            <label for="año">Año a consultar:</label>
                            <input type="number" id="año" name="año" class="form-control" 
                                   value="2025" min="2020" max="2030" required>
                            <button type="submit" class="btn btn-primary" name="cuotas" value="cuotas">
                                📊 Generar Reporte
                            </button>
                        </div>
                    </form>
                </div>

                <% if(listaCuotas != null && !listaCuotas.isEmpty()) { %>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Mes</th>
                                    <th>Cuotas Pagadas</th>
                                    <th>Cuotas Pendientes</th>
                                    <th>Total Cobrado</th>
                                    <th>Total Pendiente</th>
                                    <th>Ganancia por Intereses</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
                                                 "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                                for(ReporteCuotas rp : listaCuotas) { 
                                %>
                                <tr>
                                    <td class="month-name"><%=meses[rp.getMes()-1]%></td>
                                    <td><%=rp.getCuotasPagas()%></td>
                                    <td><%=rp.getCuotasPendientes()%></td>
                                    <td class="currency">$<%=String.format("%.2f", rp.getTotalCobrado())%></td>
                                    <td class="currency">$<%=String.format("%.2f", rp.getTotalPendiente())%></td>
                                    <td class="currency">$<%=String.format("%.2f", rp.getGanancia())%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <div class="no-data">
                        <h4>📄 No hay datos disponibles</h4>
                        <p>Seleccione un año y genere el reporte para ver la información.</p>
                    </div>
                <% } %>
                  
                </br>
                </br> 
            </div>
            <div class="report-section"> 
                    
                <div>
                   
                   	<div class="section-header">
	                    <h2 class="section-title">📅 Reporte de aprobacion de prestamos</h2>
	                    <p class="section-subtitle">
	                        Reporte de solisitudes de prestamos aprobadas, pendientes y rechazadas
	                    </p>
	                </div>
					
					<div class="form-container">
						<form method="post" action="ServletReportes">
							<div >
								<div class="form-group">
		                    		<label for="fecha1">Desde: </label>
		                    		<input type="date" id="fecha1" name="fecha1" class="form-control" required>
		                		
		                		
		                    		<label for="fecha2">Hasta: </label>
		                    		<input type="date" id="fecha2" name="fecha2" class="form-control" required>
		                		
		                		
		                			<button type="submit" class="btn btn-primary" name="prestamos" value="prestamos">Cargar</button>
		                		</div>
			                </div>
						
						</form>
					</div>
					<div class="table-container">
						<table class="table table-striped-columns" style="width:1000px">
							<thead>
							    <tr>
							      <th scope="col">Solicitudes</th>
							      <th scope="col">Aprobadas</th>
							      <th scope="col">% Aprobadas</th>
							      <th scope="col">Pendientes</th>
							      <th scope="col">% Pendientes</th>
							      <th scope="col">Rechazadas</th>
							      <th scope="col">% Rechazadas</th>
							    </tr>
							</thead>
							<tbody>
							  	<% if(ap != null){ %>
									<tr>
								      <td><%=ap.getPrestamos() %></td>
								      <td><%=ap.getPrestamosAprobados() %></td>
								      <td><%=ap.getPorcentajeAprobados() %></td>
								      <td><%=ap.getPrestamosPendientes() %></td>
								      <td><%=ap.getPorcentajePendientes() %></td>
								      <td><%=ap.getPrestamosRechazados() %></td>
								      <td><%=ap.getPorcentajeRechazados() %></td>
								    </tr>
								<%} %>
							  
							    
							    
							</tbody>
						</table>
					</div>
					<div class="chart-card">
		
						<div style="display:flex; align-items:center; justify-content:center;">
						<% if(ap != null){ %>
							<% float pen = ap.getPorcentajePendientes() + ap.getPorcentajeRechazados(); %>
							<svg>
								<circle r="65" cx="50%" cy="50%" pathlength="100" />
								<circle r="65" cx="50%" cy="50%" pathlength="100" style="--porcentaje:<%=pen %>" />
								<circle r="65" cx="50%" cy="50%" pathlength="100" style="--porcentaje:<%=ap.getPorcentajeRechazados() %>"/>
							</svg>
							<p style="color:grey; font-size:10px"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
							</svg> En verde las solicitudes aprobadas, en gris la pendientes y el rojo las rechazadas</p>
						<%} %>
						</div>
					</div>
				</div>
			</div>
			
			<div class="report-section"> 
				<div class="section-header">
                    <h2 class="section-title">📅 Reporte de transferencias</h2>
                    <p class="section-subtitle">
                        Comparacion de estadisticas de transferencias entre mes y año
                    </p>
                </div>
                <div class="form-container">
                    <form method="post" action="ServletReportes">
                        <div class="form-group">
                            <label for="ano">Año:</label>
                            <input type="number" id="ano" name="ano" class="form-control" 
                                   value="2025" min="2020" max="2030" required>
                            <label for="mes">Mes:</label>
                            <input type="number" id="mes" name="mes" class="form-control" 
                                   value="7" min="1" max="12" required>
                            <button type="submit" class="btn btn-primary" name="cuotas" value="cuotas">
                                📊 Generar Reporte
                            </button>
                        </div>
                    </form>
                </div>
                
                <div class="info-note">
                    <span>ℹ️</span>
                    <span>
                        Las barras rojas muestran las estadisticas del mes y que porcentaje representan con respecto a las del año.
                    </span>
                </div>
                
                <% 
                if(rt != null){
                	float cant = 0;
                	float total = 0;
                	float prom = 0;
                	float max = 0;
                	if(rt.getTransferenciasAño()!=0){
                		cant = rt.getTransferenciasMes() * 100 / rt.getTransferenciasAño();
                	}
                	if(rt.getTotalAño()!=0){
                		total = rt.getTotalMes() * 100 / rt.getTotalAño();
                	}
                	if(rt.getPromedioAño()!=0){
                		prom = rt.getPromedioMes() * 100 / rt.getPromedioAño();
                	}
                	if(rt.getMaximoAño()!=0){
                		max = rt.getMaximoMes() * 100 / rt.getMaximoAño();
                	}
                %>
	                <div class="chart-card">
	                	<p>Cantidad de transferencias</p>
	                	<div style="display:flex;" class="form-group">
		                	<div class="año">
		                		<div class="mes cantidad" style="--porcentaje:<%=cant%>%"><%=rt.getTransferenciasMes() %></div>
		                	</div>
	                		<p><%=rt.getTransferenciasAño() %></p>
	                	</div>
	                	<p>Total transferido</p>
	                	<div style="display:flex;" class="form-group">
		                	<div class="año">
		                		<div class="mes total" style="--porcentaje:<%=total%>%"><%=rt.getTotalMes() %></div>
		                	</div>
	                		<p><%=rt.getTotalAño() %></p>
	                	</div>
	                	<p>Importe promedio de transferencias</p>
	                	<div style="display:flex;" class="form-group">
		                	<div class="año">
		                		<div class="mes promedio" style="--porcentaje:<%=prom%>%"><%=rt.getPromedioMes() %></div>
		                	</div>
	                		<p><%=rt.getPromedioAño() %></p>
	                	</div>
	                	<p>Importe maximo transferido</p>
	                	<div style="display:flex;" class="form-group">
		                	<div class="año">
		                		<div class="mes maximo" style="--porcentaje:<%=max%>%"><%=rt.getMaximoMes() %></div>
		                	</div>
	                		<p><%=rt.getMaximoAño() %></p>
	                	</div>
	                </div>
				<%} %>
			</div>
			
			<div class="report-section">

                    <!-- Gráfico de cuotas -->
                    <div class="chart-container">
                        <div class="chart-card">
                            <h3 class="chart-title">Cuotas Pagadas vs Pendientes por Mes</h3>
                            <canvas id="cuotasChart"></canvas>
                        </div>
                        <div class="chart-card">
                            <h3 class="chart-title">Ingresos por Mes</h3>
                            <canvas id="ingresosChart"></canvas>
                        </div>
                    </div>
                
            </div>

            </div>
        </div>
</body>
</html>