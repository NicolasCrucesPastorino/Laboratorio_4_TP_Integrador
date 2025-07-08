<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<header>
	
	<h1>Confirme su prestamo</h1>
	<p>Lea detalladamente los datos calculados por el sistema para su solicitud de prestamo</p>
	</header>
	
	<main>
	<section>
		<h2>Datos del Prestamo</h2>
		<p>Cliente <span>${prestamo.cliente.nombre }</span></p>
		<p>Cuenta <span>${prestamo.cuenta.numeroCuenta }</span></p>
		<p>Monto solicitado <span>${prestamo.montoPedido }</span></p>
		<p>cantidad de cuotas <span>${prestamo.cantidadCuotas }</span></p>
		<hr>
		<p>Monto final <span>${prestamo.montoTotal }</span></p>
		<p>Monto por cuotas <span>${prestamo.montoPorCuota }</span></p>
		<p>Fecha pedido <span>${prestamo.fechaPedido }</span></p>
		<p>Observaciones <span>Sin Observaciones</span></p>
		</section>
		
		<section>
			<h2>Confirmacion</h2>
			<form action="Prestamos" method="POST">
				<input type="hidden" name="formulario" value="no"> 
				<button type="submit">Confirmar</button>
			</form>
		</section>
	</main>
</body>
</html>