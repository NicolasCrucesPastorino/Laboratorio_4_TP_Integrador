<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="entidad.Cliente"%>

<%
Cliente cliente = (Cliente) request.getAttribute("cliente");
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

button {
	background-color: #92a8d1;
}

.btn {
	display: inline-block;
	padding: 8px;
	text-decoration: none;
	background-color: gray;
	border-radius: 10px;
	color: white;
}

.btn-primary {
	background-color: #92a8d1;
}

.btn-cancel {
	background-color: #e55c51;
}

.btn-Aceptar {
	background-color: #2c992e;
}

div {
	margin: 5px;
	padding: 5px;
}

#idNombre {
	font-family: "Verdana", "sans-serif", "Comic-sans";
	background-color: yellow;
}

label {
	background-color: transparent;
	font-weight: bold;
	color: #333;
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
				<li style="margin-bottom: 10px;"><a href="Admin">Admin Principal</a></li>
				<li style="margin-bottom: 10px;"><a href="">Opciones</a></li>
				<li style="margin-bottom: 10px;"><a href="Admin?opcion=clientes">Ver Clientes</a></li>
				
				<li style="margin-bottom: 10px;"><a href="ServletLogout">Cerrar sesión</a></li>
				
			</ul>
		</menu>
	</aside>

	<main class="container-main">
		<header>
			<h1 style="text-align: center; margin: 30px 0;">Información
				Personal</h1>
		</header>

		<%
		if (!puedeEditar) {
		%>
		<!-- MODO SOLO LECTURA -->
		<section>
			<div style="display: flex;">
				<label>Nombre: </label> <span
					style="margin-left: 10px; margin-right: 40px;"><%=cliente.getNombre()%></span>

				<label>Apellido: </label> <span
					style="margin-left: 10px; margin-right: 20px;"><%=cliente.getApellido()%></span>
			</div>

			<div style="display: flex;">
				<label>Numero Documento: </label> <span
					style="margin-left: 10px; margin-right: 40px;"><%=cliente.getDNI()%></span>

				<label>Genero: </label> <span
					style="margin-left: 10px; margin-right: 20px;"><%=cliente.getGenero()%></span>
			</div>

			<div style="display: flex;">
				<label>Provincia: </label> <span
					style="margin-left: 10px; margin-right: 40px;"><%=cliente.getProvincia().getNombre()%></span>

				<label>Localidad: </label> <span
					style="margin-left: 10px; margin-right: 20px;"><%=cliente.getLocalidad().getNombre()%></span>
			</div>

			<div>
				<label>Direccion: </label> <span
					style="margin-left: 10px; margin-right: 40px;"><%=cliente.getDireccion()%></span>
			</div>

			<div style="display: flex;">
				<label>Correo: </label> <span
					style="margin-left: 10px; margin-right: 40px;"><%=cliente.getCorreo()%></span>

				<label>Telefono: </label> <span
					style="margin-left: 10px; margin-right: 20px;"><%=cliente.getTelefono()%></span>
			</div>
		</section>

		<%
		} else {
		%>
		<!-- MODO EDI<!--  -->
		<form method="post" action="EditarCliente">
			<input type="hidden" name="opcion" value="actualizar"> <input
				type="hidden" name="id" value="<%=cliente.getId()%>">
			<!-- 1 -->
			<div style="display: flex; align-items: center; margin-right: 20px;">
				<label>Nombre: </label> <input type="text" name="nombre"
					value="<%=cliente.getNombre()%>" style="margin-left: 10px;">
				<label>Apellido: </label> <input type="text" name="apellido"
					value="<%=cliente.getApellido()%>" style="margin-left: 10px;">
			</div>
			<!-- 2  -->
			<div style="display: flex; align-items: center; margin-right: 20px;">
				<label>Numero Documento: </label> <input type="text" name="dni"
					value="<%=cliente.getDNI()%>" style="margin-left: 10px;"> <label>Genero:
				</label> <input type="text" name="genero" value="<%=cliente.getGenero()%>"
					style="margin-left: 10px;">
			</div>
			<!-- 3 -->
			<div style="display: flex; align-items: center; margin-right: 20px;">
				<label>Provincia: </label> <input type="text" name="provincia" value="<%=cliente.getProvincia().getId()%>">
				<label>Localidad: </label> <input type="text" name="localidad" value="<%=cliente.getLocalidad().getId()%>">
			</div>

			<!-- 4 -->
			<div style="display: flex; align-items: center; margin-right: 20px;">
				<label>Dirección: </label> <input type="text" name="direccion"
					value="<%=cliente.getDireccion()%>" style="margin-left: 10px;">
			</div>

			<!-- 5 -->
			<div style="display: flex; align-items: center; margin-right: 20px;">
				<label>Correo: </label> <input type="text" name="correo"
					value="<%=cliente.getCorreo()%>" style="margin-left: 10px;">
				<label>Telefono: </label> <input type="text" name="telefono"
					value="<%=cliente.getTelefono()%>" style="margin-left: 10px;">
			</div>

			<!-- CANCEL -->
			<div style="margin-top: 20px; text-align: center;">
				<%
				if (puedeEditar) {
				%>
				<a href="Admin?opcion=detalle&id=<%=cliente.getId()%>&editar=no"
					class="btn btn-cancel" style="margin-right: 10px;">Cancelar</a>
				<!-- ACEPTAR --> 
					<input type="submit" value="Guardar Cambios" class="btn btn-Aceptar">
				<%
				}
				%>
			</div>

		</form>
		<%
		}
		%>

		<!-- boton edit -->
		<div style="margin-top: 20px; text-align: center;">
			<%
			if (!puedeEditar) {
			%>
			<a href="EditarCliente?id=<%=cliente.getId()%>" class="btn btn-primary">Editar</a>
			<%
			}
			%>
		</div>

	</main>
</body>
</html>
