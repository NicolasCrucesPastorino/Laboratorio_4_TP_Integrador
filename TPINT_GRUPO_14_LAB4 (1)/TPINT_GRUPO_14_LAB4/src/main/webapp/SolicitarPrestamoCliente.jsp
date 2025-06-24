<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Solicitar Prestamo</title>
<style type="text/css">
<jsp:include page="css\SolicitarPrestamoCliente.css"></jsp:include>
</style>
</head>
<body>
	<div class="container">
		<aside class="sidebar">
			<div class="logo">Banco</div>
			<nav class="menu">
				<a href="#">Principal</a>
				 <a href="#">Opciones</a>
				 <a href="#">Creditos</a>
				<a href="#">Cerrar sesion</a>
			</nav>
		</aside>

		<main class="main-content">
			<div class="info-button">i</div>
			<h1>Solicitar Prestamo</h1>

			<form class="loan-form">
				<label for="monto">Cantidad de dinero</label> <input type="number"
					id="monto" name="monto" required> <label for="cuotas">Cuotas</label>
				<select id="cuotas" name="cuotas" required>
					<option value="">Seleccione</option>
					<option value="3">3 cuotas</option>
					<option value="6">6 cuotas</option>
					<option value="9">9 cuotas</option>
					<option value="12">12 cuotas</option>
					<option value="18">18 cuotas</option>
					<option value="24">24 cuotas</option>
				</select>

				<div class="checkbox">
					<input type="checkbox" id="terminos" name="terminos" required>
					<label for="terminos">Acepto los terminos</label>
				</div>

				<button type="submit">Solicitar</button>
			</form>

		</main>
	</div>
</body>
</html>