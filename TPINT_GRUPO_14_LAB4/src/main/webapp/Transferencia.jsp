<%@ page import="java.util.List" %>
<%@ page import= "entidad.Cuenta" %>
<%@ page import= "javax.servlet.http.HttpSession" %>
<%@ page import= "entidad.Usuario" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Transferencia - Home Banking</title>
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

.nav-menu .nav-link.active {
    background: rgba(255,255,255,0.3);
    font-weight: bold;
}

.main-content {
    background-color: #f8f9fa;
    min-height: 100vh;
    padding: 20px;
}

.form-container {
    background: white;
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    max-width: 600px;
    margin: 0 auto;
}

.form-header {
    background: linear-gradient(135deg, #87CEEB 0%, #4682B4 100%);
    color: white;
    padding: 20px;
    text-align: center;
    border-radius: 15px 15px 0 0;
    margin: -30px -30px 30px -30px;
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
}

.form-control {
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    padding: 12px;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

.form-control:focus {
    border-color: #4682B4;
    box-shadow: 0 0 0 0.2rem rgba(70,130,180,.25);
}

.btn-primary {
    background: linear-gradient(135deg, #4682B4 0%, #87CEEB 100%);
    border: none;
    padding: 12px 30px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.btn-primary:hover {
    background: linear-gradient(135deg, #2a5298 0%, #4682B4 100%);
    transform: translateY(-2px);
}

.btn-outline-primary {
    border: 2px solid #4682B4;
    color: #4682B4;
    padding: 12px 30px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.btn-outline-primary:hover {
    background-color: #4682B4;
    border-color: #4682B4;
    transform: translateY(-2px);
}

.alert {
    border-radius: 10px;
    margin-bottom: 20px;
}

.alert-success {
    background-color: #d4edda;
    border-color: #c3e6cb;
    color: #155724;
}

.alert-danger {
    background-color: #f8d7da;
    border-color: #f5c6cb;
    color: #721c24;
}
</style>
</head>
<body>

<% 
	List<Cuenta> listaCuentas = null;
	if(request.getAttribute("listaCuentas")!=null)
	{
		listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
	}

	Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
	
	String error = (String) request.getAttribute("error");
	String mensaje = (String) request.getAttribute("mensaje");
	Boolean exito = (Boolean) request.getAttribute("exito");
	Boolean cbuValidado = (Boolean) request.getAttribute("cbuValidado");
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
                                <span><%= usu.getUsuario() %></span>
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
                        <a class="nav-link" href="InfoPersonalCliente.jsp">
                            <i class="bi bi-person me-2"></i>Información personal
                        </a>
                        <a class="nav-link active" href="ServletTransferencia">
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
            <div class="form-container">
                <div class="form-header">
                    <h2><i class="bi bi-arrow-left-right me-2"></i>Nueva Transferencia</h2>
                    <p class="mb-0">Transfiere dinero de forma segura a cualquier cuenta</p>
                </div>
                
                <!-- Mensajes de error o éxito -->
                <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if (mensaje != null && exito != null && exito) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i><%= mensaje %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <!-- Formulario para validar CBU -->
                <% if (cbuValidado == null || !cbuValidado) { %>
                <form method="post" action="ServletTransferencia">
                    <input type="hidden" name="action" value="validarCBU">
                    
                    <div class="form-group">
                        <label for="cbu" class="form-label">
                            <i class="bi bi-bank me-2"></i>CBU de cuenta destino
                        </label>
                        <input type="text" name="cbu" id="cbu" class="form-control" placeholder="Ingrese el CBU de la cuenta destino" required>
                        <small class="form-text text-muted">Ingrese el CBU de la cuenta a la que desea transferir</small>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="bi bi-search me-2"></i>Validar CBU
                        </button>
                    </div>
                </form>
                <% } else { %>
                
                <!-- Formulario principal de transferencia -->
                <form method="post" action="ServletTransferencia">
                    <input type="hidden" name="action" value="confirmar">
                    
                    <div class="form-group">
                        <label for="cuentaOrigen" class="form-label">
                            <i class="bi bi-credit-card me-2"></i>Cuenta Origen
                        </label>
                        <select id="cuentaOrigen" name="cuentaOrigen" class="form-control" required>
                            <option value="">Seleccione una cuenta</option>
                            <% if(listaCuentas != null) {
                                for(Cuenta cuenta : listaCuentas) { %>
                                    <option value="<%=cuenta.getNumeroCuenta()%>">
                                        <%=cuenta.getNumeroCuenta()%> - Saldo: $<%=cuenta.getSaldo()%>
                                    </option>
                                <% }
                            } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="cbu" class="form-label">
                            <i class="bi bi-bank me-2"></i>CBU de cuenta destino
                        </label>
                        <input type="text" name="cbu" id="cbu" class="form-control" value="<%=request.getParameter("cbu") != null ? request.getParameter("cbu") : ""%>" readonly>
                        <small class="form-text text-success">
                            <i class="bi bi-check-circle me-1"></i>CBU validado correctamente
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="importe" class="form-label">
                            <i class="bi bi-currency-dollar me-2"></i>Importe
                        </label>
                        <input type="number" name="importe" id="importe" class="form-control" placeholder="0.00" step="0.01" min="0.01" max="500000" required>
                        <small class="form-text text-muted">Importe máximo: $500,000</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="motivo" class="form-label">
                            <i class="bi bi-chat-text me-2"></i>Motivo
                        </label>
                        <input type="text" id="motivo" name="motivo" class="form-control" placeholder="Describe el motivo de la transferencia" maxlength="100" required>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary me-2">
                            <i class="bi bi-arrow-right me-2"></i>Continuar
                        </button>
                        <a href="ServletTransferencia" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left me-2"></i>Cambiar CBU
                        </a>
                    </div>
                </form>
                <% } %>
            </div>
        </div>
    </div>
</div>

</body>
</html>