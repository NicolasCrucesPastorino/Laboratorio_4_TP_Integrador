<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

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
			Nombre de usuario
		
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
  		<a class="nav-link" href="#">Tranferencia</a>
  		<a class="nav-link" href="#">Historial de transferencias</a>
  		<a class="nav-link" href="#">Solicitud de prestamo</a>
  		<a class="nav-link" href="#">Informacion de prestamos</a>
  		
	</nav>
	</br>
  	<input type="submit" class="btn btn-link" name="btnCerrar" value="Cerrar sesion">
	
</div>
<div style="background-color:antiquewhite; width:80%; height:500px; float:left;">

	<div class="card" style="padding:20px">
	  <div class="card-body">
	  	<p class="card-text">Tipo de cuenta</p>
	  	<p class="card-text">Cuenta N° 17345978/2</p>
	    <h5 class="card-title">Saldo: $ <%= saldo %></h5>
	    
	    
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
		<h2>Ultimos movimientos</h2>
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">Fecha</th>
		      <th scope="col">Tipo</th>
		      <th scope="col">Monto</th>
		      <th scope="col">Cuenta</th>
		      <th scope="col">Motivo</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row">1</th>
		      <td>02/06/2025</td>
		      <td>Transferencia enviada</td>
		      <td>$10000</td>
		      <td>29384757/4</td>
		      <td>Varios</td>
		    </tr>
		    <tr>
		      <th scope="row">2</th>
		      <td>17/04/2025</td>
		      <td>Transferencia recibida</td>
		      <td>$25000</td>
		      <td>97867564/3</td>
		      <td>Varios</td>
		    </tr>
		    <tr>
		      <th scope="row">3</th>
		      <td>20/03/2025</td>
		      <td>Tranferencia recibida</td>
		      <td>$15000</td>
		      <td>45982357/5</td>
		      <td>Regalo</td>
		    </tr>
		  </tbody>
		</table>
		<div style="text-align:right">
			<input type="submit" class="btn btn-info" name="btnMovimientos" value="Ver todos">
		</div>
	</div>

</div>




</body>
</html>