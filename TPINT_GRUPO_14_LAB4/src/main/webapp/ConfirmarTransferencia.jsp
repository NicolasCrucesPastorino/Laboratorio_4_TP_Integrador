<%@ page import="java.math.BigDecimal" %>
<%@ page import="entidad.Cuenta" %>
<%@ page import="entidad.Cliente" %>
<%@ page import="entidad.Usuario" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Confirmar Transferencia - Home Banking</title>
<style>
    .form-container {
        background: white;
        border-radius: 10px;
        padding: 30px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        max-width: 600px;
        margin: 20px auto;
    }
    
    .header {
        background: linear-gradient(135deg, #dc3545, #b02a37);
        color: white;
        padding: 20px;
        text-align: center;
        border-radius: 10px 10px 0 0;
        margin: -30px -30px 30px -30px;
    }
    
    .info-card {
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
    }
    
    .info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        padding: 8px 0;
        border-bottom: 1px solid #e9ecef;
    }
    
    .info-row:last-child {
        border-bottom: none;
        font-weight: bold;
        font-size: 1.1em;
    }
    
    .info-label {
        font-weight: bold;
        color: #495057;
    }
    
    .info-value {
        color: #212529;
    }
    
    .warning-box {
        background: #fff3cd;
        border: 1px solid #ffeaa7;
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 20px;
    }
</style>
</head>
<body style="background-color: #f5f5f5;">

<% 
    Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
    Cuenta cuentaOrigen = (Cuenta) request.getAttribute("cuentaOrigen");
    Cuenta cuentaDestino = (Cuenta) request.getAttribute("cuentaDestino");
    Cliente titular = (Cliente) request.getAttribute("titular");
    BigDecimal importe = (BigDecimal) request.getAttribute("importe");
    String motivo = (String) request.getAttribute("motivo");
    
    if (usu == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    if (cuentaOrigen == null || cuentaDestino == null || titular == null || importe == null || motivo == null) {
        response.sendRedirect("ServletTransferencia");
        return;
    }
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
        </div>
        
        <!-- Main Content -->
        <div class="col-md-9">
            <div class="form-container">
                <div class="header">
                    <h2><i class="bi bi-exclamation-triangle"></i> Confirmar Transferencia</h2>
                    <p class="mb-0">Revise cuidadosamente los datos antes de confirmar</p>
                </div>
                
                <div class="warning-box">
                    <h6><i class="bi bi-info-circle"></i> Importante</h6>
                    <p class="mb-0">Una vez confirmada, la transferencia no podrá ser cancelada. Verifique que todos los datos sean correctos.</p>
                </div>
                
                <div class="info-card">
                    <h5 class="mb-3"><i class="bi bi-bank"></i> Detalles de la Transferencia</h5>
                    
                    <div class="info-row">
                        <span class="info-label">Cuenta Origen:</span>
                        <span class="info-value"><%= cuentaOrigen.getNumeroCuenta() %></span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Saldo Disponible:</span>
                        <span class="info-value">$<%= cuentaOrigen.getSaldo() %></span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">CBU Destino:</span>
                        <span class="info-value"><%= cuentaDestino.getCbu() %></span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Cuenta Destino:</span>
                        <span class="info-value"><%= cuentaDestino.getNumeroCuenta() %></span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Destinatario:</span>
                        <span class="info-value"><%= titular.getNombre() %> <%= titular.getApellido() %></span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Motivo:</span>
                        <span class="info-value"><%= motivo %></span>
                    </div>
                    
                    <div class="info-row">
                        <span class="info-label">Importe a Transferir:</span>
                        <span class="info-value text-danger">$<%= importe %></span>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <form method="post" action="ServletTransferencia">
                            <input type="hidden" name="action" value="transferir">
                            <button type="submit" class="btn btn-danger w-100" onclick="return confirm('¿Está seguro de que desea realizar esta transferencia?')">
                                <i class="bi bi-check-circle"></i> Confirmar Transferencia
                            </button>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <a href="ServletTransferencia" class="btn btn-secondary w-100">
                            <i class="bi bi-arrow-left"></i> Cancelar
                        </a>
                    </div>
                </div>
                
                <div class="mt-3 text-center">
                    <small class="text-muted">
                        <i class="bi bi-shield-check"></i> 
                        Esta operación es segura y está protegida por nuestros sistemas de seguridad
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html> 