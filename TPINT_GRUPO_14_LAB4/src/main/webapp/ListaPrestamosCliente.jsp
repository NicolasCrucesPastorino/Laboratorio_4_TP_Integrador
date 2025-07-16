<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

<script type="text/javascript">
	$(document).ready(function() {
		$('#tablaClientes').DataTable({
			"language": {
				"url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Spanish.json"
			},
			"pageLength": 5,
			"lengthMenu": [[5, 10, 25, 50], [5, 10, 25, 50]]
		});
	});
</script>

<style>
.sidebar {
    background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
    min-height: 100vh;
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
}

.header-top {
    background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
    color: white;
    padding: 15px 0;
}

.user-info {
    color: white;
    display: flex;
    align-items: center;
    gap: 10px;
}

.nav-menu {
    background: rgba(255,255,255,0.1);
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
}

.nav-menu h3 {
    color: white;
    font-weight: bold;
    margin-bottom: 20px;
}

.nav-menu .nav-link {
    color: white !important;
    padding: 10px 15px;
    margin: 5px 0;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.nav-menu .nav-link:hover {
    background: rgba(255,255,255,0.2);
    transform: translateX(5px);
}

.nav-menu .nav-link.active {
    background: rgba(255,255,255,0.3);
    font-weight: bold;
}

.main-content {
    background-color: #f8f9fa;
    min-height: 100vh;
    padding: 20px;
}

.prestamos-section {
    background: white;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.prestamos-section h1 {
    color: #2a5298;
    margin-bottom: 20px;
}
</style>

<meta charset="UTF-8">
<title>Mis Prestamos - Cliente</title>
</head>
<body>

<%
// Obtener usuario logueado
Usuario usuarioLogueado = null;
if (request.getAttribute("usuarioLogueado") != null) {
	usuarioLogueado = (Usuario) request.getAttribute("usuarioLogueado");
} else {
	// Si no está en el request, obtenerlo de la sesión
	if (session.getAttribute("usuarioLogueado") != null) {
		usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
	}
}
%>

<div class="container-fluid">
    <div class="row">
        <!-- Header superior -->
        <div class="col-12 header-top">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h4 class="mb-0">Home Banking</h4>
                    </div>
                    <div class="col-md-6 text-end">
                        <div class="d-flex align-items-center justify-content-end gap-3">
                            <div class="user-info">
                                <span>
                                    <%if (usuarioLogueado != null) {%>
                                        <%=usuarioLogueado.getUsuario()%>
                                    <%} else {%>
                                        Usuario
                                    <%}%>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <div class="p-3">
                <!-- Menú de navegación -->
                <div class="nav-menu">
                    <h3 class="text-center">MENÚ</h3>
                    <nav class="nav flex-column">
                        <a class="nav-link" href="Cliente">
                            Inicio
                        </a>
                        <a class="nav-link" href="#">
                            Información personal
                        </a>
                        <a class="nav-link" href="ServletTransferencia">
                            Transferencia
                        </a>
                        <a class="nav-link" href="#">
                            Historial de transferencias
                        </a>
                        <a class="nav-link" href="Prestamos">
                            Solicitud de préstamo
                        </a>
                        <a class="nav-link active" href="Prestamos?opcion=lista">
                            Mis Préstamos
                        </a>
                        <a class="nav-link" href="#">
                            Información de préstamos
                        </a>
                    </nav>
                </div>

                <!-- Botón cerrar sesión -->
                <form method="post" action="ServletLogout">
                    <button type="submit" class="btn btn-outline-light w-100" name="btnCerrar">
                        Cerrar sesión
                    </button>
                </form>
            </div>
        </div>

        <!-- Contenido principal -->
        <div class="col-md-10 main-content">
            <!-- Sección de préstamos -->
            <div class="prestamos-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Mis Préstamos</h1>
                    <a href="Prestamos" class="btn btn-primary">
                        Solicitar Nuevo Préstamo
                    </a>
                </div>
                
                <div class="table-responsive">
                    <table id="tablaClientes" class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Monto pedido</th>
                                <th>Monto total</th>
                                <th>Cuotas</th>
                                <th>Monto por cuota</th>
                                <th>Cuotas pagas</th>
                                <th>Estado</th>
                                <th>Fecha de pedido</th>
                                <th>Fecha de autorizacion</th>
                                <th>Adelantar pago</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prestamo" items="${prestamos}">
                            <tr>
                                <td>${prestamo.id}</td>
                                <td>$${prestamo.montoPedido}</td>
                                <td>$${prestamo.montoTotal}</td>
                                <td>${prestamo.cantidadCuotas}</td>
                                <td>$${prestamo.montoTotal / prestamo.cantidadCuotas}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${prestamo.estado == 'Aprobado'}">
                                            <span class="badge bg-success">0</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${prestamo.estado == 'Aprobado'}">
                                            <span class="badge bg-success">${prestamo.estado}</span>
                                        </c:when>
                                        <c:when test="${prestamo.estado == 'Pendiente'}">
                                            <span class="badge bg-warning">${prestamo.estado}</span>
                                        </c:when>
                                        <c:when test="${prestamo.estado == 'Rechazado'}">
                                            <span class="badge bg-danger">${prestamo.estado}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${prestamo.estado}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${prestamo.fechaPedido != null}">
                                        <fmt:formatDate value="${prestamo.fechaPedido}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${prestamo.fechaAutorizacion != null}">
                                        <fmt:formatDate value="${prestamo.fechaAutorizacion}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${prestamo.estado == 'Aprobado'}">
                                            <a href="CuotaPrestamo?id=${prestamo.id}" class="btn btn-success btn-sm">
                                                Pagar Cuotas
                                            </a>
                                        </c:when>
                                        <c:when test="${prestamo.estado == 'Pendiente'}">
                                            <span class="text-muted">Pendiente de aprobación</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">No disponible</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>