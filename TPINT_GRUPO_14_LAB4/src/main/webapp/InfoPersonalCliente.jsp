<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<% 
String editar = (String) request.getAttribute("editar");
	boolean puedeEditar = editar != null && editar.equals("si");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Información Personal</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
	}
	
	.container {
		margin: 0;
		padding: 0;
		height: 100vh;
		display: grid;
		grid-template-columns: 2fr 6fr;
	}
	
	.container-menu {
		background-color: #92a8d1;
		display: flex;
		flex-direction: column;
	}
	
	.container-menu a {
		display: block;
		padding: 12px;
		color: white;
		text-decoration: none;
		border-radius: 4px;
		transition: background 0.3s;
	}
	
	.container-menu a:hover {
		background-color: #5557d9;
	}
	
	.container-main {
		padding: 20px;
		max-width: 600px;
		margin: 0 auto;
	}
	
	button{
	background-color: #92a8d1;
	}
	
	.btn {
		display: inline-block;
		padding: 8px;
		
		text-decoration: none;
		background-color: gray;
		
		border-radius: 10px;
		color: black;
	}
	
	
	.btn-primary {
		background-color: #92a8d1;
	}
	
	div {
		margin: 5px;
		padding: 5px;
	}
	
	#idNombre{
	font-family: "Verdana", "sans-serif", "Comic-sans";
	background-color: yellow;
	}
	
	label{
		background-color: #e0ef93;
	}
	
	input[type="text"] {
		padding: 5px;
		margin: 5px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	
	input[type="submit"] {
		background-color: #92a8d1;
		color: white;
		padding: 10px 20px;
		border: none;
		border-radius: 5px;
		cursor: pointer;
	}
	
</style>
</head>

<body class="container">
	<aside class="container-menu">
		<figure style="text-align: center; margin: 20px 0;">
			<img alt="logo" src="/imagen.jpg" style="width: 80px; height: 80px;">
		</figure>
		<header style="text-align: center; margin-bottom: 20px;">
			<h2 style="color: #2c3e50; margin: 0;">Panel de Opc</h2>
		</header>
		<menu>
			<ul style="list-style: none; padding: 0; margin: 0;">
				<li style="margin-bottom: 10px;"><a href="">Principal</a></li>
				<li style="margin-bottom: 10px;"><a href="">Opciones</a></li>
				<li style="margin-bottom: 10px;"><a href="">Créditos</a></li>
				<li style="margin-bottom: 10px;"><a href="">Cerrar sesión</a></li>
			</ul>
		</menu>
	</aside>

	<main class="container-main">
		<header>
			<h1 style="text-align: center; margin: 30px 0;">Información Personal</h1>
			
		</header>
		<section>
		
		<span style="margin-left:10px; margin-right: 40px;">${cliente.nombre}</span>
		<span style="margin-left:10px; margin-right: 20px;">${cliente.apellido}</span>
		<span style="margin-left:10px; margin-right: 40px;">${cliente.DNI}</span>
		<span style="margin-left:10px; margin-right: 20px;">${cliente.genero}</span>
		<span style="margin-left:10px; margin-right: 40px;">${cliente.direccion}</span>
		<span style="margin-left:10px; margin-right: 40px;">${cantidadCuentas}</span>
		
		</section>
		
		<!-- bOTONES -->
		<div style="margin-top:20px;  text-align: center; ">
			 <c:if test = "${editar eq 'si'}">
         		<c:url var="cancelarEditar" value="/Admin">
    					<c:param name="opcion" value="detalle" />
    					<c:param name="id" value="${cliente.id}" />
    					<c:param name="editar" value="no" />
						</c:url>
						<a href="${cancelarEditar}">Cancelar</a>
      		</c:if>
			
			<c:url var="detalleUrl" value="/Admin">
    					<c:param name="opcion" value="detalle" />
    					<c:param name="id" value="${cliente.id}" />
    					<c:param name="editar" value="si" />
						</c:url>
						<a href="${detalleUrl}">Editar</a>
		</div>
		
		<c:if test = "${editar eq 'si'}">
		<form method="post" action="Admin">
		    <input type="hidden" name="opcion" value="actualizar">
		    <input type="hidden" name="id" value="${cliente.id}">
		    
		    <div style="display:flex;">
		        <label>Nombre: </label> 
		        <input type="text" name="nombre" value="${cliente.nombre}" style="margin-left:10px;">
		        
		        <label>Apellido: </label> 
		        <input type="text" name="apellido" value="${cliente.apellido}" style="margin-left:10px;">
		    </div>
		    
		    <div style="display:flex;">
		        <label>Numero Documento: </label> 
		        <input type="text" name="dni" value="${cliente.DNI}" style="margin-left:10px;">
		        
		        <label>Genero: </label> 
		        <select name="genero" style="margin-left:10px;">
		            <option value="Masculino" ${cliente.genero eq 'Masculino' ? 'selected' : ''}>Masculino</option>
		            <option value="Femenino" ${cliente.genero eq 'Femenino' ? 'selected' : ''}>Femenino</option>
		        </select>
		    </div>
		    
		    <div>
		        <label>Direccion: </label> 
		        <input type="text" name="direccion" value="${cliente.direccion}" style="margin-left:10px; width: 300px;">
		    </div>
		    
		    <div style="display:flex;">
		        <label>Localidad: </label> 
		        <input type="text" name="localidad" value="${cliente.localidad}" style="margin-left:10px;">
		        
		        <label>Provincia: </label> 
		        <input type="text" name="provincia" value="${cliente.provincia}" style="margin-left:10px;">
		    </div>
		    
		    <div style="display:flex;">
		        <label>Correo: </label> 
		        <input type="email" name="correo" value="${cliente.correo}" style="margin-left:10px;">
		        
		        <label>Telefono: </label> 
		        <input type="text" name="telefono" value="${cliente.telefono}" style="margin-left:10px;">
		    </div>
		    
		    <div style="margin-top:20px; text-align: center;">
		        <input type="submit" value="Guardar Cambios" class="btn btn-primary">
		    </div>
		</form>
		</c:if>
		
		<c:if test = "${editar ne 'si'}">
		<section>
			
			<div style= "display:flex;">
		<label>Nombre: </label> 
		<span style="margin-left:10px; margin-right: 40px;">${cliente.nombre}</span>
		
		<label>Apellido: </label> 
		<span style="margin-left:10px; margin-right: 20px;">${cliente.apellido}</span>
		</div>
		
		<div style= "display:flex;">
		<label>Numero Documento: </label> 
		<span style="margin-left:10px; margin-right: 40px;">${cliente.DNI}</span>
		
		<label>Genero: </label> 
		<span style="margin-left:10px; margin-right: 20px;">${cliente.genero}</span>
		</div>
		
		<div>
		<label id= "Direccion">Direccion: </label> 
		<span style="margin-left:10px; margin-right: 40px;">${cliente.direccion}</span>
		</div>
		
		<div>
		<label>Codigo Postal: </label> 
		<span style="margin-left:10px; margin-right: 40px;">${cliente.localidad}</span>
		</div>
		
		<div> 
		<label>Cantidad de Cuentas: </label> 
		<span style="margin-left:10px; margin-right: 40px;">${cantidadCuentas}</span>
		</div>
		
		<!-- Lista de Cuentas -->
		<div style="margin-top: 20px;">
		<label style="font-weight: bold;">Cuentas del Cliente:</label>
		<c:if test="${not empty listaCuentas}">
		<ul style="list-style-type: none; padding: 0; margin-top: 10px;">
		<c:forEach var="cuenta" items="${listaCuentas}">
		<li style="background-color: #f5f5f5; margin: 5px 0; padding: 10px; border-radius: 5px;">
		<strong>Cuenta:</strong> ${cuenta.numero_cuenta} - 
		<strong>Tipo:</strong> ${cuenta.tipo_cuenta} - 
		<strong>Saldo:</strong> $${cuenta.saldo}
		</li>
		</c:forEach>
		</ul>
		</c:if>
		<c:if test="${empty listaCuentas}">
		<p style="margin-top: 10px; color: #666;">No hay cuentas registradas.</p>
		</c:if>
		</div>
		</section>
		</c:if>
	</main>
</body>
</html>