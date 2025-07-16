<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="entidad.Usuario"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Solicitar Prestamo</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
	crossorigin="anonymous">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
	crossorigin="anonymous"></script>

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

.prestamo-section {
    background: white;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.prestamo-section h1 {
    color: #2a5298;
    margin-bottom: 20px;
}
</style>
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
                        <a class="nav-link active" href="Prestamos">
                            Solicitud de préstamo
                        </a>
                        <a class="nav-link" href="Prestamos?opcion=lista">
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
            <!-- Sección de solicitud de préstamo -->
            <div class="prestamo-section">
                <h1>Solicitar Préstamo</h1>
                
                <form class="row g-3" method="post" action="Prestamos">
                    <input type="hidden" name="formulario" value="si">
                    
                    <div class="col-md-6">
                        <label for="monto" class="form-label">Cantidad de dinero</label>
                        <input type="number" class="form-control" id="monto" name="monto_pedido" required min="1000" step="0.01">
                        <div class="form-text">Monto mínimo: $1,000</div>
                    </div>
                    
                    <div class="col-md-6">
                        <label for="cuotas" class="form-label">Cantidad de cuotas</label>
                        <select class="form-select" id="cuotas" name="cantidad_cuotas" required>
                            <option value="">Seleccione cantidad de cuotas</option>
                            <option value="3">3 cuotas</option>
                            <option value="6">6 cuotas</option>
                            <option value="9">9 cuotas</option>
                            <option value="12">12 cuotas</option>
                            <option value="18">18 cuotas</option>
                            <option value="24">24 cuotas</option>
                        </select>
                    </div>
                    
                    <div class="col-12">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="terminos" name="terminos" required>
                            <label class="form-check-label" for="terminos">
                                Acepto los términos y condiciones del préstamo
                            </label>
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary">Solicitar Préstamo</button>
                        <a href="Prestamos?opcion=lista" class="btn btn-secondary ms-2">Ver Mis Préstamos</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>