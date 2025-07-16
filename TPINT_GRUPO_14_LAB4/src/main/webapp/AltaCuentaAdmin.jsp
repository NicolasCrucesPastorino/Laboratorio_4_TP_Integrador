<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="entidad.Cliente"%>
<%@ page import="entidad.Cuenta"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
				<span>👤 Admin</span>
			</div>
		</div>

		<div class="content-area">
			<%
			// Obtener mensajes del request
			String error = (String) request.getAttribute("error");
			String success = (String) request.getAttribute("success");
			String warning = (String) request.getAttribute("warning");
			%>

			<!-- Mostrar mensajes de error/éxito -->
			<%if (error != null && !error.isEmpty()) {%>
				<div class="alert alert-error"><%=error%></div>
			<%}%>
			<%if (success != null && !success.isEmpty()) {%>
				<div class="alert alert-success"><%=success%></div>
			<%}%>
			<%if (warning != null && !warning.isEmpty()) {%>
				<div class="alert alert-warning"><%=warning%></div>
			<%}%>

			<!-- Sección de búsqueda -->
			<div class="search-section">
				<h2>Buscar Cliente</h2>
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
						<input type="text" id="searchValue" name="searchValue" placeholder="Ingrese el valor a buscar" required>
					</div>
					<button type="submit" class="btn-primary">Buscar Cliente</button>
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
					<h3>Cliente no encontrado</h3>
					<p>El cliente con <%=searchType%>: "<%=searchValue%>" no existe en el sistema.</p>
					<a href="ServletAlta" class="btn-secondary">Crear Nuevo Cliente</a>
				</div>
			<%}%>

			<!-- Información del cliente -->
			<%if (cliente != null) {%>
				<div class="client-info">
					<h3>Información del Cliente</h3>
					<div class="client-details">
						<div class="detail-item">
							<div class="detail-label">DNI</div>
							<div class="detail-value"><%=cliente.getDNI()%></div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Nombre Completo</div>
							<div class="detail-value"><%=cliente.getNombre()%> <%=cliente.getApellido()%></div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Email</div>
							<div class="detail-value"><%=cliente.getCorreo()%></div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Teléfono</div>
							<div class="detail-value"><%=cliente.getTelefono()%></div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Dirección</div>
							<div class="detail-value"><%=cliente.getDireccion()%></div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Fecha de Nacimiento</div>
							<div class="detail-value">
								<%
								if (cliente.getFecha_nacimiento() != null) {
									LocalDate fechaNac = cliente.getFecha_nacimiento();
									DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
									out.print(fechaNac.format(formatter));
								} else {
									out.print("No especificada");
								}
								%>
							</div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Fecha de Alta</div>
							<div class="detail-value">
								<%
								if (cliente.getFecha_alta() != null) {
									SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
									out.print(sdf.format(cliente.getFecha_alta()));
								} else {
									out.print("No especificada");
								}
								%>
							</div>
						</div>
						<div class="detail-item">
							<div class="detail-label">Estado</div>
							<div class="detail-value">
								<span class="account-type <%=cliente.isActivo() ? "ahorro" : "corriente"%>">
									<%=cliente.isActivo() ? "Activo" : "Inactivo"%>
								</span>
							</div>
						</div>
					</div>

					<%
					Integer cantidadCuentas = (Integer) request.getAttribute("cantidadCuentas");
					List<Cuenta> cuentasCliente = (List<Cuenta>) request.getAttribute("cuentasCliente");
					%>

					<h4 style="color: #dc2626; margin-bottom: 10px;">
						Cuentas Actuales (<%=cantidadCuentas != null ? cantidadCuentas : 0%>/3)
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
													<!-- Botón Desactivar -->
													<button type="button"
														style="background: #f59e0b; color: white; padding: 4px 6px; border: none; border-radius: 4px; cursor: pointer; font-size: 10px; min-width: 28px; height: 28px; display: inline-flex; align-items: center; justify-content: center; margin-right: 5px;"
														title="Desactivar cuenta (ocultar del cliente)"
														onclick="confirmarDesactivacion(<%=cuenta.getIdCuenta()%>, '<%=cuenta.getNumeroCuenta()%>', <%=cliente.getId()%>)">
														👁️‍🗨️
													</button>

													<!-- Botón Eliminar -->
													<button type="button"
														style="background: #dc2626; color: white; padding: 4px 6px; border: none; border-radius: 4px; cursor: pointer; font-size: 10px; min-width: 28px; height: 28px; display: inline-flex; align-items: center; justify-content: center;"
														title="Eliminar cuenta definitivamente"
														onclick="confirmarEliminar(<%=cuenta.getIdCuenta()%>, '<%=cuenta.getNumeroCuenta()%>', <%=cliente.getId()%>)">
														🗑️
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
						<p>No hay cuentas registradas para este cliente.</p>
					<%}%>
				</div>

				<%
				Integer cantidadCuentasAhorro = (Integer) request.getAttribute("cantidadCuentasAhorro");
				Integer cantidadCuentasCorriente = (Integer) request.getAttribute("cantidadCuentasCorriente");
				%>

				<!-- Sección para crear nueva cuenta -->
				<%if (cantidadCuentas != null && cantidadCuentas < 3) {%>
					<div class="new-account-section">
						<h3>Crear Nueva Cuenta</h3>

						<form class="new-account-form" action="ServletAltaCuentas" method="post">
							<input type="hidden" name="action" value="crearCuenta"> 
							<input type="hidden" name="clienteId" value="<%=cliente.getId()%>">

							<div class="form-group">
								<label for="accountType">Tipo de Cuenta:</label> 
								<select id="accountType" name="accountType" required>
									<option value="">Seleccione un tipo</option>
									<%if (cantidadCuentasAhorro != null && cantidadCuentasAhorro < 2) {%>
										<option value="CA">Cuenta de Ahorro (Máximo 2)</option>
									<%}%>
									<%if (cantidadCuentasCorriente != null && cantidadCuentasCorriente < 1) {%>
										<option value="CC">Cuenta Corriente (Máximo 1)</option>
									<%}%>
									<%if (cantidadCuentasAhorro != null && cantidadCuentasCorriente != null && cantidadCuentasAhorro >= 2 && cantidadCuentasCorriente >= 1) {%>
										<option value="" disabled>No hay tipos de cuenta disponibles</option>
									<%}%>
								</select> 
								<small style="color: #6b7280; font-size: 12px;">
									Cuentas de Ahorro: <%=cantidadCuentasAhorro != null ? cantidadCuentasAhorro : 0%>/2 | 
									Cuentas Corriente: <%=cantidadCuentasCorriente != null ? cantidadCuentasCorriente : 0%>/1 
								</small>
							</div>

							<div class="form-group">
								<label for="initialBalance">Saldo Inicial:</label> 
								<input type="number" id="initialBalance" name="initialBalance" min="0" step="0.01" placeholder="0.00" value="0.00" required> 
								<small style="color: #6b7280; font-size: 12px;">Monto mínimo: $0.00</small>
							</div>

							<div class="form-group">
								<label for="accountDescription">Descripción (opcional):</label>
								<input type="text" id="accountDescription" name="accountDescription" placeholder="Ej: Cuenta para gastos personales" maxlength="100">
							</div>

							<div class="form-group" style="display: flex; align-items: end;">
								<%if (cantidadCuentasAhorro != null && cantidadCuentasCorriente != null && (cantidadCuentasAhorro < 2 || cantidadCuentasCorriente < 1)) {%>
									<button type="submit" class="btn-success">Crear Cuenta</button>
								<%} else {%>
									<button type="button" class="btn-success" disabled>No hay tipos disponibles</button>
								<%}%>
							</div>
						</form>

						<!-- Información sobre límites -->
						<div style="margin-top: 20px; padding: 15px; background: #f9fafb; border-radius: 6px;">
							<h4 style="color: #374151; margin-bottom: 10px; font-size: 16px;">Límites de Cuentas por Cliente</h4>
							<ul style="color: #6b7280; font-size: 14px; margin: 0; padding-left: 20px;">
								<li>Máximo 3 cuentas en total por cliente</li>
								<li>Máximo 2 cuentas de ahorro por cliente</li>
								<li>Máximo 1 cuenta corriente por cliente</li>
								<li>El saldo inicial puede ser $0.00 o mayor</li>
							</ul>
						</div>
					</div>
				<%}%>

				<%if (cantidadCuentas != null && cantidadCuentas >= 3) {%>
					<div class="alert alert-warning">
						<strong>Límite alcanzado:</strong> Este cliente ya tiene el máximo de 3 cuentas permitidas. Para crear una nueva cuenta, primero debe eliminarse una cuenta existente.
					</div>
				<%}%>
			<%}%>

			<!-- Información adicional cuando no hay cliente seleccionado -->
			<%if (cliente == null && (mostrarBotonCrear == null || !(Boolean) mostrarBotonCrear)) {%>
				<div style="background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); text-align: center;">
					<h3 style="color: #6b7280; margin-bottom: 15px;">Buscar Cliente para Crear Cuenta</h3>
					<p style="color: #9ca3af; margin-bottom: 20px;">Utilice el formulario de búsqueda para encontrar un cliente existente o crear uno nuevo.</p>
					<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; max-width: 600px; margin: 0 auto;">
						<div style="padding: 20px; background: #f9fafb; border-radius: 8px;">
							<h4 style="color: #374151; margin-bottom: 10px;">Buscar por DNI</h4>
							<p style="color: #6b7280; font-size: 14px;">Ingrese el DNI del cliente para buscar sus datos y cuentas existentes.</p>
						</div>
						<div style="padding: 20px; background: #f9fafb; border-radius: 8px;">
							<h4 style="color: #374151; margin-bottom: 10px;">Buscar por Email</h4>
							<p style="color: #6b7280; font-size: 14px;">Ingrese el email del cliente para acceder a su información.</p>
						</div>
					</div>
				</div>
			<%}%>
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
    </script>

	<script>
function confirmarDesactivacion(idCuenta, numeroCuenta, clienteId) {
    if (confirm('¿Está seguro de que desea DESACTIVAR la cuenta ' + numeroCuenta + '?\n\n' +
               'DESACTIVAR significa:\n' +
               '✓ La cuenta se ocultará del cliente\n' +
               '✓ El cliente no podrá operar con ella\n' +
               '✓ El saldo se mantendrá intacto\n' +
               '✓ Como admin, podrás reactivarla después\n\n' +
               'Esta acción es REVERSIBLE.')) {
        
        enviarAccion('desactivarCuenta', idCuenta, clienteId);
    }
}

function confirmarEliminar(idCuenta, numeroCuenta, clienteId) {
    if (confirm('⚠️ ¿Está seguro de que desea ELIMINAR la cuenta ' + numeroCuenta + '?\n\n' +
               'ELIMINAR significa:\n' +
               '❌ La cuenta será marcada como eliminada\n' +
               '❌ No aparecerá más en las búsquedas del cliente\n' +
               '❌ El cliente no podrá acceder a ella\n' +
               '❌ Esta acción es DEFINITIVA\n\n' +
               '¿Continuar con la eliminación?')) {
        
        enviarAccion('darDeBajaCuenta', idCuenta, clienteId);
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