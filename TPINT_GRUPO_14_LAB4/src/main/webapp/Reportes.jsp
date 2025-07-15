<%@ page import="java.util.List" %>
<%@ page import= "entidad.ReporteCuotas" %>
<%@ page import= "entidad.ReporteAprobacion" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
		.contra {
    	width: 100%;
	    max-width: 100%;
	    padding: 8px;
	    box-sizing: border-box;
		}
		<jsp:include page="css\AltaBajaCuentas.css"></jsp:include>
		
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
 %>

	<div style="display: flex; height: 100vh;">
		<aside class="sidebar">
			<div class="logo">Banco Admin</div>
			<nav class="menu">
				<a href="AdminDatos.jsp">Principal</a>
				 <a href="#">Opciones</a>
				 <a href="#">Creditos</a>
				<a href="#">Cerrar sesion</a>
			</nav>
		</aside>

	    <main class="main-content">
			<header>
				<h1>Reportes</h1>
			</header>
			<hr>
			</br>
			<section>
				<h2>Reporte de cuotas por año: </h2>
				<p style="color:grey; font-size:10px"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
				  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
				</svg> Reporte de las cuotas con vencimiento en cada mes del año, muestra la cantidad de cuotas pagadas y pendientes, los montos cobrados y a cobrar por dichas cuotas y el total ganado por cobro de intereses</p>
				<form method="get" action="ServletReportes">
					<div style="display:flex; max-width:250px; align-items: center; padding:10px; gap: 10px;">
						<label for="año">Año: </label>
		                <input type="number" id="año" name="año" style="max-height:30px;" value="2025" required>
		                <button type="submit" class="btn btn-secondary" name="cuotas" value="cuotas">Cargar</button>
	                </div>
				
				</form>
				<table class="table table-striped-columns" style="width:1000px">
					<thead>
					    <tr>
					      <th scope="col">Mes</th>
					      <th scope="col">Cuotas pagadas</th>
					      <th scope="col">Cuotas pendientes</th>
					      <th scope="col">Total cobrado</th>
					      <th scope="col">Total pendiente</th>
					      <th scope="col">Ganancia por intereses</th>
					    </tr>
					</thead>
					<tbody>
					  	<% if(listaCuotas != null)
						for(ReporteCuotas rp : listaCuotas){ %>
							<tr>
						      <th scope="row"><%=rp.getMes() %></th>
						      <td><%=rp.getCuotasPagas() %></td>
						      <td><%=rp.getCuotasPendientes() %></td>
						      <td><%=rp.getTotalCobrado() %></td>
						      <td><%=rp.getTotalPendiente() %></td>
						      <td><%=rp.getGanancia() %></td>
						    </tr>
					<%} %>
					  
					    
					    
					</tbody>
				</table>
			</section>
			
			</br>
			</br>
			
			<section>
				<h2>Reporte de aprobacion de prestamos: </h2>
				<form method="post" action="ServletReportes">
					<div style="display:flex; max-width:250px; align-items: center; padding:10px; gap: 10px;">
						<div>
                    		<label for="fecha1">Desde: </label>
                    		<input type="date" id="fecha1" name="fecha1" class="contra" required>
                		</div>
                		<div>
                    		<label for="fecha2">Hasta: </label>
                    		<input type="date" id="fecha2" name="fecha2" class="contra" required>
                		</div>
                		<div>
                			<button type="submit" class="btn btn-secondary" name="prestamos" value="prestamos">Cargar</button>
                		</div>
	                </div>
				
				</form>
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
			
			</section>
		</main>
	</div>
	
</body>
</html>