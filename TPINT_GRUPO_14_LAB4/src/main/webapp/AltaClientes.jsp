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
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.header h1 {
	font-size: 24px;
	font-weight: bold;
}

.admin-info {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	gap: 4px;
	font-size: 14px;
}

.content-area {
	flex: 1;
	padding: 30px;
	overflow-y: auto;
}

.btn-back {
	display: inline-block;
	background: #dc2626;
	color: white;
	padding: 10px 20px;
	text-decoration: none;
	border-radius: 6px;
	margin-bottom: 20px;
	transition: all 0.3s ease;
	font-weight: 500;
}

.btn-back:hover {
	background: #b91c1c;
	transform: translateY(-2px);
}

.form-section {
	background: white;
	border-radius: 15px;
	padding: 30px;
	box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
	max-width: 900px;
	margin: 0 auto;
}

.section-header {
	text-align: center;
	margin-bottom: 30px;
}

.section-title {
	color: #1f2937;
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 8px;
}

.section-subtitle {
	color: #6b7280;
	font-size: 16px;
}

.form-container {
	margin-bottom: 30px;
	padding: 25px;
	border: 2px solid #f3f4f6;
	border-radius: 12px;
	background: #fafafa;
}

.form-group-title {
	color: #dc2626;
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 20px;
	padding-bottom: 8px;
	border-bottom: 2px solid #dc2626;
}

.form-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
}

.grid-full {
	grid-column: 1/-1;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-label {
	color: #374151;
	font-weight: 600;
	margin-bottom: 6px;
	font-size: 14px;
}

.required {
	color: #dc2626;
}

.form-control {
	padding: 12px;
	border: 2px solid #e5e7eb;
	border-radius: 8px;
	font-size: 16px;
	transition: all 0.3s ease;
	background: white;
}

.form-control:focus {
	outline: none;
	border-color: #dc2626;
	box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
}

.button-group {
	text-align: center;
	margin-top: 30px;
}

.btn {
	padding: 15px 30px;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	text-decoration: none;
	display: inline-block;
}

.btn-success {
	background: #16a34a;
	color: white;
}

.btn-success:hover {
	background: #15803d;
	transform: translateY(-2px);
}

.alert {
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 20px;
	font-weight: 500;
}

.alert-success {
	background: #dcfce7;
	color: #166534;
	border: 1px solid #bbf7d0;
}

.alert-danger {
	background: #fee2e2;
	color: #991b1b;
	border: 1px solid #fecaca;
}

@media ( max-width : 768px) {
	body {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		height: auto;
		padding: 15px;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.content-area {
		padding: 15px;
	}
	.form-section {
		padding: 20px;
	}
	.header {
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

	// Obtener datos preservados del formulario
	java.util.Map<String, String> datos = (java.util.Map<String, String>) request.getAttribute("datosFormulario");
	if (datos == null) {
		datos = new java.util.HashMap<>();
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
				
				<%
				String tipo = (String) request.getAttribute("tipoMensaje");
				String Mensaje = (String) request.getAttribute("mensaje");
				if (Mensaje != null && tipo != null) {
				%>
				<div class="<%=tipo.equals("error") ? "error" : "exito"%>">
					<%=Mensaje%>
				</div>
				<%
				}
				%>

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
					<%=mensaje%></div>
				<%
				}
				%>

				<!-- Formulario -->
				<form action="ServletAlta" method="post">
					<!-- Sección: Datos de Usuario -->
					<div class="form-container">
						<h3 class="form-group-title">👤 Datos de Usuario</h3>

						<div class="form-grid">
							<div class="form-group">
								<label for="usuario" class="form-label">Nombre de
									usuario <span class="required">*</span>
								</label> <input type="text" id="usuario" name="usuario"
									class="form-control"
									value="<%=datos.get("usuario") != null ? datos.get("usuario") : ""%>"
									required placeholder="Nombre de usuario único">
							</div>
							<div class="form-group">
								<label for="tipoUsuario" class="form-label">Tipo de
									usuario <span class="required">*</span>
								</label> <select id="tipoUsuario" name="tipoUsuario"
									class="form-control" required>
									<option value="Cliente"
										<%="Cliente".equals(datos.get("tipoUsuario")) ? "selected" : ""%>>Cliente</option>
									<option value="Administrador"
										<%="Administrador".equals(datos.get("tipoUsuario")) ? "selected" : ""%>>Administrador</option>
								</select>
							</div>
							<div class="form-group">
								<label for="password" class="form-label">Contraseña <span
									class="required">*</span></label> <input type="password" id="password"
									name="password" class="form-control"
									value="<%=datos.get("password") != null ? datos.get("password") : ""%>"
									required placeholder="Mínimo 6 caracteres">
							</div>
							<div class="form-group">
								<label for="password2" class="form-label">Confirmar
									contraseña <span class="required">*</span>
								</label> <input type="password" id="password2" name="password2"
									class="form-control"
									value="<%=datos.get("password2") != null ? datos.get("password2") : ""%>"
									required placeholder="Repita la contraseña">
							</div>
						</div>
					</div>

					<!-- Sección: Datos Personales -->
					<div class="form-container">
						<h3 class="form-group-title">🆔 Datos Personales</h3>

						<div class="form-grid">
							<div class="form-group">
								<label for="nombre" class="form-label">Nombre <span
									class="required">*</span></label> <input type="text" id="nombre"
									name="nombre" class="form-control"
									value="<%=datos.get("nombre") != null ? datos.get("nombre") : ""%>"
									required placeholder="Nombre completo">
							</div>
							<div class="form-group">
								<label for="apellido" class="form-label">Apellido <span
									class="required">*</span></label> <input type="text" id="apellido"
									name="apellido" class="form-control"
									value="<%=datos.get("apellido") != null ? datos.get("apellido") : ""%>"
									required placeholder="Apellido completo">
							</div>
							<div class="form-group">
								<label for="dni" class="form-label">DNI <span
									class="required">*</span></label> <input type="text" id="dni"
									name="dni" class="form-control"
									value="<%=datos.get("dni") != null ? datos.get("dni") : ""%>"
									required placeholder="Solo números, sin puntos">
							</div>
							<div class="form-group">
								<label for="genero" class="form-label">Género <span
									class="required">*</span></label> <select id="genero" name="genero"
									class="form-control" required>
									<option value="">Seleccione</option>
									<option value="Masculino"
										<%="Masculino".equals(datos.get("genero")) ? "selected" : ""%>>Masculino</option>
									<option value="Femenino"
										<%="Femenino".equals(datos.get("genero")) ? "selected" : ""%>>Femenino</option>
									<option value="Otro"
										<%="Otro".equals(datos.get("genero")) ? "selected" : ""%>>Otro</option>
								</select>
							</div>
							<div class="form-group">
								<label for="nacionalidad" class="form-label">Nacionalidad
									<span class="required">*</span>
								</label> <input type="text" id="nacionalidad" name="nacionalidad"
									class="form-control"
									value="<%=datos.get("nacionalidad") != null && !datos.get("nacionalidad").isEmpty()
		? datos.get("nacionalidad")
		: "Argentina"%>"
									required placeholder="Ej: Argentina">
							</div>
							<div class="form-group">
								<label for="fechanac" class="form-label">Fecha de
									nacimiento <span class="required">*</span>
								</label> <input type="date" id="fechanac" name="fechanac"
									class="form-control"
									value="<%=datos.get("fechanac") != null ? datos.get("fechanac") : ""%>"
									required>
							</div>
						</div>
					</div>

					<!-- Sección: Ubicación -->
					<div class="form-container">
						<h3 class="form-group-title">📍 Datos de Ubicación</h3>

						<div class="form-group grid-full">
							<label for="direccion" class="form-label">Dirección <span
								class="required">*</span></label> <input type="text" id="direccion"
								name="direccion" class="form-control"
								value="<%=datos.get("direccion") != null ? datos.get("direccion") : ""%>"
								required placeholder="Calle, número, piso, departamento">
						</div>

						<div class="form-grid">
							<div class="form-group">
								<label for="provincia" class="form-label">Provincia <span
									class="required">*</span></label> <select id="provincia"
									name="provincia" class="form-control" required
									onchange="enviarFormularioConProvincia(this.value)">
									<option value="">Seleccione</option>
									<%
									if (listaProv != null) {
										String provinciaSeleccionada = request.getParameter("provincia");
										for (Provincia prov : listaProv) {
									%>
									<option value="<%=prov.getId()%>"
										<%=(provinciaSeleccionada != null && Integer.parseInt(provinciaSeleccionada) == prov.getId()) ? "selected" : ""%>>
										<%=prov.getNombre()%>
									</option>
									<%
									}
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
									class="form-control"
									value="<%=datos.get("correo") != null ? datos.get("correo") : ""%>"
									required placeholder="usuario@ejemplo.com">
							</div>
							<div class="form-group">
								<label for="telefono" class="form-label">Teléfono <span
									class="required">*</span></label> <input type="tel" id="telefono"
									name="telefono" class="form-control"
									value="<%=datos.get("telefono") != null ? datos.get("telefono") : ""%>"
									required placeholder="Código de área + número">
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
		// Función para enviar formulario con provincia y preservar TODOS los datos
		function enviarFormularioConProvincia(provinciaId) {
			if (!provinciaId)
				return;

			// Obtener todos los valores del formulario ANTES de la redirección
			var url = 'ServletAlta?provincia=' + provinciaId;

			// Capturar manualmente cada campo del formulario
			var usuario = document.getElementById('usuario').value;
			var password = document.getElementById('password').value;
			var password2 = document.getElementById('password2').value;
			var tipoUsuario = document.getElementById('tipoUsuario').value;
			var nombre = document.getElementById('nombre').value;
			var apellido = document.getElementById('apellido').value;
			var dni = document.getElementById('dni').value;
			var genero = document.getElementById('genero').value;
			var nacionalidad = document.getElementById('nacionalidad').value;
			var fechanac = document.getElementById('fechanac').value;
			var direccion = document.getElementById('direccion').value;
			var correo = document.getElementById('correo').value;
			var telefono = document.getElementById('telefono').value;

			// Agregar cada campo como parámetro si tiene valor
			if (usuario)
				url += '&usuario=' + encodeURIComponent(usuario);
			if (password)
				url += '&password=' + encodeURIComponent(password);
			if (password2)
				url += '&password2=' + encodeURIComponent(password2);
			if (tipoUsuario)
				url += '&tipoUsuario=' + encodeURIComponent(tipoUsuario);
			if (nombre)
				url += '&nombre=' + encodeURIComponent(nombre);
			if (apellido)
				url += '&apellido=' + encodeURIComponent(apellido);
			if (dni)
				url += '&dni=' + encodeURIComponent(dni);
			if (genero)
				url += '&genero=' + encodeURIComponent(genero);
			if (nacionalidad)
				url += '&nacionalidad=' + encodeURIComponent(nacionalidad);
			if (fechanac)
				url += '&fechanac=' + encodeURIComponent(fechanac);
			if (direccion)
				url += '&direccion=' + encodeURIComponent(direccion);
			if (correo)
				url += '&correo=' + encodeURIComponent(correo);
			if (telefono)
				url += '&telefono=' + encodeURIComponent(telefono);

			// Redirigir con todos los datos
			window.location.href = url;
		}

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