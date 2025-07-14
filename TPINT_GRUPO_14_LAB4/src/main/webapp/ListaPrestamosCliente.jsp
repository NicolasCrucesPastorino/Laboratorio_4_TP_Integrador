<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="entidad.Movimiento"%>
<%@ page import="entidad.Cuenta"%>
<%@ page import="entidad.Usuario"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
	crossorigin="anonymous"></script>

<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">

<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

<!-- DataTables JS -->
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>

<meta charset="UTF-8">
<title>Mis Prestamos - Cliente</title>
</head>
<body>
	<div>
		<!-- barra de navegacion -->
		<aside>
		</aside>
		
		<!--  contenido principal de la pagina -->
		<main>
			<header>
				<h1>Mis Prestamos</h1>
				<a href="Prestamos" class="btn btn-info">Pedir Prestamo</a>
			</header>
			<section class="table-responsive">
        		<table id="tablaClientes" class="table table-striped table-hover">
		            <thead class="table-dark">
		                <tr>
		                    <th>ID</th>
		                    <th>monto pedido</th>
		                    <th>monto total</th>
		                    <th>cuotas</th>
		                    <th>monto por cuota</th>
		                    <th>cuotas pagas</th>
		                    <th>estado</th>
		                    <th>Fecha de pedido</th>
		                    <th>Fecha de autorizacion</th>
		                    <th>Adelantar pago</th>
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="prestamo" items="${prestamos}">
		                <tr>
		                    <td>${prestamo.id}</td>
		                    <td>${prestamo.montoPedido}</td>
		                    <td>${prestamo.montoTotal}</td>
		                    <td>${prestamo.cantidadCuotas}</td>
		                    <td>${prestamo.montoTotal / prestamo.cantidadCuotas}</td>
		                    <td>${prestamo.estado}</td>
		                    <td>${prestamo.estado}</td>
		                    <td>
		                        <fmt:formatDate value="${prestamo.fechaPedido}" pattern="dd/MM/yyyy"/>
		                    </td>
		                    <td>
		                        <fmt:formatDate value="${prestamo.fechaAutorizacion}" pattern="dd/MM/yyyy"/>
		                    </td>
		                    <td>
		                    <a href="CuotaPrestamo?id=${prestamo.id}" class="btn btn-success">Pagar</a>
		                </tr>
		                </c:forEach>
		            </tbody>
		        </table>
			</section>
		</main>
	</div>

</body>
</html>