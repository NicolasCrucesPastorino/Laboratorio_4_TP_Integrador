<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
li {
	margin-bottom: 10px;
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

.container-main {
	padding: 8px;
	background-color: f5f5f5;
}

.btn {
	display: inline-block;
	padding: 8px;
	text-decoration: none;
	background-color: gray;
	border: 1px solid black;
	border-radiud: 10px;
	color: black;
}

.btn-primary {
	background-color: #92a8d1;
}
</style>

</head>

<body class="container">
	<aside class="container-menu">
		<figure>
			<img alt="" src="/imagen.jpg">
		</figure>
		<header>
			<h2>barra lateral</h2>
		</header>
		<menu>
			<ul>
				<li><a href="">Principal</a></li>
				<li><a href="">Opciones</a></li>
				<li><a href="">Creditos</a></li>
			</ul>
			<a href="ServletLogout" class="btn btn-link">Cerrar sesión</a>
		</menu>
	</aside>
	<main class="container-main">
		<header>
			<h1>Datos del Admin</h1>
		</header>
		<section>
			<h2>Opciones</h2>

			<menu style="white-space: nowrap; display: inline;">
				<ul>
					<li
						style="list-style-type: none; display: inline-block; margin-right: 10px;">
						<a href="#" class="btn btn-primary">Alta de Usuarios</a>
					</li>
					<li
						style="list-style-type: none; display: inline-block; margin-right: 10px;">
						<a href="#" class="btn btn-primary">Alta de Cuentas</a>
					</li>
					<li
						style="list-style-type: none; display: inline-block; margin-right: 10px;">
						<a href="Admin?opcion=clientes" class="btn btn-primary">Clientes</a>
					</li>
				</ul>
			</menu>
			<div style="margin-top: 20px; text-align: left;">
				<a href="Admin?opcion=prestamos" class="btn btn-primary"
					style="display: block; width: 320px; text-align: center;">Solicitudes
					de Prestamo</a>
			</div>
		</section>
	</main>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
		crossorigin="anonymous"></script>
</body>
</html>