<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Admin Banking</title>
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

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .dashboard-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .dashboard-card h2 {
            color: #dc2626;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .dashboard-card p {
            color: #6b7280;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .btn-primary {
            background: #dc2626;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            width: 100%;
        }

        .btn-primary:hover {
            background: #b91c1c;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .stats-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .stat-item {
            text-align: center;
            padding: 20px;
            background: #f9fafb;
            border-radius: 8px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #dc2626;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #6b7280;
            font-size: 14px;
        }

        .quick-actions {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .quick-actions h2 {
            color: #dc2626;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="menu-title">MENÚ ADMIN</div>
        <a href="Admin" class="menu-item active">Panel Principal</a>
        <a href="Admin?opcion=clientes" class="menu-item">Gestión de clientes</a>
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
            <h1>🏦 Admin Banking - Panel Principal</h1>
            <div class="admin-info">
                <span>👤 ${sessionScope.usuarioLogueado.usuario}</span>
                <span>Admin</span>
            </div>
        </div>

        <div class="content-area">
            <!-- Estadísticas del sistema -->
            <div class="stats-section">
                <h2>📊 Resumen del Sistema</h2>
                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-number">1,247</div>
                        <div class="stat-label">Clientes Activos</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">3,891</div>
                        <div class="stat-label">Cuentas Totales</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">157</div>
                        <div class="stat-label">Préstamos Pendientes</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">$2.4M</div>
                        <div class="stat-label">Total en Sistema</div>
                    </div>
                </div>
            </div>

            <!-- Acciones principales -->
            <div class="dashboard-grid">
                <div class="dashboard-card">
                    <h2>👥 Gestión de Clientes</h2>
                    <p>Administra los clientes del sistema bancario. Consulta información, edita datos y gestiona estados de cuenta.</p>
                    <a href="Admin?opcion=clientes" class="btn-primary">Ver Clientes</a>
                </div>

                <div class="dashboard-card">
                    <h2>🏦 Alta de Cuentas</h2>
                    <p>Crea nuevas cuentas bancarias para clientes existentes. Configura tipos de cuenta y saldos iniciales.</p>
                    <a href="ServletAltaCuentas" class="btn-primary">Crear Cuentas</a>
                </div>

                <div class="dashboard-card">
                    <h2>👤 Alta de Usuarios</h2>
                    <p>Registra nuevos clientes en el sistema. Configura credenciales y datos personales completos.</p>
                    <a href="ServletAlta" class="btn-primary">Crear Usuarios</a>
                </div>

                <div class="dashboard-card">
                    <h2>💰 Gestión de Préstamos</h2>
                    <p>Revisa y gestiona las solicitudes de préstamos. Aprueba o rechaza solicitudes pendientes.</p>
                    <a href="Admin?opcion=prestamos" class="btn-primary">Ver Solicitudes</a>
                </div>

                <div class="dashboard-card">
                    <h2>📈 Reportes del Sistema</h2>
                    <p>Genera reportes estadísticos del sistema. Analiza rendimiento y métricas del banco.</p>
                    <a href="ServletReportes?año=2025" class="btn-primary">Ver Reportes</a>
                </div>

                <div class="dashboard-card">
                    <h2>⚙️ Configuración</h2>
                    <p>Configura parámetros del sistema y ajustes generales de la aplicación bancaria.</p>
                    <a href="#" class="btn-primary">Configurar</a>
                </div>
            </div>

            <!-- Acciones rápidas -->
            <div class="quick-actions">
                <h2>⚡ Acciones Rápidas</h2>
                <div class="action-buttons">
                    <a href="ServletAlta" class="btn-primary">+ Nuevo Cliente</a>
                    <a href="ServletAltaCuentas" class="btn-primary">+ Nueva Cuenta</a>
                    <a href="Admin?opcion=prestamos" class="btn-primary">Préstamos Pendientes</a>
                    <a href="Admin?opcion=clientes" class="btn-primary">Buscar Cliente</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>