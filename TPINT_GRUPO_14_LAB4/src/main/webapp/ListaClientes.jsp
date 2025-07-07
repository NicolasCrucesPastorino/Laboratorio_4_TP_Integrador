<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista de Clientes - Admin</title>

<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        padding: 20px;
    }
    .container {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        border-radius: 10px 10px 0 0;
        margin: -30px -30px 30px -30px;
    }
    .btn-detalle {
        background-color: #007bff;
        color: white;
        padding: 5px 15px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        font-size: 12px;
    }
    .btn-detalle:hover {
        background-color: #0056b3;
        color: white;
        text-decoration: none;
    }
    .btn-volver {
        background-color: #6c757d;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        margin-bottom: 20px;
    }
    .btn-volver:hover {
        background-color: #545b62;
        color: white;
        text-decoration: none;
    }
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1 class="mb-0">📋 Lista de Clientes</h1>
        <p class="mb-0">Gestión de clientes del sistema bancario</p>
    </div>
    
    <a href="Admin" class="btn-volver">← Volver al Panel Admin</a>
    
    <div class="table-responsive">
        <table id="tablaClientes" class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>DNI</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Fecha Alta</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cliente" items="${clientes}">
                <tr>
                    <td>${cliente.id}</td>
                    <td>${cliente.nombre}</td>
                    <td>${cliente.apellido}</td>
                    <td>${cliente.DNI}</td>
                    <td>${cliente.correo}</td>
                    <td>${cliente.telefono}</td>
                    <td>
                        <fmt:formatDate value="${cliente.fecha_alta}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td>
                        <c:url var="detalleUrl" value="/Admin">
                            <c:param name="opcion" value="detalle" />
                            <c:param name="id" value="${cliente.id}" />
                        </c:url>
                        <a href="${detalleUrl}" class="btn-detalle">Ver Detalle</a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
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
        "pageLength": 5,
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
            // Mejorar el estilo de los botones después de cada redibujado
            $('.btn-detalle').hover(
                function() { $(this).css('background-color', '#0056b3'); },
                function() { $(this).css('background-color', '#007bff'); }
            );
        }
    });
});
</script>

</body>
</html>