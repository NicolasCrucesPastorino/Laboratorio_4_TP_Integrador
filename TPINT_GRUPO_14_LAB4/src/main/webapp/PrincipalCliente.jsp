<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Movimiento" %>
<%@ page import="entidad.Cuenta" %>
<%@ page import="entidad.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>

<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

<!-- DataTables JS -->
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#tablaMovimientos').DataTable({
			"language": {
				"url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Spanish.json"
			},
			"pageLength": 5,
			"lengthMenu": [[5, 10, 25, 50], [5, 10, 25, 50]]
		});
	});
</script>

<meta charset="UTF-8">
<title>Principal Cliente</title>
</head>
<body>

<%
	// Obtener movimientos de la base de datos
	List<Movimiento> movimientos = new ArrayList<>();
	if (request.getAttribute("movimientos") != null) {
		movimientos = (List<Movimiento>) request.getAttribute("movimientos");
	}
	
	// Obtener cuenta activa
	Cuenta cuentaActiva = null;
	if (request.getAttribute("cuentaActiva") != null) {
		cuentaActiva = (Cuenta) request.getAttribute("cuentaActiva");
	}
	
	// Obtener usuario logueado
	Usuario usuarioLogueado = null;
	if (request.getAttribute("usuarioLogueado") != null) {
		usuarioLogueado = (Usuario) request.getAttribute("usuarioLogueado");
	} else {
		// Si no está en el request, obtenerlo de la sesión
		if (session.getAttribute("usuarioLogueado") != null) {
			usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
		}
	}
	
	// Obtener mensaje de error si existe
	String mensaje = null;
	if (request.getAttribute("mensaje") != null) {
		mensaje = (String) request.getAttribute("mensaje");
	}
%>

<%!float saldo = 0; %>


<div style="background-color:blue; width:20%; height:80px; float:left;"></div>
<div style="background-color:dodgerblue; width:80%; height:80px; display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; font-family: Arial, sans-serif;">
	<div>
	</div>
	<div style="display: flex; align-items: center; justify-content: center;">
		<div style="padding: 20px">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
			  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
			  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
			</svg>
			<% if (usuarioLogueado != null) { %>
				<%= usuarioLogueado.getUsuario() %>
			<% } else { %>
				Nombre de usuario
			<% } %>
		
		</div>
		<div style="padding: 20px">
			Cuenta: 
			<select name="tipos">
				<option>Numero de cuenta 1</option>
				<option>Numero de cuenta 2</option>
				<option>Numero de cuenta 3</option>
			</select>
		</div>
	</div>
</div>
<div style="background-color:skyblue; width:20%; height:500px; float:left; padding:20px">
	
	<nav class="nav flex-column">
		<h3 style="text-align:center; color:grey;">MENU</h3>
  		<a class="nav-link" href="#">Informacion personal</a>
  		<a class="nav-link" href="ServletTransferencia">Tranferencia</a>
  		<a class="nav-link" href="#">Historial de transferencias</a>
  		<a class="nav-link" href="Prestamos">Solicitud de prestamo</a>
  		<a class="nav-link" href="#">Informacion de prestamos</a>
  		
	</nav>
	</br>
  	<input type="submit" class="btn btn-link" name="btnCerrar" value="Cerrar sesion">
	
</div>
<div style="background-color:antiquewhite; width:80%; height:500px; float:left;">

	<% if (mensaje != null) { %>
		<div class="alert alert-warning" role="alert">
			<%= mensaje %>
		</div>
	<% } %>

	<div class="card" style="padding:20px">
	  <div class="card-body">
	  	<p class="card-text">
	  		<% if (cuentaActiva != null && cuentaActiva.getTipoCuenta() != null) { %>
	  			Tipo de cuenta: <%= cuentaActiva.getTipoCuenta().getDescripcion() %>
	  		<% } else { %>
	  			Tipo de cuenta
	  		<% } %>
	  	</p>
	  	<p class="card-text">
	  		<% if (cuentaActiva != null) { %>
	  			Cuenta N° <%= cuentaActiva.getNumeroCuenta() %>
	  		<% } else { %>
	  			Cuenta N° ---
	  		<% } %>
	  	</p>
	    <h5 class="card-title">
	    	Saldo: $ 
	    	<% if (cuentaActiva != null && cuentaActiva.getSaldo() != null) { %>
	    		<%= cuentaActiva.getSaldo() %>
	    	<% } else { %>
	    		<%= saldo %>
	    	<% } %>
	    </h5>
	    
	    
	  </div>
	  <div class="card-footer">
	  	<ul class="nav nav-tabs card-header-tabs">
	      <li class="nav-item">
	        <a class="nav-link" href="#">Datos de cuenta</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Transferir</a>
	      </li>
	      
	    </ul>
	  </div>
	</div>
	
	
	<div style="padding:20px; background-color:white;">
		<h2>Últimos movimientos</h2>
		<table class="table" id="tablaMovimientos">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">Fecha</th>
		      <th scope="col">Tipo</th>
		      <th scope="col">Monto</th>
		      <th scope="col">Cuenta</th>
		      <th scope="col">Concepto</th>
		    </tr>
		  </thead>
		  <tbody>
		    <%
		    	if (!movimientos.isEmpty()) {
		    		for (Movimiento mov : movimientos) {
		    %>
		    <tr>
		      <th scope="row"><%= mov.getId_movimiento() %></th>
		      <td><%= mov.getFecha() != null ? mov.getFecha().toString().substring(0, 10) : "" %></td>
		      <td><%= mov.getTipoMovimiento() != null ? mov.getTipoMovimiento().getDescripcion() : "" %></td>
		      <td>$<%= mov.getImporte() != null ? mov.getImporte().toString() : "0" %></td>
		      <td><%= mov.getCuenta() != null ? mov.getCuenta().getNumeroCuenta() : "" %></td>
		      <td><%= mov.getConcepto() != null ? mov.getConcepto() : "" %></td>
		    </tr>
		    <%
		    		}
		    	}
		    %>
		  </tbody>
		</table>
		<div style="text-align:right">
			<input type="submit" class="btn btn-info" name="btnMovimientos" value="Ver todos">
		</div>
	</div>

</div>




</body>
</html>