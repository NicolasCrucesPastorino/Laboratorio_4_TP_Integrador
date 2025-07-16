<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidad.Cliente"%>
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

.info-container {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 20px;
}

.info-container h1 {
    color: #2a5298;
    margin-bottom: 30px;
    text-align: center;
}

.info-section {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 25px;
    margin-bottom: 25px;
    border-left: 4px solid #2a5298;
}

.info-section h3 {
    color: #2a5298;
    margin-bottom: 20px;
    font-weight: 600;
}

.info-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid #e9ecef;
}

.info-row:last-child {
    border-bottom: none;
}

.info-label {
    font-weight: 600;
    color: #495057;
    flex: 0 0 180px;
}

.info-value {
    color: #2a5298;
    font-weight: 500;
    flex: 1;
    text-align: right;
}

.status-badge {
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 12px;
    font-weight: 600;
}

.status-active {
    background-color: #d4edda;
    color: #155724;
}

.status-inactive {
    background-color: #f8d7da;
    color: #721c24;
}
</style>

<meta charset="UTF-8">
<title>Mi Informacion Personal - Home Banking</title>
</head>
<body>

<%
// Obtener cliente y usuario de la sesion o request
Cliente cliente = (Cliente) request.getAttribute("cliente");
Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

// Si no hay cliente en el request, intentar obtenerlo de la sesion
if (cliente == null) {
    cliente = (Cliente) session.getAttribute("clienteLogueado");
}
%>

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
                <!-- Menu de navegacion -->
                <div class="nav-menu">
                    <h3 class="text-center">MENU</h3>
                    <nav class="nav flex-column">
                        <a class="nav-link" href="Cliente">
                            <i class="bi bi-house me-2"></i>Inicio
                        </a>
                        <a class="nav-link active" href="InfoCliente.jsp">
                            <i class="bi bi-person me-2"></i>Informacion personal
                        </a>
                        <a class="nav-link" href="ServletTransferencia">
                            <i class="bi bi-arrow-left-right me-2"></i>Transferencia
                        </a>
                        <a class="nav-link" href="Prestamos">
                            <i class="bi bi-cash-coin me-2"></i>Solicitud de prestamo
                        </a>
                        <a class="nav-link" href="Prestamos?opcion=lista">
                            <i class="bi bi-list-check me-2"></i>Mis Prestamos
                        </a>
                    </nav>
                </div>

                <!-- Boton cerrar sesion -->
                <form method="post" action="ServletLogout">
                    <button type="submit" class="btn btn-outline-light w-100" name="btnCerrar">
                        <i class="bi bi-box-arrow-right me-2"></i>Cerrar sesion
                    </button>
                </form>
            </div>
        </div>

        <!-- Contenido principal -->
        <div class="col-md-10 main-content">
            <div class="info-container">
                <h1>Mi Informacion Personal</h1>
                
                <%if (cliente != null) {%>
                
                <!-- Datos Personales -->
                <div class="info-section">
                    <h3>📋 Datos Personales</h3>
                    <div class="info-row">
                        <span class="info-label">ID Cliente:</span>
                        <span class="info-value">#<%=cliente.getId()%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Nombre Completo:</span>
                        <span class="info-value"><%=cliente.getNombre()%> <%=cliente.getApellido()%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">DNI:</span>
                        <span class="info-value"><%=cliente.getDNI()%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Genero:</span>
                        <span class="info-value"><%=cliente.getGenero() != null ? cliente.getGenero() : "No especificado"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Nacionalidad:</span>
                        <span class="info-value"><%=cliente.getNacionalidad() != null ? cliente.getNacionalidad() : "No especificada"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Fecha de Nacimiento:</span>
                        <span class="info-value"><%=cliente.getFecha_nacimiento() != null ? cliente.getFecha_nacimiento().toString() : "No especificada"%></span>
                    </div>
                </div>
                
                <!-- Informacion de Contacto -->
                <div class="info-section">
                    <h3>📞 Informacion de Contacto</h3>
                    <div class="info-row">
                        <span class="info-label">Correo Electronico:</span>
                        <span class="info-value"><%=cliente.getCorreo() != null ? cliente.getCorreo() : "No especificado"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Telefono:</span>
                        <span class="info-value"><%=cliente.getTelefono() != null ? cliente.getTelefono() : "No especificado"%></span>
                    </div>
                </div>
                
                <!-- Direccion -->
                <div class="info-section">
                    <h3>📍 Direccion</h3>
                    <div class="info-row">
                        <span class="info-label">Direccion:</span>
                        <span class="info-value"><%=cliente.getDireccion() != null ? cliente.getDireccion() : "No especificada"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Localidad:</span>
                        <span class="info-value"><%=cliente.getLocalidad() != null ? cliente.getLocalidad().getNombre() : "No especificada"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Provincia:</span>
                        <span class="info-value"><%=cliente.getProvincia() != null ? cliente.getProvincia().getNombre() : "No especificada"%></span>
                    </div>
                </div>
                
                <!-- Informacion de Cuenta -->
                <div class="info-section">
                    <h3>🏦 Informacion de Cuenta</h3>
                    <div class="info-row">
                        <span class="info-label">Usuario:</span>
                        <span class="info-value"><%=cliente.getUsuario() != null ? cliente.getUsuario().getUsuario() : "No asignado"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Fecha de Alta:</span>
                        <span class="info-value"><%=cliente.getFecha_alta() != null ? cliente.getFecha_alta().toString() : "No especificada"%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Estado:</span>
                        <span class="info-value">
                            <span class="status-badge <%=cliente.isActivo() ? "status-active" : "status-inactive"%>">
                                <%=cliente.isActivo() ? "Activo" : "Inactivo"%>
                            </span>
                        </span>
                    </div>
                </div>
                
                <%} else {%>
                <div class="alert alert-warning text-center">
                    <h4>⚠️ No se pudo cargar la informacion</h4>
                    <p>No se encontraron datos del cliente. Por favor, contacte al administrador.</p>
                    <p><strong>Usuario:</strong> 
                        <%if (usuarioLogueado != null) {%>
                            <%=usuarioLogueado.getUsuario()%>
                        <%} else {%>
                            No identificado
                        <%}%>
                    </p>
                </div>
                <%}%>
                
                <div class="text-center mt-4">
                    <a href="Cliente" class="btn btn-primary">
                        <i class="bi bi-arrow-left me-2"></i>Volver al Inicio
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html> 