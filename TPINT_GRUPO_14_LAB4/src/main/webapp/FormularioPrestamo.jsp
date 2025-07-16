<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

.form-container {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 20px;
}

.form-container h2 {
    color: #2a5298;
    margin-bottom: 30px;
    text-align: center;
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
<title>Solicitar Prestamo</title>
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
                        <a class="nav-link" href="#">
                            <i class="bi bi-person me-2"></i>Informacion personal
                        </a>
                        <a class="nav-link" href="ServletTransferencia">
                            <i class="bi bi-arrow-left-right me-2"></i>Transferencia
                        </a>
                        <a class="nav-link" href="#">
                            <i class="bi bi-clock-history me-2"></i>Historial de transferencias
                        </a>
                        <a class="nav-link" href="Prestamos">
                            <i class="bi bi-cash-coin me-2"></i>Solicitud de prestamo
                        </a>
                        <a class="nav-link" href="Prestamos?opcion=lista">
                            <i class="bi bi-list-check me-2"></i>Mis Prestamos
                        </a>
                        <a class="nav-link" href="#">
                            <i class="bi bi-info-circle me-2"></i>Informacion de prestamos
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
            <div class="form-container">
                <h2>Solicitar Nuevo Prestamo</h2>
                
                <form action="Prestamos" method="POST" id="prestamoForm">
                    <input type="hidden" name="formulario" value="si">
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="cliente_id" class="form-label">Cliente</label>
                            <select name="cliente_id" id="cliente_id" class="form-select" required>
                                <option value="${cliente.id}">${cliente.nombre}</option>
                            </select>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="cuenta_id" class="form-label">Cuenta de Deposito</label>
                            <select name="cuenta_id" id="cuenta_id" class="form-select" required>
                                <option value="">Seleccione una cuenta</option>
                                <c:forEach var="cuenta" items="${cuentas}">
                                    <option value="${cuenta.idCuenta}">
                                        ${cuenta.numeroCuenta} - ${cuenta.tipoCuenta.descripcion}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="monto_pedido" class="form-label">Monto a Solicitar</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" name="monto_pedido" id="monto_pedido" 
                                       class="form-control" placeholder="0.00" 
                                       min="1000" max="1000000" step="0.01" required>
                            </div>
                            <div class="form-text">Monto minimo: $1,000 - Monto maximo: $1,000,000</div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="cantidad_cuotas" class="form-label">Cantidad de Cuotas</label>
                            <select name="cantidad_cuotas" id="cantidad_cuotas" class="form-select" required>
                                <option value="">Seleccione las cuotas</option>
                                <option value="6">6 cuotas</option>
                                <option value="12">12 cuotas</option>
                                <option value="18">18 cuotas</option>
                                <option value="24">24 cuotas</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-12 mb-3">
                            <div class="alert alert-info">
                                <h6 class="alert-heading">Informacion Importante:</h6>
                                <ul class="mb-0">
                                    <li>El prestamo sera evaluado por nuestro equipo de creditos</li>
                                    <li>El tiempo de aprobacion es de 24 a 48 horas habiles</li>
                                    <li>La tasa de interes se calculara segun el monto y plazo</li>
                                    <li>Recibira una notificacion cuando su solicitud sea procesada</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-12 text-center">
                            <button type="submit" class="btn btn-primary btn-lg me-3">
                                Solicitar Prestamo
                            </button>
                            <a href="Prestamos?opcion=lista" class="btn btn-outline-secondary btn-lg">
                                Cancelar
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Validacion simple del formulario
    document.getElementById('prestamoForm').addEventListener('submit', function(e) {
        const monto = document.getElementById('monto_pedido').value;
        const cuotas = document.getElementById('cantidad_cuotas').value;
        const cuenta = document.getElementById('cuenta_id').value;
        
        if (!cuenta) {
            e.preventDefault();
            alert('Por favor seleccione una cuenta de deposito');
            return;
        }
        
        if (!monto || monto < 1000 || monto > 1000000) {
            e.preventDefault();
            alert('El monto debe estar entre $1,000 y $1,000,000');
            return;
        }
        
        if (!cuotas) {
            e.preventDefault();
            alert('Por favor seleccione la cantidad de cuotas');
            return;
        }
    });
</script>

</body>
</html>