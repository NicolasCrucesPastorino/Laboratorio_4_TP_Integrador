<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidad.Cliente"%>

<%
Cliente cliente = (Cliente) request.getAttribute("cliente");
String editar = (String) request.getAttribute("editar");
boolean puedeEditar = editar != null && editar.equals("si");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Información Personal - Admin Banking</title>
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

        .info-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 800px;
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

        .client-name {
            color: #6b7280;
            font-size: 18px;
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

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-group {
            background: #f9fafb;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #dc2626;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 8px 0;
        }

        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            font-weight: 600;
            color: #374151;
            flex: 0 0 120px;
        }

        .info-value {
            color: #6b7280;
            flex: 1;
            text-align: right;
        }

        /* Estilos para formulario de edición */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
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

        .form-section {
            background: #f9fafb;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .form-section-title {
            color: #dc2626;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 15px;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 8px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
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

        .btn-primary {
            background: #dc2626;
            color: white;
        }

        .btn-primary:hover {
            background: #b91c1c;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
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

        .btn-secondary {
            background: #6b7280;
            color: white;
        }

        .btn-secondary:hover {
            background: #4b5563;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="menu-title">MENÚ ADMIN</div>
        <a href="Admin" class="menu-item">Panel Principal</a>
        <a href="Admin?opcion=clientes" class="menu-item active">Gestión de clientes</a>
        <a href="Admin?opcion=prestamos" class="menu-item">Gestión de préstamos</a>
        <a href="ServletAltaCuentas" class="menu-item">Alta de cuentas</a>
        <a href="ServletAlta" class="menu-item">Alta de usuarios</a>
        <a href="ServletReportes?año=2025" class="menu-item">Reportes</a>
        <form action="ServletLogout" method="post" style="margin-top: auto;">
            <button type="submit" class="logout-btn">Cerrar sesión</button>
        </form>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>🏦 Admin Banking - Información del Cliente</h1>
            <div class="admin-info">
                <span>👤 ${sessionScope.usuarioLogueado.usuario}</span>
                <span>Admin</span>
            </div>
        </div>

        <div class="content-area">
            <!-- Botón volver -->
            <a href="Admin?opcion=clientes" class="btn-back">
                ← Volver a Lista de Clientes
            </a>

            <!-- Mensaje de éxito si existe -->
            <%
            String baja = request.getParameter("baja");
            if ("ok".equals(baja)) {
            %>
            <div class="alert alert-success">
                ✅ El cliente fue dado de baja exitosamente.
            </div>
            <%
            }
            %>

            <div class="info-section">
                <div class="section-header">
                    <h2 class="section-title">
                        <%= puedeEditar ? "✏️ Editar Cliente" : "👤 Información Personal" %>
                    </h2>
                    <% if (cliente != null) { %>
                    <p class="client-name">
                        <%= cliente.getNombre() %> <%= cliente.getApellido() %> 
                        <small>(ID: #<%= cliente.getId() %>)</small>
                    </p>
                    <% } %>
                </div>

                <% if (!puedeEditar) { %>
                <!-- MODO SOLO LECTURA -->
                <div class="info-grid">
                    <div class="info-group">
                        <h3 class="form-section-title">📋 Datos Personales</h3>
                        <div class="info-row">
                            <span class="info-label">Nombre:</span>
                            <span class="info-value"><%= cliente.getNombre() %></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Apellido:</span>
                            <span class="info-value"><%= cliente.getApellido() %></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">DNI:</span>
                            <span class="info-value"><%= cliente.getDNI() %></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Género:</span>
                            <span class="info-value"><%= cliente.getGenero() %></span>
                        </div>
                    </div>

                    <div class="info-group">
                        <h3 class="form-section-title">📍 Ubicación</h3>
                        <div class="info-row">
                            <span class="info-label">Provincia:</span>
                            <span class="info-value"><%= cliente.getProvincia().getNombre() %></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Localidad:</span>
                            <span class="info-value"><%= cliente.getLocalidad().getNombre() %></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Dirección:</span>
                            <span class="info-value"><%= cliente.getDireccion() %></span>
                        </div>
                    </div>

                    <div class="info-group">
                        <h3 class="form-section-title">📞 Contacto</h3>
                        <div class="info-row">
                            <span class="info-label">Correo:</span>
                            <span class="info-value"><%= cliente.getCorreo() %></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Teléfono:</span>
                            <span class="info-value"><%= cliente.getTelefono() %></span>
                        </div>
                    </div>
                </div>

                <div class="button-group">
                    <a href="EditarCliente?id=<%= cliente.getId() %>" class="btn btn-primary">
                        ✏️ Editar Cliente
                    </a>
                </div>

                <% } else { %>
                <!-- MODO EDICIÓN -->
                <form method="post" action="EditarCliente">
                    <input type="hidden" name="opcion" value="actualizar">
                    <input type="hidden" name="id" value="<%= cliente.getId() %>">

                    <div class="form-section">
                        <h3 class="form-section-title">📋 Datos Personales</h3>
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">Nombre:</label>
                                <input type="text" name="nombre" class="form-control" 
                                       value="<%= cliente.getNombre() %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Apellido:</label>
                                <input type="text" name="apellido" class="form-control" 
                                       value="<%= cliente.getApellido() %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">DNI:</label>
                                <input type="text" name="dni" class="form-control" 
                                       value="<%= cliente.getDNI() %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Género:</label>
                                <input type="text" name="genero" class="form-control" 
                                       value="<%= cliente.getGenero() %>" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="form-section-title">📍 Ubicación</h3>
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">Provincia (ID):</label>
                                <input type="text" name="provincia" class="form-control" 
                                       value="<%= cliente.getProvincia().getId() %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Localidad (ID):</label>
                                <input type="text" name="localidad" class="form-control" 
                                       value="<%= cliente.getLocalidad().getId() %>" required>
                            </div>
                            <div class="form-group" style="grid-column: 1 / -1;">
                                <label class="form-label">Dirección:</label>
                                <input type="text" name="direccion" class="form-control" 
                                       value="<%= cliente.getDireccion() %>" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="form-section-title">📞 Contacto</h3>
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">Correo Electrónico:</label>
                                <input type="email" name="correo" class="form-control" 
                                       value="<%= cliente.getCorreo() %>" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Teléfono:</label>
                                <input type="text" name="telefono" class="form-control" 
                                       value="<%= cliente.getTelefono() %>" required>
                            </div>
                        </div>
                    </div>

                    <div class="button-group">
                        <a href="Admin?opcion=detalle&id=<%= cliente.getId() %>&editar=no" 
                           class="btn btn-secondary">
                            ❌ Cancelar
                        </a>
                        <input type="submit" name="accion" value="Guardar Cambios" 
                               class="btn btn-success">
                        <input type="submit" name="accion" value="Dar de baja" 
                               class="btn btn-danger" 
                               onclick="return confirm('¿Está seguro de dar de baja este cliente?')">
                    </div>
                </form>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>