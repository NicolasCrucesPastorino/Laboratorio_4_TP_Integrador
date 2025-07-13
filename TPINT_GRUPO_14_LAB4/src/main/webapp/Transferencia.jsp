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
    .form-container {
        background: white;
        border-radius: 10px;
        padding: 30px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        max-width: 600px;
        margin: 20px auto;
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
        border-radius: 5px;
        padding: 10px;
        font-size: 16px;
    }
    
    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
    }
    
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        padding: 12px 30px;
        font-size: 16px;
        font-weight: bold;
    }
    
    .info-box {
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 5px;
        padding: 15px;
        margin-top: 10px;
        display: none;
    }
    
    .info-box.show {
        display: block;
    }
    
    .spinner-border-sm {
        width: 1rem;
        height: 1rem;
    }
    
    .header {
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: white;
        padding: 20px;
        text-align: center;
        border-radius: 10px 10px 0 0;
        margin: -30px -30px 30px -30px;
    }
    
    .alert {
        margin-bottom: 20px;
    }
</style>
</head>
<body style="background-color: #f5f5f5;">

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
        <!-- Sidebar -->
        <div class="col-md-3 bg-primary text-white p-4" style="min-height: 100vh;">
            <div class="text-center mb-4">
                <h4>Home Banking</h4>
                <hr class="bg-white">
            </div>
            
            <div class="text-center mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                </svg>
                <p class="mt-2"><%= usu.getUsuario() %></p>
            </div>
            
            <nav class="nav flex-column">
                <h5 class="text-center mb-3">MENÚ</h5>
                <a class="nav-link text-white" href="Cliente?opcion=info">Información personal</a>
                <a class="nav-link text-white fw-bold" href="ServletTransferencia">Transferencia</a>
                <a class="nav-link text-white" href="Cliente?opcion=movimientos">Historial de movimientos</a>
                <a class="nav-link text-white" href="Cliente?opcion=prestamos">Solicitud de préstamo</a>
                <a class="nav-link text-white" href="Cliente?opcion=prestamos-info">Información de préstamos</a>
            </nav>
            
            <div class="mt-4">
                <form method="post" action="ServletTransferencia">
                    <input type="hidden" name="accion" value="cerrarSesion">
                    <button type="submit" class="btn btn-outline-light w-100">Cerrar sesión</button>
                </form>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="col-md-9">
            <div class="form-container">
                <div class="header">
                    <h2><i class="bi bi-arrow-left-right"></i> Nueva Transferencia</h2>
                    <p class="mb-0">Transfiere dinero de forma segura a cualquier cuenta</p>
                </div>
                
                <!-- Mensajes de error o éxito -->
                <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i> <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if (mensaje != null && exito != null && exito) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle-fill"></i> <%= mensaje %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <!-- Formulario para validar CBU -->
                <% if (cbuValidado == null || !cbuValidado) { %>
                <form method="post" action="ServletTransferencia">
                    <input type="hidden" name="action" value="validarCBU">
                    
                    <div class="form-group">
                        <label for="cbu" class="form-label">CBU de cuenta destino</label>
                        <input type="text" name="cbu" id="cbu" class="form-control" placeholder="Ingrese el CBU de 22 dígitos" maxlength="22" required>
                        <small class="form-text text-muted">El CBU debe tener exactamente 22 dígitos</small>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="bi bi-search"></i> Validar CBU
                        </button>
                    </div>
                </form>
                <% } else { %>
                
                <!-- Formulario principal de transferencia -->
                <form method="post" action="ServletTransferencia">
                    <input type="hidden" name="action" value="confirmar">
                    
                    <div class="form-group">
                        <label for="cuentaOrigen" class="form-label">Cuenta Origen</label>
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
                        <label for="cbu" class="form-label">CBU de cuenta destino</label>
                        <input type="text" name="cbu" id="cbu" class="form-control" value="<%=request.getParameter("cbu") != null ? request.getParameter("cbu") : ""%>" readonly>
                        <small class="form-text text-success">✓ CBU validado correctamente</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="importe" class="form-label">Importe</label>
                        <input type="number" name="importe" id="importe" class="form-control" placeholder="0.00" step="0.01" min="0.01" max="500000" required>
                        <small class="form-text text-muted">Importe máximo: $500,000</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="motivo" class="form-label">Motivo</label>
                        <input type="text" id="motivo" name="motivo" class="form-control" placeholder="Describe el motivo de la transferencia" maxlength="100" required>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-arrow-right"></i> Continuar
                        </button>
                        <a href="ServletTransferencia" class="btn btn-secondary ms-2">
                            <i class="bi bi-arrow-left"></i> Cambiar CBU
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