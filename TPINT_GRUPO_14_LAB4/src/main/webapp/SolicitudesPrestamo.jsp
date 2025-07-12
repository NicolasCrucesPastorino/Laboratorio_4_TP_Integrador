<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Préstamos</title>
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
        }
        .sidebar {
            width: 200px;
            background-color: #333;
            color: white;
            padding: 20px;
            height: 100vh;
            position: fixed;
        }
        .sidebar .logo {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold;
        }
        .sidebar .menu a {
            display: block;
            color: white;
            padding: 10px;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .sidebar .menu a:hover {
            background-color: #575757;
        }
        .main-content {
            flex-grow: 1;
            padding: 40px;
            margin-left: 200px;
        }
        .container {
            width: 100%;
            max-width: 1200px;
            padding: 20px;
            background: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 20px;
            border-radius: 10px 10px 0 0;
            margin: -20px -20px 30px -20px;
        }
        .btn-aprobar {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            font-size: 12px;
        }
        .btn-aprobar:hover {
            background-color: #218838;
        }
        .btn-rechazar {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .btn-rechazar:hover {
            background-color: #c82333;
        }
        .estado-pendiente {
            background-color: #fff3cd;
            color: #856404;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: bold;
        }
        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo">BANCO-ADMIN</div>
    <div class="menu">
        <a href="ServletAdmin">Panel Principal</a>
        <a href="Admin?opcion=listar">Clientes</a>
        <a href="Admin?opcion=cuentas">Cuentas</a>
        <a href="SolicitudesPrestamo">Solicitudes de Préstamos</a>
        <a href="Admin?opcion=reportes">Reportes</a>
    </div>
</div>

<div class="main-content">
    <div class="container">
        <div class="header">
            <h1 class="mb-0">💼 Gestión de Solicitudes de Préstamos</h1>
            <p class="mb-0">Autorización y seguimiento de préstamos</p>
        </div>

        <!-- Mensajes de éxito/error -->
        <c:if test="${not empty mensaje}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="table-responsive">
            <table id="tablaSolicitudes" class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>N° Solicitud</th>
                        <th>Cliente</th>
                        <th>DNI</th>
                        <th>Monto Solicitado</th>
                        <th>Plazo (meses)</th>
                        <th>Fecha Solicitud</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="prestamo" items="${prestamosPendientes}">
                    <tr>
                        <td>${prestamo.id}</td>
                        <td>${prestamo.cliente.nombre} ${prestamo.cliente.apellido}</td>
                        <td>${prestamo.cliente.DNI}</td>
                        <td>
                            <fmt:formatNumber value="${prestamo.montoPedido}" type="currency" currencySymbol="$" />
                        </td>
                        <td>${prestamo.cantidadCuotas}</td>
                        <td>
                            <fmt:formatDate value="${prestamo.fechaPedido}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td>
                            <span class="estado-pendiente">${prestamo.estado}</span>
                        </td>
                        <td>
                            <button type="button" class="btn-aprobar" onclick="aprobarPrestamo(${prestamo.id})">
                                Aprobar
                            </button>
                            <button type="button" class="btn-rechazar" onclick="rechazarPrestamo(${prestamo.id})">
                                Rechazar
                            </button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
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
                function() { $(this).css('background-color', '#218838'); },
                function() { $(this).css('background-color', '#28a745'); }
            );
            $('.btn-rechazar').hover(
                function() { $(this).css('background-color', '#c82333'); },
                function() { $(this).css('background-color', '#dc3545'); }
            );
        }
    });
});

function aprobarPrestamo(idPrestamo) {
    Swal.fire({
        title: '¿Está seguro?',
        text: "¿Desea aprobar este préstamo?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#6c757d',
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
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
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