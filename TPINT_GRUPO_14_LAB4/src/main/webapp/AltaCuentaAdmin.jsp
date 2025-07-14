<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="entidad.Cliente" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alta de Cuentas - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 260px;
            background: rgba(185, 28, 28, 0.9);
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .menu-title {
            color: white;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            letter-spacing: 1px;
        }

        .menu-item {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .menu-item.active {
            background: rgba(255, 255, 255, 0.2);
        }

        .logout-btn {
            margin-top: auto;
            background: #991b1b;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #7f1d1d;
            transform: translateY(-2px);
        }

        .main-content {
            flex: 1;
            padding: 0;
            background: linear-gradient(135deg, #fca5a5, #f87171);
            display: flex;
            flex-direction: column;
        }

        .header {
            background: #dc2626;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            font-size: 24px;
            font-weight: 300;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .content-area {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }

        .search-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .search-section h2 {
            color: #dc2626;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .form-group label {
            color: #374151;
            font-weight: 500;
            font-size: 14px;
        }

        .form-group input, .form-group select {
            padding: 10px;
            border: 2px solid #e5e7eb;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #dc2626;
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .btn-primary {
            background: #dc2626;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: #b91c1c;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6b7280;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #4b5563;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .client-info {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .client-info h3 {
            color: #dc2626;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .client-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .detail-label {
            color: #6b7280;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .detail-value {
            color: #374151;
            font-size: 14px;
            font-weight: 500;
        }

        .accounts-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .accounts-table th, .accounts-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        .accounts-table th {
            background: #f9fafb;
            color: #374151;
            font-weight: 600;
        }

        .account-type {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .account-type.ahorro {
            background: #dcfce7;
            color: #166534;
        }

        .account-type.corriente {
            background: #fef3c7;
            color: #92400e;
        }

        .new-account-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .new-account-section h3 {
            color: #dc2626;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .new-account-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .btn-success {
            background: #16a34a;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background: #15803d;
            transform: translateY(-2px);
        }

        .alert {
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-warning {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #f59e0b;
        }

        .alert-success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #16a34a;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #dc2626;
        }

        .create-client-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .create-client-section h3 {
            color: #dc2626;
            margin-bottom: 15px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="menu-title">MENÚ ADMIN</div>
        <a href="Admin" class="menu-item">Panel Principal</a>
        <a href="Admin?opcion=clientes" class="menu-item">Gestión de clientes</a>
        <a href="Admin?opcion=prestamos" class="menu-item">Gestión de préstamos</a>
        <a href="ServletAltaCuentas" class="menu-item active">Alta de cuentas</a>
        <form action="ServletLogout" method="post" style="margin-top: auto;">
            <button type="submit" class="logout-btn">Cerrar sesión</button>
        </form>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>🏦 Admin Banking - Alta de Cuentas</h1>
            <div class="admin-info">
                <span>👤 ${sessionScope.usuarioLogueado.usuario}</span>
                <span>Admin</span>
            </div>
        </div>

        <div class="content-area">
            <!-- Mostrar mensajes de error/éxito -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty warning}">
                <div class="alert alert-warning">${warning}</div>
            </c:if>

            <!-- Sección de búsqueda -->
            <div class="search-section">
                <h2>Buscar Cliente</h2>
                <form class="search-form" action="ServletAltaCuentas" method="post">
                    <input type="hidden" name="action" value="buscarCliente">
                    <div class="form-group">
                        <label for="searchType">Buscar por:</label>
                        <select id="searchType" name="searchType" required>
                            <option value="dni" ${searchType == 'dni' ? 'selected' : ''}>DNI</option>
                            <option value="email" ${searchType == 'email' ? 'selected' : ''}>Email</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="searchValue">Valor:</label>
                        <input type="text" id="searchValue" name="searchValue" 
                               placeholder="Ingrese el valor a buscar" 
                               value="${searchValue}" required>
                    </div>
                    <button type="submit" class="btn-primary">Buscar Cliente</button>
                </form>
            </div>

            <!-- Mostrar opción de crear cliente si no se encuentra -->
            <c:if test="${mostrarBotonCrear}">
                <div class="create-client-section">
                    <h3>Cliente no encontrado</h3>
                    <p>El cliente con ${searchType}: "${searchValue}" no existe en el sistema.</p>
                    <a href="ServletAlta" class="btn-secondary">Crear Nuevo Cliente</a>
                </div>
            </c:if>

            <!-- Información del cliente -->
            <c:if test="${not empty cliente}">
                <div class="client-info">
                    <h3>Información del Cliente</h3>
                    <div class="client-details">
                        <div class="detail-item">
                            <div class="detail-label">DNI</div>
                            <div class="detail-value">${cliente.DNI}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Nombre Completo</div>
                            <div class="detail-value">${cliente.nombre} ${cliente.apellido}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Email</div>
                            <div class="detail-value">${cliente.correo}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Teléfono</div>
                            <div class="detail-value">${cliente.telefono}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Dirección</div>
                            <div class="detail-value">${cliente.direccion}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Fecha de Nacimiento</div>
                            <div class="detail-value">
                                <c:choose>
                                    <c:when test="${not empty cliente.fecha_nacimiento}">
                                        <%
                                            Cliente clienteObj = (Cliente) request.getAttribute("cliente");
                                            if (clienteObj != null && clienteObj.getFecha_nacimiento() != null) {
                                                LocalDate fechaNac = clienteObj.getFecha_nacimiento();
                                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                                                out.print(fechaNac.format(formatter));
                                            } else {
                                                out.print("No especificada");
                                            }
                                        %>
                                    </c:when>
                                    <c:otherwise>
                                        No especificada
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Fecha de Alta</div>
                            <div class="detail-value">
                                <c:choose>
                                    <c:when test="${not empty cliente.fecha_alta}">
                                        <fmt:formatDate value="${cliente.fecha_alta}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>
                                        No especificada
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Estado</div>
                            <div class="detail-value">
                                <span class="account-type ${cliente.activo ? 'ahorro' : 'corriente'}">
                                    ${cliente.activo ? 'Activo' : 'Inactivo'}
                                </span>
                            </div>
                        </div>
                    </div>

                    <h4 style="color: #dc2626; margin-bottom: 10px;">
                        Cuentas Actuales (${cantidadCuentas}/3)
                    </h4>
                    
                    <c:choose>
                        <c:when test="${not empty cuentasCliente}">
                            <table class="accounts-table">
                                <thead>
                                    <tr>
                                        <th>Número de Cuenta</th>
                                        <th>CBU</th>
                                        <th>Tipo</th>
                                        <th>Saldo</th>
                                        <th>Estado</th>
                                        <th>Fecha Creación</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cuenta" items="${cuentasCliente}">
                                        <tr>
                                            <td>${cuenta.numeroCuenta}</td>
                                            <td>${cuenta.cbu}</td>
                                            <td>
                                                <span class="account-type ${cuenta.idTipoCuenta == 1 ? 'ahorro' : 'corriente'}">
                                                    ${cuenta.idTipoCuenta == 1 ? 'Cuenta de Ahorro' : 'Cuenta Corriente'}
                                                </span>
                                            </td>
                                            <td>$<fmt:formatNumber value="${cuenta.saldo}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                                            <td>${cuenta.activa ? 'Activa' : 'Inactiva'}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cuenta.fechaCreacion}">
                                                        <fmt:formatDate value="${cuenta.fechaCreacion}" pattern="dd/MM/yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        -
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p>No hay cuentas registradas para este cliente.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Sección para crear nueva cuenta -->
                <c:if test="${cantidadCuentas < 3}">
                    <div class="new-account-section">
                        <h3>Crear Nueva Cuenta</h3>
                        
                        <form class="new-account-form" action="ServletAltaCuentas" method="post">
                            <input type="hidden" name="action" value="crearCuenta">
                            <input type="hidden" name="clienteId" value="${cliente.id}">
                            
                            <div class="form-group">
                                <label for="accountType">Tipo de Cuenta:</label>
                                <select id="accountType" name="accountType" required>
                                    <option value="">Seleccione un tipo</option>
                                    <c:if test="${cantidadCuentasAhorro < 2}">
                                        <option value="CA">Cuenta de Ahorro (Máximo 2)</option>
                                    </c:if>
                                    <c:if test="${cantidadCuentasCorriente < 1}">
                                        <option value="CC">Cuenta Corriente (Máximo 1)</option>
                                    </c:if>
                                    <c:if test="${cantidadCuentasAhorro >= 2 && cantidadCuentasCorriente >= 1}">
                                        <option value="" disabled>No hay tipos de cuenta disponibles</option>
                                    </c:if>
                                </select>
                                <small style="color: #6b7280; font-size: 12px;">
                                    Cuentas de Ahorro: ${cantidadCuentasAhorro}/2 | 
                                    Cuentas Corriente: ${cantidadCuentasCorriente}/1
                                </small>
                            </div>
                            
                            <div class="form-group">
                                <label for="initialBalance">Saldo Inicial:</label>
                                <input type="number" id="initialBalance" name="initialBalance" 
                                       min="0" step="0.01" placeholder="0.00" value="0.00" required>
                                <small style="color: #6b7280; font-size: 12px;">
                                    Monto mínimo: $0.00
                                </small>
                            </div>
                            
                            <div class="form-group">
                                <label for="accountDescription">Descripción (opcional):</label>
                                <input type="text" id="accountDescription" name="accountDescription" 
                                       placeholder="Ej: Cuenta para gastos personales" maxlength="100">
                            </div>
                            
                            <div class="form-group" style="display: flex; align-items: end;">
                                <c:choose>
                                    <c:when test="${cantidadCuentasAhorro < 2 || cantidadCuentasCorriente < 1}">
                                        <button type="submit" class="btn-success">Crear Cuenta</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn-success" disabled>
                                            No hay tipos disponibles
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </form>
                        
                        <!-- Información sobre límites -->
                        <div style="margin-top: 20px; padding: 15px; background: #f9fafb; border-radius: 6px;">
                            <h4 style="color: #374151; margin-bottom: 10px; font-size: 16px;">
                                Límites de Cuentas por Cliente
                            </h4>
                            <ul style="color: #6b7280; font-size: 14px; margin: 0; padding-left: 20px;">
                                <li>Máximo 3 cuentas en total por cliente</li>
                                <li>Máximo 2 cuentas de ahorro por cliente</li>
                                <li>Máximo 1 cuenta corriente por cliente</li>
                                <li>El saldo inicial puede ser $0.00 o mayor</li>
                            </ul>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${cantidadCuentas >= 3}">
                    <div class="alert alert-warning">
                        <strong>Límite alcanzado:</strong> Este cliente ya tiene el máximo de 3 cuentas permitidas.
                        Para crear una nueva cuenta, primero debe darse de baja una cuenta existente.
                    </div>
                </c:if>
            </c:if>
            
            <!-- Información adicional cuando no hay cliente seleccionado -->
            <c:if test="${empty cliente && empty mostrarBotonCrear}">
                <div style="background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); text-align: center;">
                    <h3 style="color: #6b7280; margin-bottom: 15px;">Buscar Cliente para Crear Cuenta</h3>
                    <p style="color: #9ca3af; margin-bottom: 20px;">
                        Utilice el formulario de búsqueda para encontrar un cliente existente o crear uno nuevo.
                    </p>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; max-width: 600px; margin: 0 auto;">
                        <div style="padding: 20px; background: #f9fafb; border-radius: 8px;">
                            <h4 style="color: #374151; margin-bottom: 10px;">Buscar por DNI</h4>
                            <p style="color: #6b7280; font-size: 14px;">
                                Ingrese el DNI del cliente para buscar sus datos y cuentas existentes.
                            </p>
                        </div>
                        <div style="padding: 20px; background: #f9fafb; border-radius: 8px;">
                            <h4 style="color: #374151; margin-bottom: 10px;">Buscar por Email</h4>
                            <p style="color: #6b7280; font-size: 14px;">
                                Ingrese el email del cliente para acceder a su información.
                            </p>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        // Validación del formulario de creación de cuenta
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form[action*="crearCuenta"]');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const accountType = document.getElementById('accountType').value;
                    const initialBalance = document.getElementById('initialBalance').value;
                    
                    if (!accountType) {
                        e.preventDefault();
                        alert('Por favor seleccione un tipo de cuenta.');
                        return;
                    }
                    
                    if (parseFloat(initialBalance) < 0) {
                        e.preventDefault();
                        alert('El saldo inicial no puede ser negativo.');
                        return;
                    }
                    
                    // Confirmación antes de crear la cuenta
                    const tipoText = accountType === 'CA' ? 'Cuenta de Ahorro' : 'Cuenta Corriente';
                    const confirmMessage = `¿Está seguro de crear una ${tipoText} con saldo inicial de ${initialBalance}?`;
                    
                    if (!confirm(confirmMessage)) {
                        e.preventDefault();
                    }
                });
            }
            
            // Auto-focus en el campo de búsqueda si está vacío
            const searchValue = document.getElementById('searchValue');
            if (searchValue && !searchValue.value) {
                searchValue.focus();
            }
        });
    </script>
</body>
</html>