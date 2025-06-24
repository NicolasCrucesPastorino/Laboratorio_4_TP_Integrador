<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<div style= "display:flex;">
			<label>Nombre: </label> 
				<span style="margin-left:10px; margin-right: 40px;"> Juan </span>
				
			<label>Apellido: </label> 
				<span style="margin-left:10px; margin-right: 20px;"> Perez </span>
		</div>
		
		<div style= "display:flex;">
			<label>Numero Documento: </label> 
				<span style="margin-left:10px; margin-right: 40px;"> 30777153 </span>
				
			<label>Genero: </label> 
				<span style="margin-left:10px; margin-right: 20px;"> Masculino </span>
		</div>
		
		<div>
			<label id= "Direccion">Direccion: </label> 
				<span style="margin-left:10px; margin-right: 40px;"> Calle Siempre Viva Sector 7G </span>
		</div>
		
		<div>
			<label >Codigo Postal: </label> 
				<span style="margin-left:10px; margin-right: 40px;"> 1611 </span>
		</div>
		<div> 
			<label >Cantidad de Cuentas: </label> 
				<span style="margin-left:10px; margin-right: 40px;"> 2 </span>
		</div> 
		
		<!-- bOTONES -->
		<div 
		style="margin-top:20px;  text-align: center; ">
			<button><a href="#" class="btn btn-primary" style = "display: block; width: 70px; text-align: center; ">Editar datos</a></button>
			<button style = "background-color: #9c9c9c"><a href="#" class="btn btn-secondary" style = "display: block; width: 70px; text-align: center; background-color: #9c9c9c">Volver al Menú</a></button>
		</div>
		
		
			
		
		<!-- Aquí irá el formulario en el siguiente paso -->
	</main>
</body>
</html>