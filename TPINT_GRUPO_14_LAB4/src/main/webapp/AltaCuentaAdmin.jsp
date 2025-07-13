<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .hide {
            display: none;
        }

        .show {
            display: block;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="menu-title">MENÚ ADMIN</div>
        <a href="gestionClientes.jsp" class="menu-item">Gestión de clientes</a>
        <a href="gestionPrestamos.jsp" class="menu-item">Gestión de préstamos</a>
        <a href="altaCuentas.jsp" class="menu-item active">Alta de cuentas</a>
        <a href="informes.jsp" class="menu-item">Informes</a>
        <a href="configuracion.jsp" class="menu-item">Configuración</a>
        <form action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">Cerrar sesión</button>
        </form>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>🏦 Admin Banking - Alta de Cuentas</h1>
            <div class="admin-info">
                <span>👤 ${sessionScope.usuarioLogueado.nombre}</span>
                <span>ID: ${sessionScope.usuarioLogueado.id}</span>
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
                <form class="search-form" action="BuscarClienteServlet" method="post">
                    <div class="form-group">
                        <label for="searchType">Buscar por:</label>
                        <select id="searchType" name="searchType" required>
                            <option value="dni" ${searchType == 'dni' ? 'selected' : ''}>DNI</option>
                            <option value="cuil" ${searchType == 'cuil' ? 'selected' : ''}>CUIL</option>
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

            <!-- Información del cliente -->
            <c:if test="${not empty cliente}">
                <div class="client-info">
                    <h3>Información del Cliente</h3>
                    <div class="client-details">
                        <div class="detail-item">
                            <div class="detail-label">DNI</div>
                            <div class="detail-value">${cliente.dni}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">CUIL</div>
                            <div class="detail-value">${cliente.cuil}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Nombre Completo</div>
                            <div class="detail-value">${cliente.nombre} ${cliente.apellido}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Email</div>
                            <div class="detail-value">${cliente.email}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Teléfono</div>
                            <div class="detail-value">${cliente.telefono}</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Fecha de Nacimiento</div>
                            <div class="detail-value">${cliente.fechaNacimiento}</div>
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
                                            <td>
                                                <span class="account-type ${cuenta.tipoCuenta.toLowerCase()}">
                                                    ${cuenta.tipoCuenta == 'CA' ? 'Ahorro' : 'Corriente'}
                                                </span>
                                            </td>
                                            <td>$${cuenta.saldo}</td>
                                            <td>${cuenta.estado ? 'Activa' : 'Inactiva'}</td>
                                            <td>${cuenta.fechaCreacion}</td>
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
                        
                        <form class="new-account-form" action="CrearCuentaServlet" method="post">
                            <input type="hidden" name="clienteId" value="${cliente.id}">
                            
                            <div class="form-group">
                                <label for="accountType">Tipo de Cuenta:</label>
                                <select id="accountType" name="accountType" required>
                                    <option value="">Seleccione un tipo</option>
                                    <c:if test="${cantidadCuentasAhorro < 2}">
                                        <option value="CA">Cuenta de Ahorro</option>
                                    </c:if>
                                    <c:if test="${cantidadCuentasCorriente < 1}">
                                        <option value="CC">Cuenta Corriente</option>
                                    </c:if>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="initialBalance">Saldo Inicial:</label>
                                <input type="number" id="initialBalance" name="initialBalance" 
                                       min="0" step="0.01" placeholder="0.00" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="accountDescription">Descripción (opcional):</label>
                                <input type="text" id="accountDescription" name="accountDescription" 
                                       placeholder="Ej: Cuenta para gastos personales">
                            </div>
                            
                            <div class="form-group">
                                <button type="submit" class="btn-success">Crear Cuenta</button>
                            </div>
                        </form>
                    </div>
                </c:if>
                
                <c:if test="${cantidadCuentas >= 3}">
                    <div class="alert alert-warning">
                        Este cliente ya tiene el máximo de 3 cuentas permitidas.
                    </div>
                </c:if>
            </c:if>
        </div>
    </div>
</body>
</html>