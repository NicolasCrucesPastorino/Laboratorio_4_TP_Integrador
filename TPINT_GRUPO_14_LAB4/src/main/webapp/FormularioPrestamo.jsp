<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


	<div>
		<form action="Prestamos" method="POST">
			<input type="hidden" name="formulario" value="si">
			<div>
				<label>Cliente</label>
				<select name= "cliente_id">
					<option value="${cliente.id }">${cliente.nombre }</option>
				</select>
			</div>
						<div>
				<label>Cuenta</label>
				<select name= "cuenta_id">
					<c:forEach var="cuenta" items="${cuentas}">
    					<option value="${cuenta.idCuenta}">${cuenta.numeroCuenta}</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<label>monto a solicitar</label>
				<input type="number" name="monto_pedido">
			</div>
			<div>
				<label>cuotas</label>
				<select name="cantidad_cuotas">
					<option value="6">6 cuotas</option>
					<option value="12">12 cuotas</option>
					<option value="18">18 cuotas</option>
					<option value="24">24 cuotas</option>
				</select>
			</div>
			
			<button type="submit">Solicitar</button>	
		</form>
	</div>
	
</body>
</html>