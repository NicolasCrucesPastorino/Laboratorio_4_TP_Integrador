<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

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
	integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
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

.main-content {
    background-color: #f8f9fa;
    min-height: 100vh;
    padding: 20px;
}

.confirmation-container {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 20px;
}

.confirmation-container h1 {
    color: #2a5298;
    margin-bottom: 20px;
    text-align: center;
}

.confirmation-container h2 {
    color: #2a5298;
    margin-bottom: 20px;
}

.loan-details {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #e9ecef;
}

.detail-row:last-child {
    border-bottom: none;
}

.detail-label {
    font-weight: 600;
    color: #333;
}

.detail-value {
    color: #2a5298;
    font-weight: 500;
}

.btn-primary {
    background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
    border: none;
    padding: 0.75rem 2rem;
    border-radius: 5px;
    font-weight: 500;
}

.btn-primary:hover {
    background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
    transform: translateY(-1px);
}
</style>

<meta charset="UTF-8">
<title>Confirmacion de Prestamo</title>
</head>
<body>

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
                                    ${sessionScope.usuario.usuario}
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
                        <a class="nav-link" href="InfoPersonalCliente.jsp">
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
            <div class="confirmation-container">
                <h1>Confirme su Prestamo</h1>
                <p class="text-center text-muted mb-4">
                    Lea detalladamente los datos calculados por el sistema para su solicitud de prestamo
                </p>
                
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <!-- Datos del Prestamo -->
                        <h2>Datos del Prestamo</h2>
                        <div class="loan-details">
                            <div class="detail-row">
                                <span class="detail-label">Cliente:</span>
                                <span class="detail-value">${prestamo.cliente.nombre}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Cuenta:</span>
                                <span class="detail-value">${prestamo.cuenta.numeroCuenta}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Monto Solicitado:</span>
                                <span class="detail-value">$${prestamo.montoPedido}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Cantidad de Cuotas:</span>
                                <span class="detail-value">${prestamo.cantidadCuotas} cuotas</span>
                            </div>
                        </div>
                        
                        <!-- Calculo Final -->
                        <div class="loan-details">
                            <div class="detail-row">
                                <span class="detail-label"><strong>Monto Final:</strong></span>
                                <span class="detail-value"><strong>$${prestamo.montoTotal}</strong></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><strong>Monto por Cuota:</strong></span>
                                <span class="detail-value"><strong>$${prestamo.montoPorCuota}</strong></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Fecha de Solicitud:</span>
                                <span class="detail-value">${prestamo.fechaPedido}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Observaciones:</span>
                                <span class="detail-value">Sin Observaciones</span>
                            </div>
                        </div>
                        
                        <!-- Confirmacion -->
                        <div class="text-center mt-4">
                            <h2>Confirmacion</h2>
                            <div class="alert alert-warning">
                                <strong>Importante:</strong> Una vez confirmado, su solicitud sera enviada para evaluacion. 
                                El proceso de aprobacion puede tomar de 24 a 48 horas habiles.
                            </div>
                            
                            <form action="Prestamos" method="POST" class="d-inline">
                                <input type="hidden" name="formulario" value="no"> 
                                <button type="submit" class="btn btn-primary btn-lg me-3">
                                    Confirmar Prestamo
                                </button>
                            </form>
                            <a href="Prestamos" class="btn btn-outline-secondary btn-lg">
                                Cancelar
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>