<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Préstamos - Admin Banking</title>
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    
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

        .loans-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .section-header {
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
            font-size: 13px;
        }

        .table tbody td {
            padding: 12px;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
            font-size: 13px;
        }

        .table tbody tr:hover {
            background-color: #f9fafb;
        }

        .btn-aprobar {
            background: #16a34a;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            font-size: 12px;
            transition: all 0.3s ease;
        }

        .btn-aprobar:hover {
            background: #15803d;
            transform: translateY(-1px);
        }

        .btn-rechazar {
            background: #dc2626;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s ease;
        }

        .btn-rechazar:hover {
            background: #b91c1c;
            transform: translateY(-1px);
        }

        .estado-pendiente {
            background: #fef3c7;
            color: #92400e;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .client-info {
            font-weight: 500;
            color: #374151;
        }

        .loan-amount {
            font-weight: 600;
            color: #dc2626;
        }

        .loan-date {
            color: #6b7280;
            font-size: 12px;
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

        .action-buttons {
            display: flex;
            gap: 5px;
            flex-wrap: nowrap;
        }

        .no-data-message {
            text-align: center;
            padding: 40px;
            color: #6b7280;
            font-style: italic;
        }

        .loan-summary {
            background: #f9fafb;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #dc2626;
        }

        .summary-text {
            color: #374151;
            font-size: 14px;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="menu-title">MENÚ ADMIN</div>
        <a href="Admin" class="menu-item">Panel Principal</a>
        <a href="Admin?opcion=clientes" class="menu-item">Gestión de clientes</a>
        <a href="Admin?opcion=prestamos" class="menu-item active">Gestión de préstamos</a>
        <a href="ServletAltaCuentas" class="menu-item">Alta de cuentas</a>
        <a href="ServletAlta" class="menu-item">Alta de usuarios</a>
        <a href="ServletReportes?año=2025" class="menu-item">Reportes</a>
        <form action="ServletLogout" method="post" style="margin-top: auto;">
            <button type="submit" class="logout-btn">Cerrar sesión</button>
        </form>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>🏦 Admin Banking - Gestión de Préstamos</h1>
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

            <!-- Mensajes de éxito/error -->
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success">
                    ✅ ${mensaje}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ❌ ${error}
                </div>
            </c:if>

            <div class="loans-section">
                <div class="section-header">
                    <h2 class="section-title">💼 Solicitudes de Préstamos</h2>
                    <p class="section-subtitle">Autorización y seguimiento de préstamos pendientes</p>
                </div>

                <!-- Resumen -->
                <div class="loan-summary">
                    <p class="summary-text">
                        <strong>📋 Resumen:</strong> 
                        Revise las solicitudes pendientes y tome decisiones de aprobación o rechazo. 
                        Cada decisión impacta directamente en las cuentas de los clientes.
                    </p>
                </div>

                <div class="table-container">
                    <c:choose>
                        <c:when test="${not empty prestamosPendientes}">
                            <table id="tablaSolicitudes" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>N° Solicitud</th>
                                        <th>Cliente</th>
                                        <th>DNI</th>
                                        <th>Monto Solicitado</th>
                                        <th>Plazo</th>
                                        <th>Fecha Solicitud</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="prestamo" items="${prestamosPendientes}">
                                    <tr>
                                        <td><strong>#${prestamo.id}</strong></td>
                                        <td class="client-info">${prestamo.cliente.nombre} ${prestamo.cliente.apellido}</td>
                                        <td>${prestamo.cliente.DNI}</td>
                                        <td class="loan-amount">
                                            <fmt:formatNumber value="${prestamo.montoPedido}" type="currency" currencySymbol="$" />
                                        </td>
                                        <td>${prestamo.cantidadCuotas} meses</td>
                                        <td class="loan-date">
                                            <fmt:formatDate value="${prestamo.fechaPedido}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <span class="estado-pendiente">${prestamo.estado}</span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button type="button" class="btn-aprobar" onclick="aprobarPrestamo(${prestamo.id})">
                                                    ✅ Aprobar
                                                </button>
                                                <button type="button" class="btn-rechazar" onclick="rechazarPrestamo(${prestamo.id})">
                                                    ❌ Rechazar
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data-message">
                                <h4>📄 No hay solicitudes pendientes</h4>
                                <p>Todas las solicitudes de préstamos han sido procesadas.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
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

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        $(document).ready(function() {
            if ($('#tablaSolicitudes').length) {
                $('#tablaSolicitudes').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json"
                    },
                    "pageLength": 10,
                    "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "Todos"]],
                    "order": [[0, "desc"]],
                    "columnDefs": [
                        {
                            "targets": [7],
                            "orderable": false
                        }
                    ],
                    "responsive": true,
                    "dom": '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
                           '<"row"<"col-sm-12"tr>>' +
                           '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
                    "drawCallback": function(settings) {
                        // Actualizar estilos después de cada redibujado
                        $('.btn-aprobar').hover(
                            function() { $(this).css('background-color', '#15803d'); },
                            function() { $(this).css('background-color', '#16a34a'); }
                        );
                        $('.btn-rechazar').hover(
                            function() { $(this).css('background-color', '#b91c1c'); },
                            function() { $(this).css('background-color', '#dc2626'); }
                        );
                    }
                });
            }
        });

        function aprobarPrestamo(idPrestamo) {
            Swal.fire({
                title: '¿Está seguro?',
                text: "¿Desea aprobar este préstamo?",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#16a34a',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Sí, aprobar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Crear formulario para enviar datos
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'SolicitudesPrestamo';
                    
                    const inputAction = document.createElement('input');
                    inputAction.type = 'hidden';
                    inputAction.name = 'action';
                    inputAction.value = 'aprobar';
                    form.appendChild(inputAction);
                    
                    const inputId = document.createElement('input');
                    inputId.type = 'hidden';
                    inputId.name = 'idPrestamo';
                    inputId.value = idPrestamo;
                    form.appendChild(inputId);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }

        function rechazarPrestamo(idPrestamo) {
            Swal.fire({
                title: '¿Está seguro?',
                text: "¿Desea rechazar este préstamo?",
                icon: 'warning',
                input: 'textarea',
                inputPlaceholder: 'Motivo del rechazo (opcional)',
                showCancelButton: true,
                confirmButtonColor: '#dc2626',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Sí, rechazar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Crear formulario para enviar datos
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'SolicitudesPrestamo';
                    
                    const inputAction = document.createElement('input');
                    inputAction.type = 'hidden';
                    inputAction.name = 'action';
                    inputAction.value = 'rechazar';
                    form.appendChild(inputAction);
                    
                    const inputId = document.createElement('input');
                    inputId.type = 'hidden';
                    inputId.name = 'idPrestamo';
                    inputId.value = idPrestamo;
                    form.appendChild(inputId);
                    
                    const inputObservaciones = document.createElement('input');
                    inputObservaciones.type = 'hidden';
                    inputObservaciones.name = 'observaciones';
                    inputObservaciones.value = result.value || 'Sin observaciones';
                    form.appendChild(inputObservaciones);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }
    </script>
</body>
</html>