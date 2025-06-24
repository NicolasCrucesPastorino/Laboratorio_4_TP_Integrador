<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Préstamos</title>
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
        }
        .container {
            width: 100%;
            max-width: 1200px;
            padding: 20px;
            background: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .filtros-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #e9ecef;
            border-radius: 5px;
            align-items: flex-end;
        }
        .filtros-container .form-group {
            display: flex;
            flex-direction: column;
        }
        .filtros-container label {
            margin-bottom: 5px;
            font-size: 14px;
        }
        .filtros-container input[type="text"], .filtros-container input[type="date"] {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .solicitudes-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .solicitudes-table th, .solicitudes-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .solicitudes-table th {
            background-color: #dc3545;
            color: white;
        }
        .solicitudes-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .btn-aprobar {
            padding: 5px 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 5px;
        }
        .btn-rechazar {
             padding: 5px 10px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo">BANCO-ADMIN</div>
    <div class="menu">
        <a href="#">Clientes</a>
        <a href="#">Cuentas</a>
        <a href="#">Solicitudes de Préstamos</a>
        <a href="#">Reportes</a>
    </div>
</div>

<div class="main-content">
    <div class="container">
        <h1>Gestión de Solicitudes de Préstamos</h1>

        <div class="filtros-container">
            <div class="form-group">
                <label for="buscarDni">Buscar por DNI Cliente:</label>
                <input type="text" id="buscarDni" name="buscarDni">
            </div>
             <div class="form-group">
                <label for="fechaDesde">Fecha Solicitud Desde:</label>
                <input type="date" id="fechaDesde" name="fechaDesde">
            </div>
             <div class="form-group">
                <label for="fechaHasta">Fecha Solicitud Hasta:</label>
                <input type="date" id="fechaHasta" name="fechaHasta">
            </div>
            <div class="form-group">
                 <input type="submit" value="Filtrar" style="background-color: #007bff;">
            </div>
        </div>

        <table class="solicitudes-table">
            <thead>
                <tr>
                    <th>N° Solicitud</th>
                    <th>Cliente (DNI)</th>
                    <th>Monto Solicitado</th>
                    <th>Plazo (meses)</th>
                    <th>Fecha Solicitud</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>101</td>
                    <td>Juan Perez (25.123.456)</td>
                    <td>$50.000,00</td>
                    <td>12</td>
                    <td>15/06/2025</td>
                    <td>
                        <form method="post" action="ServletGestionPrestamos">
                            <input type="hidden" name="idPrestamo" value="101">
                            <input type="submit" name="btnAprobar" value="Aprobar" class="btn-aprobar">
                            <input type="submit" name="btnRechazar" value="Rechazar" class="btn-rechazar">
                        </form>
                    </td>
                </tr>
                 <tr>
                    <td>102</td>
                    <td>Maria Garcia (30.987.654)</td>
                    <td>$120.000,00</td>
                    <td>24</td>
                    <td>16/06/2025</td>
                     <td>
                        <form method="post" action="ServletGestionPrestamos">
                            <input type="hidden" name="idPrestamo" value="102">
                            <input type="submit" name="btnAprobar" value="Aprobar" class="btn-aprobar">
                            <input type="submit" name="btnRechazar" value="Rechazar" class="btn-rechazar">
                        </form>
                    </td>
                </tr>
                 <tr>
                    <td>103</td>
                    <td>Carlos Lopez (22.555.888)</td>
                    <td>$25.000,00</td>
                    <td>6</td>
                    <td>17/06/2025</td>
                     <td>
                        <form method="post" action="ServletGestionPrestamos">
                           <input type="hidden" name="idPrestamo" value="103">
                           <input type="submit" name="btnAprobar" value="Aprobar" class="btn-aprobar">
                           <input type="submit" name="btnRechazar" value="Rechazar" class="btn-rechazar">
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>

    </div>
</div>

</body>
</html>