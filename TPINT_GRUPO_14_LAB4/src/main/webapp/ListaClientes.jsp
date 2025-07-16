<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes - Admin Banking</title>
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
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

        .clients-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .section-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f3f4f6;
        }

        .section-title {
            color: #dc2626;
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }

        .section-subtitle {
            color: #6b7280;
            font-size: 16px;
            margin: 5px 0 0 0;
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

        .btn-detail {
            background: #3b82f6;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-detail:hover {
            background: #2563eb;
            color: white;
            text-decoration: none;
            transform: translateY(-1px);
        }

        .table-container {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: #f8fafc;
            color: #374151;
            font-weight: 600;
            border-bottom: 2px solid #e5e7eb;
            padding: 12px;
        }

        .table tbody td {
            padding: 12px;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }

        .table tbody tr:hover {
            background-color: #f9fafb;
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .status-active {
            background: #dcfce7;
            color: #166534;
        }

        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        /* DataTables customization */
        .dataTables_wrapper .dataTables_length select,
        .dataTables_wrapper .dataTables_filter input {
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 6px 8px;
        }

        .dataTables_wrapper .dataTables_filter input:focus {
            outline: none;
            border-color: #dc2626;
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .page-link {
            color: #dc2626;
        }

        .page-link:hover {
            color: #b91c1c;
            background-color: #fee2e2;
            border-color: #fecaca;
        }

        .page-item.active .page-link {
            background-color: #dc2626;
            border-color: #dc2626;
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
            <h1>🏦 Admin Banking - Gestión de Clientes</h1>
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



            <!-- Sección principal -->
            <div class="clients-section">
                <div class="section-header">
                    <div>
                        <h2 class="section-title">📋 Lista de Clientes</h2>
                        <p class="section-subtitle">Gestión completa de clientes del sistema bancario</p>
                    </div>
                </div>

                <div class="table-container">
                    <table id="tablaClientes" class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>DNI</th>
                                <th>Correo</th>
                                <th>Teléfono</th>
                                <th>Fecha Alta</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cliente" items="${clientes}">
                                <tr>
                                    <td><strong>#${cliente.id}</strong></td>
                                    <td>${cliente.nombre}</td>
                                    <td>${cliente.apellido}</td>
                                    <td>${cliente.DNI}</td>
                                    <td>${cliente.correo}</td>
                                    <td>${cliente.telefono}</td>
                                    <td>
                                        <fmt:formatDate value="${cliente.fecha_alta}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td>
                                        <span class="status-badge ${cliente.activo ? 'status-active' : 'status-inactive'}">
                                            ${cliente.activo ? 'Activo' : 'Inactivo'}
                                        </span>
                                    </td>
                                    <td>
                                        <form method="post" action="EditarCliente" style="margin: 0;">
                                            <input type="hidden" name="opcion" value="detalle">
                                            <input type="hidden" name="id" value="${cliente.id}">
                                            <button type="submit" class="btn-detail">
                                                👁️ Ver Detalle
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- DataTables JS -->
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#tablaClientes').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json"
                },
                "pageLength": 10,
                "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "Todos"]],
                "order": [[0, "desc"]],
                "columnDefs": [
                    {
                        "targets": [8],
                        "orderable": false
                    }
                ],
                "responsive": true,
                "dom": '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
                       '<"row"<"col-sm-12"tr>>' +
                       '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
                "drawCallback": function(settings) {
                    // Mejorar el estilo de los botones después de cada redibujado
                    $('.btn-detail').hover(
                        function() {
                            $(this).css('background-color', '#2563eb');
                        },
                        function() {
                            $(this).css('background-color', '#3b82f6');
                        }
                    );
                }
            });
        });
    </script>
</body>
</html>