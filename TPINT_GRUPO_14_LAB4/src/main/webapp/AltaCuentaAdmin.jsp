<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="entidad.Cliente, entidad.Cuenta, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Banking - Alta de Cuentas</title>
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

.btn-back {
	background: #6b7280;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
	text-decoration: none;
	transition: all 0.3s ease;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 20px;
}

.btn-back:hover {
	background: #4b5563;
	transform: translateY(-2px);
	color: white;
	text-decoration: none;
}

.search-section {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.search-section h2 {
	color: #dc2626;
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
	border-bottom: 2px solid #f3f4f6;
	padding-bottom: 15px;
}

.search-form {
	background: #f9fafb;
	padding: 25px;
	border-radius: 8px;
	display: grid;
	grid-template-columns: 1fr 1fr auto;
	gap: 20px;
	align-items: end;
}

.form-group {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.form-group label {
	font-weight: 600;
	color: #374151;
	font-size: 14px;
}

.form-group input, .form-group select {
	padding: 12px;
	border: 2px solid #e5e7eb;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.3s ease;
}

.form-group input:focus, .form-group select:focus {
	outline: none;
	border-color: #dc2626;
	box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
}

.btn-primary {
	background: #16a34a;
	color: white;
	border: none;
	padding: 12px 24px;
	border-radius: 8px;
	cursor: pointer;
	font-weight: 500;
	transition: all 0.3s ease;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-primary:hover {
	background: #15803d;
	transform: translateY(-2px);
}

.btn-success {
	background: #16a34a;
	color: white;
	border: none;
	padding: 12px 24px;
	border-radius: 8px;
	cursor: pointer;
	font-weight: 500;
	transition: all 0.3s ease;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-success:hover {
	background: #15803d;
	transform: translateY(-2px);
}

.btn-success:disabled {
	background: #9ca3af;
	cursor: not-allowed;
	transform: none;
}

.alert {
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 20px;
	font-size: 14px;
}

.alert-error {
	background: #fee2e2;
	color: #991b1b;
	border: 1px solid #dc2626;
}

.alert-success {
	background: #dcfce7;
	color: #166534;
	border: 1px solid #16a34a;
}

.alert-warning {
	background: #eff6ff;
	color: #1e40af;
	border: 1px solid #3b82f6;
}

.client-info {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.client-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 2px solid #f3f4f6;
}

.client-header h3 {
	color: #dc2626;
	font-size: 24px;
	font-weight: bold;
}

.client-details {
	background: #f9fafb;
	padding: 25px;
	border-radius: 8px;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 20px;
}

.detail-item {
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.detail-label {
	font-size: 12px;
	color: #6b7280;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.05em;
}

.detail-value {
	font-size: 14px;
	color: #1f2937;
	font-weight: 500;
}

.accounts-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	background: white;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.accounts-table th {
	background: #dc2626;
	color: white;
	padding: 15px;
	text-align: left;
	font-weight: 600;
	font-size: 14px;
}

.accounts-table td {
	padding: 15px;
	border-bottom: 1px solid #e5e7eb;
	font-size: 14px;
}

.accounts-table tr:hover {
	background: #f9fafb;
}

.account-type {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.05em;
}

.account-type.ahorro {
	background: #dcfce7;
	color: #16a34a;
}

.account-type.corriente {
	background: #dbeafe;
	color: #2563eb;
}

.new-account-section {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.new-account-section h3 {
	color: #dc2626;
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
	border-bottom: 2px solid #f3f4f6;
	padding-bottom: 15px;
}

.new-account-form {
	background: #f9fafb;
	padding: 25px;
	border-radius: 8px;
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	align-items: end;
}

.new-account-form .form-group:last-child {
	grid-column: span 2;
	justify-self: center;
}

.create-client-section {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	text-align: center;
	margin-bottom: 20px;
}

.create-client-section h3 {
	color: #dc2626;
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 15px;
}

.create-client-section p {
	color: #6b7280;
	margin-bottom: 20px;
	font-size: 16px;
}

.info-section {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	text-align: center;
	color: #6b7280;
}

.info-section h3 {
	color: #dc2626;
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
}

.form-note {
	background: #eff6ff;
	border: 1px solid #3b82f6;
	border-radius: 8px;
	padding: 15px;
	margin-bottom: 20px;
	font-size: 14px;
	color: #1e40af;
}

@media (max-width: 768px) {
	.sidebar {
		width: 100%;
		position: absolute;
		z-index: 1000;
		transform: translateX(-100%);
		transition: transform 0.3s ease;
	}
	
	.main-content {
		margin-left: 0;
	}
	
	.search-form {
		grid-template-columns: 1fr;
	}
	
	.new-account-form {
		grid-template-columns: 1fr;
	}
	
	.client-details {
		grid-template-columns: 1fr;
	}
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
		<a href="ServletAlta" class="menu-item">Alta de usuarios</a> 
		<a href="ServletReportes?año=2025" class="menu-item">Reportes</a>
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
			<!-- Botón volver -->
			<a href="Admin" class="btn-back">
				← Volver al Panel Principal
			</a>

			<%
			// Obtener mensajes del request
			String error = (String) request.getAttribute("error");
			String success = (String) request.getAttribute("success");
			String warning = (String) request.getAttribute("warning");
			%>

			<!-- Mostrar mensajes de error/éxito -->
			<%if (error != null && !error.isEmpty()) {%>
			<div class="alert alert-error">❌ <%=error%></div>
			<%}%>
			<%if (success != null && !success.isEmpty()) {%>
			<div class="alert alert-success">✅ <%=success%></div>
			<%}%>
			<%if (warning != null && !warning.isEmpty()) {%>
			<div class="alert alert-warning">⚠️ <%=warning%></div>
			<%}%>

			<!-- Sección de búsqueda -->
			<div class="search-section">
				<h2>🔍 Buscar Cliente</h2>
				<p style="color: #6b7280; text-align: center; margin-bottom: 20px;">
					Para crear una nueva cuenta bancaria, primero debe buscar y seleccionar al cliente
				</p>
				<form class="search-form" action="ServletAltaCuentas" method="post">
					<input type="hidden" name="action" value="buscarCliente">
					<div class="form-group">
						<label for="searchType">Buscar por:</label> 
						<select id="searchType" name="searchType" required>
							<option value="dni">DNI</option>
							<option value="email">Email</option>
						</select>
					</div>
					<div class="form-group">
						<label for="searchValue">Valor:</label> 
						<input type="text" id="searchValue" name="searchValue"
							placeholder="Ingrese el valor a buscar" required>
					</div>
					<button type="submit" class="btn-primary">🔍 Buscar Cliente</button>
				</form>
			</div>

			<%
			// Obtener atributos
			Object mostrarBotonCrear = request.getAttribute("mostrarBotonCrear");
			Cliente cliente = (Cliente) request.getAttribute("cliente");
			String searchType = (String) request.getAttribute("searchType");
			String searchValue = (String) request.getAttribute("searchValue");
			%>

			<!-- Mostrar opción de crear cliente si no se encuentra -->
			<%if (mostrarBotonCrear != null && (Boolean) mostrarBotonCrear) {%>
			<div class="create-client-section">
				<h3>❌ Cliente no encontrado</h3>
				<p>
					El cliente con <%=searchType%>: "<%=searchValue%>" no fue encontrado en el sistema.
				</p>
				<a href="ServletAlta" class="btn-primary">✨ Crear Nuevo Cliente</a>
			</div>
			<%}%>

			<!-- Información del cliente seleccionado -->
			<%if (cliente != null) {%>
			<div class="client-info">
				<div class="client-header">
					<h3>👤 Información del Cliente</h3>
					<div style="display: flex; align-items: center; gap: 10px;">
						<span style="padding: 6px 15px; border-radius: 20px; font-size: 12px; font-weight: 600; 
							<%=cliente.isActivo() ? "background: #dcfce7; color: #16a34a;" : "background: #fee2e2; color: #dc2626;"%>">
							<%=cliente.isActivo() ? "✅ Activo" : "❌ Inactivo"%>
						</span>
					</div>
				</div>

				<div class="client-details">
					<div class="detail-item">
						<span class="detail-label">Nombre Completo</span> 
						<span class="detail-value"><%=cliente.getNombre()%> <%=cliente.getApellido()%></span>
					</div>
					<div class="detail-item">
						<span class="detail-label">DNI</span> 
						<span class="detail-value"><%=cliente.getDNI()%></span>
					</div>
					<div class="detail-item">
						<span class="detail-label">Email</span> 
						<span class="detail-value"><%=cliente.getCorreo()%></span>
					</div>
					<div class="detail-item">
						<span class="detail-label">Teléfono</span> 
						<span class="detail-value"><%=cliente.getTelefono()%></span>
					</div>
					<div class="detail-item">
						<span class="detail-label">Género</span> 
						<span class="detail-value"><%=cliente.getGenero()%></span>
					</div>
					<div class="detail-item">
						<span class="detail-label">Estado</span> 
						<span class="detail-value"><%=cliente.isActivo() ? "Activo" : "Inactivo"%></span>
					</div>
				</div>

				<%
					Integer cantidadCuentasActivas = (Integer) request.getAttribute("cantidadCuentasActivas");
					List<Cuenta> cuentasCliente = (List<Cuenta>) request.getAttribute("cuentasCliente");
				%>

				<h4 style="color: #dc2626; margin-bottom: 15px; font-size: 18px; font-weight: bold;">
					🏦 Cuentas Actuales - Activas: (<%=cantidadCuentasActivas != null ? cantidadCuentasActivas : 0%>/3)
				</h4>

				<%if (cuentasCliente != null && !cuentasCliente.isEmpty()) {%>
				<table class="accounts-table">
					<thead>
						<tr>
							<th>Número de Cuenta</th>
							<th>CBU</th>
							<th>Tipo</th>
							<th>Saldo</th>
							<th>Estado</th>
							<th>Fecha Creación</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%for (Cuenta cuenta : cuentasCliente) {%>
						<tr>
							<td><%=cuenta.getNumeroCuenta()%></td>
							<td><%=cuenta.getCbu()%></td>
							<td>
								<span class="account-type <%=cuenta.getIdTipoCuenta() == 1 ? "ahorro" : "corriente"%>">
									<%=cuenta.getIdTipoCuenta() == 1 ? "Ahorro" : "Corriente"%>
								</span>
							</td>
							<td>$<%=cuenta.getSaldo()%></td>
							<td><%=cuenta.isActiva() ? "Activa" : "Inactiva"%></td>
							<td><%=cuenta.getFechaCreacion()%></td>
							<td>
								<%if (cuenta.isActiva()) {%>
								<div style="display: flex; gap: 5px; align-items: center;">
									<!-- Botón Inhabilitar -->
									<button type="button"
										style="background: #f59e0b; color: white; padding: 6px 8px; border: none; border-radius: 4px; cursor: pointer; font-size: 10px; min-width: 32px; height: 32px; display: inline-flex; align-items: center; justify-content: center;"
										title="Inhabilitar cuenta (ocultar del cliente)"
										onclick="confirmarInhabilitacion(<%=cuenta.getIdCuenta()%>, '<%=cuenta.getNumeroCuenta()%>', <%=cliente.getId()%>)">
										🚫
									</button>
								</div> 
								<%} else {%> 
								<span style="color: #6b7280; font-style: italic;">Inactiva</span>
								<%}%>
							</td>
						</tr>
						<%}%>
					</tbody>
				</table>
				<%} else {%>
				<p style="text-align: center; color: #6b7280; font-style: italic;">No hay cuentas registradas para este cliente.</p>
				<%}%>
			</div>

			<!-- Sección para crear nueva cuenta -->
			<%if (cantidadCuentasActivas != null && cantidadCuentasActivas < 3) {%>
			<div class="new-account-section">
				<h3>✨ Crear Nueva Cuenta</h3>

				<form class="new-account-form" action="ServletAltaCuentas" method="post">
					<input type="hidden" name="action" value="crearCuenta"> 
					<input type="hidden" name="clienteId" value="<%=cliente.getId()%>">

					<div class="form-group">
						<label for="accountType">🏦 Tipo de Cuenta:</label> 
						<select id="accountType" name="accountType" required>
							<option value="">Seleccione un tipo</option>
							<option value="CA">💰 Cuenta de Ahorro</option>
							<option value="CC">💳 Cuenta Corriente</option>
						</select> 
						<small style="color: #6b7280; font-size: 12px;"> 
							Puede crear cualquier combinación de tipos hasta un máximo de 3 cuentas activas.
						</small>
					</div>

					<div class="form-group">
						<label for="initialBalance">💵 Saldo Inicial:</label> 
						<input type="number" id="initialBalance" name="initialBalance" min="0"
							step="0.01" placeholder="0.00" value="0.00" required> 
						<small style="color: #6b7280; font-size: 12px;">Monto mínimo: $0.00</small>
					</div>

					<div class="form-group">
						<label for="accountDescription">📝 Descripción (opcional):</label>
						<input type="text" id="accountDescription" name="accountDescription"
							placeholder="Ej: Cuenta para gastos personales" maxlength="100">
					</div>

					<div class="form-group">
						<button type="submit" class="btn-success">✅ Crear Cuenta</button>
					</div>
				</form>

				<!-- Información sobre límites -->
				<div class="form-note">
					<h4 style="color: #dc2626; margin-bottom: 15px; font-size: 16px; font-weight: bold;">
						📋 Límites de Cuentas por Cliente
					</h4>
					<ul style="color: #6b7280; font-size: 14px; margin: 0; padding-left: 20px;">
						<li>📊 Máximo 3 cuentas activas por cliente</li>
						<li>🔄 Puede tener cualquier combinación de tipos (Ej: 3 cuentas de ahorro, 2 corrientes + 1 ahorro, etc.)</li>
						<li>🔒 Si el cliente tiene cuentas inactivas, no cuentan para el límite</li>
						<li>💰 El saldo inicial puede ser $0.00 o mayor</li>
					</ul>
				</div>
			</div>
			<%}%>

			<%if (cantidadCuentasActivas != null && cantidadCuentasActivas >= 3) {%>
			<div class="alert alert-warning">
				<strong>⚠️ Límite alcanzado:</strong> Este cliente ya tiene el máximo de 3 cuentas activas permitidas. 
				Para crear una nueva cuenta, primero debe inhabilitar una cuenta existente.
			</div>
			<%}%>
			<%}%>

			<!-- Información adicional cuando no hay cliente seleccionado -->
			<%if (cliente == null && (mostrarBotonCrear == null || !(Boolean) mostrarBotonCrear)) {%>
			<div class="info-section">
				<h3>📋 Instrucciones</h3>
				<p style="color: #6b7280; margin-bottom: 15px;">
					Para crear una nueva cuenta bancaria, primero debe buscar y seleccionar al cliente utilizando su DNI o correo electrónico.
				</p>
				<p style="color: #6b7280;">
					Una vez seleccionado el cliente, podrá crear hasta 3 cuentas activas de cualquier tipo (ahorro o corriente) en las combinaciones que desee.
				</p>
			</div>
			<%}%>
		</div>
	</div>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            // Validación del formulario de creación de cuenta
            const createForm = document.querySelector('.new-account-form');
            if (createForm) {
                createForm.addEventListener('submit', function(e) {
                    const accountType = document.getElementById('accountType').value;
                    const initialBalance = document.getElementById('initialBalance').value;
                    
                    if (!accountType) {
                        e.preventDefault();
                        alert('Debe seleccionar un tipo de cuenta.');
                        return;
                    }
                    
                    if (parseFloat(initialBalance) < 0) {
                        e.preventDefault();
                        alert('El saldo inicial no puede ser negativo.');
                        return;
                    }
                    
                    // Confirmación antes de crear la cuenta
                    const tipoText = accountType === 'CA' ? 'Cuenta de Ahorro' : 'Cuenta Corriente';
                    const confirmMessage = `¿Está seguro de crear una ${tipoText} con saldo inicial de $${initialBalance}?`;
                    
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

        function confirmarInhabilitacion(idCuenta, numeroCuenta, clienteId) {
            if (confirm('¿Está seguro de que desea INHABILITAR la cuenta ' + numeroCuenta + '?\n\n' +
                       '📋 INHABILITAR significa:\n' +
                       '✅ La cuenta se ocultará del cliente\n' +
                       '✅ El cliente no podrá operar con ella\n' +
                       '✅ El saldo se mantendrá intacto\n' +
                       '✅ Como admin, podrás reactivarla después\n' +
                       '✅ No contará para el límite de cuentas activas\n\n' +
                       '🔄 Esta acción es REVERSIBLE.')) {
                
                enviarAccion('desactivarCuenta', idCuenta, clienteId);
            }
        }

        function enviarAccion(action, idCuenta, clienteId) {
            // Crear un formulario dinámico para enviar la solicitud
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = 'ServletAltaCuentas';
            
            // Campo action
            var actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = action;
            form.appendChild(actionInput);
            
            // Campo idCuenta
            var idCuentaInput = document.createElement('input');
            idCuentaInput.type = 'hidden';
            idCuentaInput.name = 'idCuenta';
            idCuentaInput.value = idCuenta;
            form.appendChild(idCuentaInput);
            
            // Campo clienteId
            var clienteIdInput = document.createElement('input');
            clienteIdInput.type = 'hidden';
            clienteIdInput.name = 'clienteId';
            clienteIdInput.value = clienteId;
            form.appendChild(clienteIdInput);
            
            // Agregar el formulario al DOM y enviarlo
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>