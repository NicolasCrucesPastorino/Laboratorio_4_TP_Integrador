<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mis Préstamos</title>
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
            max-width: 900px;
            padding: 20px;
            background: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .prestamo-info {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #e9ecef;
            border-radius: 5px;
        }
        .cuotas-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .cuotas-table th, .cuotas-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .cuotas-table th {
            background-color: #007bff;
            color: white;
        }
        .status-pagada {
            color: green;
            font-weight: bold;
        }
        .status-pendiente {
            color: #d9534f;
            font-weight: bold;
        }
        input[type="submit"] {
            padding: 5px 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo">BANCO</div>
    <div class="menu">
        <a href="#">Inicio</a>
        <a href="#">Mis Cuentas</a>
        <a href="#">Transferencias</a>
        <a href="#">Préstamos</a>
    </div>
</div>

<div class="main-content">
    <div class="container">
        <h1>Información de sus Préstamos</h1>

        <div class="prestamo-info">
            <p><strong>Préstamo Activo:</strong> #12345-01 (Préstamo Personal)</p>
            <p><strong>Monto Total Otorgado:</strong> $50.000,00</p>
            <p><strong>Total a abonar (con intereses):</strong> $65.000,00</p>
            <p><strong>Plazo:</strong> 12 cuotas</p>
        </div>

        <table class="cuotas-table">
            <thead>
                <tr>
                    <th>N° de Cuota</th>
                    <th>Monto a Pagar</th>
                    <th>Fecha de Vencimiento</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>$5.416,67</td>
                    <td>10/05/2025</td>
                    <td class="status-pagada">Pagada</td>
                    <td>Pagado el 08/05/2025</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>$5.416,67</td>
                    <td>10/06/2025</td>
                    <td class="status-pendiente">Pendiente</td>
                    <td>
                        <form method="post" action="ServletPagarCuota">
                            <input type="hidden" name="idCuota" value="2">
                            <input type="submit" value="Pagar">
                        </form>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>$5.416,67</td>
                    <td>10/07/2025</td>
                    <td class="status-pendiente">Pendiente</td>
                    <td>
                        <form method="post" action="ServletPagarCuota">
                            <input type="hidden" name="idCuota" value="3">
                            <input type="submit" value="Pagar">
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>