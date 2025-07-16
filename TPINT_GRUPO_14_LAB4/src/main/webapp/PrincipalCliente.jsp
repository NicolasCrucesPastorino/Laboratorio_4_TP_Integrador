<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	$(document)
			.ready(
					function() {
						$('#tablaMovimientos')
								.DataTable(
										{
											"language" : {
												"url" : "//cdn.datatables.net/plug-ins/1.10.19/i18n/Spanish.json"
											},
											"pageLength" : 5,
											"lengthMenu" : [ [ 5, 10, 25, 50 ],
													[ 5, 10, 25, 50 ] ]
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

.account-selector {
    background: white;
    border-radius: 8px;
    padding: 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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

.main-content {
    background-color: #f8f9fa;
    min-height: 100vh;
    padding: 20px;
}

.account-card {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    border: none;
    margin-bottom: 20px;
}

.account-card .card-header {
    background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
    color: white;
    border-radius: 15px 15px 0 0 !important;
    padding: 20px;
}

.movements-section {
    background: white;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.movements-section h2 {
    color: #2a5298;
    margin-bottom: 20px;
}
</style>

<meta charset="UTF-8">
<title>Principal Cliente</title>
</head>
<body>

	<%
	// Obtener movimientos de la base de datos
	List<Movimiento> movimientos = new ArrayList<>();
	if (request.getAttribute("movimientos") != null) {
		movimientos = (List<Movimiento>) request.getAttribute("movimientos");
	}

	// Obtener cuenta activa
	Cuenta cuentaActiva = null;
	if (request.getAttribute("cuentaActiva") != null) {
		cuentaActiva = (Cuenta) request.getAttribute("cuentaActiva");
	}

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

	// Obtener mensaje de error si existe
	String mensaje = null;
	if (request.getAttribute("mensaje") != null) {
		mensaje = (String) request.getAttribute("mensaje");
	}
	%>

	<%!float saldo = 0;%>

<div class="container-fluid">
    <div class="row">
        <!-- Header superior -->
        <div class="col-12 header-top">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h4 class="mb-0">🏦 Home Banking</h4>
                    </div>
                    <div class="col-md-6 text-end">
                        <div class="d-flex align-items-center justify-content-end gap-3">
                            <div class="user-info">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                    fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                                    <path fill-rule="evenodd"
                                        d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                                </svg>
                                <span>
                                    <%if (usuarioLogueado != null) {%>
                                        <%=usuarioLogueado.getUsuario()%>
                                    <%} else {%>
                                        Usuario
                                    <%}%>
                                </span>
                            </div>
                            <div class="account-selector">
                                <form action="Cliente" method="get">
                                    <label class="form-label mb-1 text-dark">Cuenta activa:</label>
                                    <select class="form-select form-select-sm" name="cuentaSeleccionada" onchange="this.form.submit()">
                                        <%
                                            List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("cuentas");
                                            Cuenta cuentaSeleccionada = (Cuenta) request.getAttribute("cuentaActiva");
                                            
                                            if (cuentas != null && !cuentas.isEmpty()) {
                                                for (Cuenta cuenta : cuentas) {
                                                    if (cuenta.isActiva()) {
                                                        String selected = (cuentaSeleccionada != null && cuenta.getIdCuenta() == cuentaSeleccionada.getIdCuenta()) ? "selected" : "";
                                        %>
                                                                                                <option value="<%=cuenta.getIdCuenta()%>" <%=selected%>>
                                            <%
                                                String tipoCuentaTexto = (cuenta.getIdTipoCuenta() == 1) ? "Ahorro" : "Corriente";
                                            %>
                                            [<%=tipoCuentaTexto%>] <%=cuenta.getNumeroCuenta()%> - $<%=cuenta.getSaldo()%>
                                        </option>
                                        <%
                                                    }
                                                }
                                            } else {
                                        %>
                                                <option>No hay cuentas disponibles</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </form>
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
                             <i class="bi bi-house me-2"></i>Inicio
                         </a>
                                                 <a class="nav-link" href="InfoCliente">
                            <i class="bi bi-person me-2"></i>Información personal
                        </a>
                         <a class="nav-link" href="ServletTransferencia">
                             <i class="bi bi-arrow-left-right me-2"></i>Transferencia
                         </a>
                         <a class="nav-link" href="Prestamos">
                             <i class="bi bi-cash-coin me-2"></i>Solicitud de préstamo
                         </a>
                         <a class="nav-link" href="Prestamos?opcion=lista">
                             <i class="bi bi-list-check me-2"></i>Mis Préstamos
                         </a>
                     </nav>
                 </div>

                 <!-- Botón cerrar sesión -->
                 <form method="post" action="ServletLogout">
                     <button type="submit" class="btn btn-outline-light w-100" name="btnCerrar">
                         <i class="bi bi-box-arrow-right me-2"></i>Cerrar sesión
                     </button>
                 </form>
             </div>
         </div>

                 <!-- Contenido principal -->
         <div class="col-md-10 main-content">
            <%if (mensaje != null) {%>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <%=mensaje%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <%}%>

            <!-- Tarjeta de cuenta -->
            <div class="card account-card">
                <div class="card-header">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h5 class="mb-1">
                                <%if (cuentaActiva != null && cuentaActiva.getTipoCuenta() != null) {%>
                                    <%=cuentaActiva.getTipoCuenta().getDescripcion()%>
                                <%} else {%>
                                    Tipo de cuenta
                                <%}%>
                            </h5>
                            <p class="mb-0">
                                Cuenta N° 
                                <%if (cuentaActiva != null) {%>
                                    <%=cuentaActiva.getNumeroCuenta()%>
                                <%} else {%>
                                    ---
                                <%}%>
                            </p>
                        </div>
                        <div class="col-md-4 text-end">
                            <h3 class="mb-0">
                                $<%if (cuentaActiva != null && cuentaActiva.getSaldo() != null) {%>
                                    <%=cuentaActiva.getSaldo()%>
                                <%} else {%>
                                    <%=saldo%>
                                <%}%>
                            </h3>
                            <small>Saldo disponible</small>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <a href="#" class="btn btn-outline-primary w-100 mb-2">
                                <i class="bi bi-eye me-2"></i>Datos de cuenta
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="ServletTransferencia" class="btn btn-primary w-100 mb-2">
                                <i class="bi bi-arrow-left-right me-2"></i>Transferir
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sección de movimientos -->
            <div class="movements-section">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2><i class="bi bi-list-ul me-2"></i>Últimos movimientos</h2>
                    <button class="btn btn-outline-primary" name="btnMovimientos">
                        <i class="bi bi-eye me-2"></i>Ver todos
                    </button>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover" id="tablaMovimientos">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Fecha</th>
                                <th scope="col">Tipo</th>
                                <th scope="col">Monto</th>
                                <th scope="col">Cuenta</th>
                                <th scope="col">Concepto</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%if (!movimientos.isEmpty()) {
                                for (Movimiento mov : movimientos) {%>
                            <tr>
                                <th scope="row"><%=mov.getId_movimiento()%></th>
                                <td><%=mov.getFecha() != null ? mov.getFecha().toString().substring(0, 10) : ""%></td>
                                <td>
                                    <span class="badge bg-info">
                                        <%=mov.getTipoMovimiento() != null ? mov.getTipoMovimiento().getDescripcion() : ""%>
                                    </span>
                                </td>
                                <td class="fw-bold">$<%=mov.getImporte() != null ? mov.getImporte().toString() : "0"%></td>
                                <td><%=mov.getCuenta() != null ? mov.getCuenta().getNumeroCuenta() : ""%></td>
                                <td><%=mov.getConcepto() != null ? mov.getConcepto() : ""%></td>
                            </tr>
                            <%}
                            }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>