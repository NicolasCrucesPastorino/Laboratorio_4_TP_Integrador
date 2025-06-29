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

<div style="background-color:dodgerblue; width:100%; height:80px; display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; font-family: Arial, sans-serif;">
	<div>
	</div>
	<div style="display: flex; align-items: center; justify-content: center;">
		<div style="padding: 10px"><i class="bi bi-person-circle"></i>Nombre de usuario</div>
		<div style="padding: 10px">Numero de cuenta</div>
		
	</div>
</div>

<section style=" max-width: 100rem; width: 80%; margin: 0 auto;">
	
	<h2 style="padding:20px">Historial de transferencias</h2>
	<div style="display:flex">
		<div style="padding: 10px">
			Filtrar por monto: 
			<select name="tipos">
				<option>Todos</option>
				<option>de 0 a 10000</option>
				<option>de 10000 a 20000</option>
			</select>
		</div>
		<div style="padding: 10px">
			Filtrar por tipo de transferencia: 
			<select name="tipos">
				<option>Todas</option>
				<option>Transferencias enviadas</option>
				<option>Transferencias recibidas</option>
			</select>
		</div>
		<div style="padding: 10px">
			Filtrar por fecha: 
			<select name="tipos">
				<option>Todas</option>
				<option>Ultimos 7 dias</option>
				<option>Ultimos 30 dias</option>
				<option>Ultimos 60 dias</option>
			</select>
		</div>
	</div>
	</br>
	<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">Fecha</th>
	      <th scope="col">Tipo</th>
	      <th scope="col">Monto</th>
	      <th scope="col">Cuenta</th>
	      <th scope="col">Titular</th>
	      <th scope="col">Motivo</th>
	      <th scope="col">Nro de operacion</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">1</th>
	      <td>02/06/2025</td>
	      <td>Transferencia enviada</td>
	      <td>$10000</td>
	      <td>29384757/4</td>
	      <td>Mario Perez</td>
	      <td>Varios</td>
	      <td>934659253885</td>
	      
	    </tr>
	    <tr>
	      <th scope="row">2</th>
	      <td>17/04/2025</td>
	      <td>Transferencia recibida</td>
	      <td>$25000</td>
	      <td>97867564/3</td>
	      <td>Fernando Acevedo</td>
	      <td>Varios</td>
	      <td>194538952785</td>
	    </tr>
	    <tr>
	      <th scope="row">3</th>
	      <td>20/03/2025</td>
	      <td>Tranferencia recibida</td>
	      <td>$15000</td>
	      <td>45982357/5</td>
	      <td>Marcela Muñoz</td>
	      <td>Regalo</td>
	      <td>294502743561</td>
	    </tr>
	    <tr>
	      <th scope="row">3</th>
	      <td>12/02/2025</td>
	      <td>Tranferencia enviada</td>
	      <td>$12000</td>
	      <td>70371866/1</td>
	      <td>Juan Galindez</td>
	      <td>Almuerzo</td>
	      <td>734023719348</td>
	    </tr>
	  </tbody>
	</table>
	
	

</section>

</body>
</html>