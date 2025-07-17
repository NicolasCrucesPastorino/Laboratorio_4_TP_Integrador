<%@ page import="java.util.List"%>
<%@ page import="entidad.Provincia"%>
<%@ page import="entidad.Localidad"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Alta de Clientes - Admin Banking</title>
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

.form-section {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	max-width: 900px;
	margin: 0 auto;
}

.section-header {
	text-align: center;
	margin-bottom: 30px;
	padding-bottom: 20px;
	border-bottom: 2px solid #f3f4f6;
}

.section-title {
	color: #dc2626;
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 10px;
}

.section-subtitle {
	color: #6b7280;
	font-size: 16px;
}

.alert {
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 20px;
	font-size: 14px;
}

.alert-success {
	background: #dcfce7;
	color: #166534;
	border: 1px solid #16a34a;
}

.alert-danger {
	background: #fee2e2;
	color: #991b1b;
	border: 1px solid #dc2626;
}

.form-container {
	background: #f9fafb;
	padding: 25px;
	border-radius: 8px;
	margin-bottom: 20px;
}

.form-group-title {
	color: #dc2626;
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 20px;
	border-bottom: 1px solid #e5e7eb;
	padding-bottom: 8px;
}

.form-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	font-weight: 600;
	color: #374151;
	margin-bottom: 8px;
	font-size: 14px;
}

.form-control {
	width: 100%;
	padding: 12px;
	border: 2px solid #e5e7eb;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.3s ease;
}

.form-control:focus {
	outline: none;
	border-color: #dc2626;
	box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
}

.form-control.full-width {
	grid-column: 1/-1;
}

.button-group {
	display: flex;
	gap: 15px;
	justify-content: center;
	margin-top: 30px;
}

.btn {
	padding: 12px 24px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s ease;
	text-align: center;
}

.btn-success {
	background: #16a34a;
	color: white;
}

.btn-success:hover {
	background: #15803d;
	transform: translateY(-2px);
}

.btn-danger {
	background: #dc2626;
	color: white;
}

.btn-danger:hover {
	background: #b91c1c;
	transform: translateY(-2px);
}

.required {
	color: #dc2626;
}

.form-note {
	background: #eff6ff;
	border: 1px solid #3b82f6;
	border-radius: 6px;
	padding: 12px;
	margin-bottom: 20px;
	font-size: 14px;
	color: #1e40af;
}

.password-strength {
	margin-top: 5px;
	font-size: 12px;
	color: #6b7280;
}

.grid-full {
	grid-column: 1/-1;
}

.two-column {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 15px;
}

@media ( max-width : 768px) {
	.form-grid {
		grid-template-columns: 1fr;
	}
	.two-column {
		grid-template-columns: 1fr;
	}
	.button-group {
		flex-direction: column;
		align-items: center;
	}
}
</style>
</head>
<body>

	<%
	List<Provincia> listaProv = null;
	if (request.getAttribute("listaProv") != null) {
		listaProv = (List<Provincia>) request.getAttribute("listaProv");
	}
	%>

	<div class="sidebar">
		<div class="menu-title">MENÚ ADMIN</div>
		<a href="Admin" class="menu-item">Panel Principal</a> <a
			href="Admin?opcion=clientes" class="menu-item">Gestión de
			clientes</a> <a href="Admin?opcion=prestamos" class="menu-item">Gestión
			de préstamos</a> <a href="ServletAltaCuentas" class="menu-item">Alta
			de cuentas</a> <a href="ServletAlta" class="menu-item active">Alta de
			usuarios</a> <a href="ServletReportes?año=2025" class="menu-item">Reportes</a>
		<form action="ServletLogout" method="post" style="margin-top: auto;">
			<button type="submit" class="logout-btn">Cerrar sesión</button>
		</form>
	</div>

	<div class="main-content">
		<div class="header">
			<h1>🏦 Admin Banking - Alta de Usuarios</h1>
			<div class="admin-info">
				<span>👤 ${sessionScope.usuarioLogueado.usuario}</span> <span>Admin</span>
			</div>
		</div>

		<div class="content-area">
			<!-- Botón volver -->
			<a href="Admin" class="btn-back"> ← Volver al Panel Principal </a>

			<div class="form-section">
				<div class="section-header">
					<h2 class="section-title">👤 Registro de Nuevo Cliente</h2>
					<p class="section-subtitle">Complete el formulario para crear
						un nuevo cliente y su cuenta bancaria</p>
				</div>

				<!-- Mensajes de éxito/error -->
				<%
				if (request.getAttribute("exito") != null) {
				%>
				<div class="alert alert-success">✅ Cliente y cuenta creados
					exitosamente. El cliente puede acceder al sistema.</div>
				<%
				}
				%>

				<%
				String error = request.getParameter("error");
				if (error != null) {
					String mensaje = "";
					switch (error) {
						case "clavesnocoinciden" :
					mensaje = "Las contraseñas no coinciden. Verifique e intente nuevamente.";
					break;
						case "nombredeusuarioyaexiste" :
					mensaje = "El nombre de usuario ya existe. Elija otro nombre de usuario.";
					break;
						case "DNIyausado" :
					mensaje = "El DNI ya está registrado en el sistema.";
					break;
						default :
					mensaje = "Error en el registro. Verifique los datos e intente nuevamente.";
					}
				%>
				<div class="alert alert-danger">
					❌
					<%=mensaje%>
				</div>
				<%
				}
				%>

				<div class="form-note">
					<strong>💡 Información importante:</strong> Al crear un cliente se
					generará automáticamente su primera cuenta bancaria con saldo
					inicial de $10.000
				</div>

				<!-- FORMULARIO DE ALTA DE USUARIOS -->
				<form method="post" action="ServletAlta">

					<!-- Sección: Datos de Acceso -->
					<div class="form-container">
						<h3 class="form-group-title">🔐 Datos de Acceso al Sistema</h3>

						<div class="form-grid">
							<div class="form-group">
								<label for="usuario" class="form-label">Usuario <span
									class="required">*</span></label> <input type="text" id="usuario"
									name="usuario" class="form-control" required
									placeholder="Nombre de usuario único">
							</div>

							<div class="form-group">
								<label for="tipoUsuario" class="form-label">Tipo de
									usuario <span class="required">*</span>
								</label> <select id="tipoUsuario" name="tipoUsuario"
									class="form-control" required>
									<option value="">Seleccione</option>
									<option value="admin">Administrador</option>
									<option value="cliente">Cliente</option>
								</select>
							</div>
						</div>

						<div class="two-column">
							<div class="form-group">
								<label for="password" class="form-label">Contraseña <span
									class="required">*</span></label> <input id="password" type="password"
									name="password" class="form-control" required
									placeholder="Mínimo 6 caracteres">
								<div class="password-strength">Mínimo 6 caracteres, use
									letras y números</div>
							</div>
							<div class="form-group">
								<label for="password2" class="form-label">Repetir
									Contraseña <span class="required">*</span>
								</label> <input id="password2" type="password" name="password2"
									class="form-control" required
									placeholder="Confirme la contraseña">
							</div>
						</div>
					</div>

					<!-- Sección: Información Personal -->
					<div class="form-container">
						<h3 class="form-group-title">📋 Información Personal</h3>

						<div class="form-grid">
							<div class="form-group">
								<label for="nombre" class="form-label">Nombre <span
									class="required">*</span></label> <input type="text" id="nombre"
									name="nombre" class="form-control" required
									placeholder="Nombre del cliente">
							</div>
							<div class="form-group">
								<label for="apellido" class="form-label">Apellido <span
									class="required">*</span></label> <input type="text" id="apellido"
									name="apellido" class="form-control" required
									placeholder="Apellido del cliente">
							</div>
							<div class="form-group">
								<label for="dni" class="form-label">DNI <span
									class="required">*</span></label> <input type="text" id="dni"
									name="dni" class="form-control" required
									placeholder="Documento sin puntos">
							</div>
							<div class="form-group">
								<label for="genero" class="form-label">Género <span
									class="required">*</span></label> <select id="genero" name="genero"
									class="form-control" required>
									<option value="">Seleccione</option>
									<option value="masculino">Masculino</option>
									<option value="femenino">Femenino</option>
									<option value="indefinido">Indefinido</option>
								</select>
							</div>
							<div class="form-group">
								<label for="nacionalidad" class="form-label">Nacionalidad
									<span class="required">*</span>
								</label> <input type="text" id="nacionalidad" name="nacionalidad"
									class="form-control" required placeholder="Ej: Argentina"
									value="Argentina">
							</div>
							<div class="form-group">
								<label for="fechanac" class="form-label">Fecha de
									nacimiento <span class="required">*</span>
								</label> <input type="date" id="fechanac" name="fechanac"
									class="form-control" required>
							</div>
						</div>
					</div>

					<!-- Sección: Ubicación -->
					<div class="form-container">
						<h3 class="form-group-title">📍 Datos de Ubicación</h3>

						<div class="form-group grid-full">
							<label for="direccion" class="form-label">Dirección <span
								class="required">*</span></label> <input type="text" id="direccion"
								name="direccion" class="form-control" required
								placeholder="Calle, número, piso, departamento">
						</div>

						<div class="form-grid">
							<div class="form-group">
								<label for="provincia" class="form-label">Provincia <span
									class="required">*</span></label> <select id="provincia"
									name="provincia" class="form-control" required
									onchange="window.location.href='ServletAlta?provincia=' + this.value">
									<option value="">Seleccione</option>
									<%
									if (listaProv != null)
										for (Provincia prov : listaProv) {
									%>
									<option value="<%=prov.getId()%>"
										<%=(request.getParameter("provincia") != null
		&& Integer.parseInt(request.getParameter("provincia")) == prov.getId()) ? "selected" : ""%>>
										<%=prov.getNombre()%>
									</option>
									<%
									}
									%>
								</select>
							</div>

							<div class="form-group">
								<label for="localidad" class="form-label">Localidad <span
									class="required">*</span></label> <select id="localidad"
									name="localidad" class="form-control" required>
									<option value="">Seleccione primero una provincia</option>
									<%
									List<Localidad> listaLoc = (List<Localidad>) request.getAttribute("listaLoc");
									if (listaLoc != null) {
										for (Localidad loc : listaLoc) {
									%>
									<option value="<%=loc.getNombre()%>"><%=loc.getNombre()%></option>
									<%
									}
									}
									%>
								</select>
							</div>
						</div>
					</div>

					<!-- Sección: Contacto -->
					<div class="form-container">
						<h3 class="form-group-title">📞 Datos de Contacto</h3>

						<div class="form-grid">
							<div class="form-group">
								<label for="correo" class="form-label">Correo
									Electrónico <span class="required">*</span>
								</label> <input type="email" id="correo" name="correo"
									class="form-control" required placeholder="usuario@ejemplo.com">
							</div>
							<div class="form-group">
								<label for="telefono" class="form-label">Teléfono <span
									class="required">*</span></label> <input type="tel" id="telefono"
									name="telefono" class="form-control" required
									placeholder="Código de área + número">
							</div>
						</div>
					</div>

					<div class="button-group">
						<button type="submit" name="alta" value="altaUsuario"
							class="btn btn-success">✅ Crear Cliente</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		// Validación en tiempo real
		document.getElementById('password2').addEventListener('input',
				function() {
					const password = document.getElementById('password').value;
					const password2 = this.value;

					if (password2 && password !== password2) {
						this.style.borderColor = '#dc2626';
					} else {
						this.style.borderColor = '#e5e7eb';
					}
				});

		// Validar DNI (solo números)
		document.getElementById('dni').addEventListener('input', function() {
			this.value = this.value.replace(/\D/g, '');
		});

		// Validar teléfono (solo números y algunos caracteres)
		document.getElementById('telefono').addEventListener('input',
				function() {
					this.value = this.value.replace(/[^0-9\-\(\)\+\s]/g, '');
				});

		// Confirmación antes de enviar
		document
				.querySelector('form')
				.addEventListener(
						'submit',
						function(e) {
							const password = document
									.getElementById('password').value;
							const password2 = document
									.getElementById('password2').value;

							if (password !== password2) {
								e.preventDefault();
								alert('Las contraseñas no coinciden. Por favor, verifique.');
								return false;
							}

							if (password.length < 6) {
								e.preventDefault();
								alert('La contraseña debe tener al menos 6 caracteres.');
								return false;
							}

							return confirm('¿Está seguro de crear este cliente? Se generará automáticamente su primera cuenta bancaria.');
						});
	</script>
</body>
</html>