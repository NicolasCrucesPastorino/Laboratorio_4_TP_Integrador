<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Lista de clientes</h1>
	
	<table>
		<thead>
            <tr>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>DNI</th>
                <th>Correo</th>
                <th>Telefono</th>
                <th>Alta</th>
                <th>Acciones</th>
            </tr>
        </thead>
		<tbody>
			<c:forEach var="cliente" items="${clientes}">
			<tr>
                <td>${cliente.nombre}</td>
				<td>${cliente.apellido}</td>
				<td>${cliente.DNI}</td>
				<td>${cliente.correo}</td>
				<td>${cliente.telefono}</td>
				<td>${cliente.telefono}</td>
				<td>
					<div>
						<c:url var="detalleUrl" value="/Admin">
    <c:param name="opcion" value="detalle" />
    <c:param name="id" value="${cliente.id}" />

</c:url>
<a href="${detalleUrl}">Detalle</a>

					</div>
				</td>
				</tr>
			</c:forEach>
			</tr>
		</tbody>>
	</table>
</body>
</html>