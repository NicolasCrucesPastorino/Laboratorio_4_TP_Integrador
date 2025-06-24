<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alta de Clientes - Cuentas</title>
<style type="text/css">
<jsp:include page="css\AltaBajaCuentas.css"></jsp:include>
</style>
</head>
<body>
<div class="container">
		<aside class="sidebar">
			<div class="logo">Banco Admin</div>
			<nav class="menu">
				<a href="#">Principal</a>
				 <a href="#">Opciones</a>
				 <a href="#">Creditos</a>
				<a href="#">Cerrar sesion</a>
			</nav>
		</aside>

    <main class="main-content">
        <h1>Alta de Clientes - Cuentas</h1>

        <!-- FORMULARIO DE ALTA/BAJA DE USUARIOS -->
        <form class="formulario">
            <h2>Gestión de Cliente</h2>

            <label for="usuario">Usuario</label>
            <input type="text" id="usuario" name="usuario" required>

            <div class="fila">
                <div>
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre">
                </div>
                <div>
                    <label for="apellido">Apellido</label>
                    <input type="text" id="apellido" name="apellido">
                </div>
            </div>

            <label for="direccion">Dirección</label>
            <input type="text" id="direccion" name="direccion">

            <label for="tipoCuenta">Tipo de cuenta inicial</label>
            <select id="tipoCuenta" name="tipoCuenta">
                <option value="">Seleccione</option>
                <option value="Caja de Ahorro">Caja de Ahorro</option>
                <option value="Cuenta Corriente">Cuenta Corriente</option>
            </select>

            <div class="botones">
                <button type="submit" name="accion" value="altaUsuario">Alta</button>
                <button type="submit" name="accion" value="bajaUsuario" class="baja">Baja</button>
            </div>
        </form>

        <hr>

        <!-- FORMULARIO DE ALTA/BAJA DE CUENTAS -->
        <form class="formulario">
            <h2>Gestión de Cuentas de Cliente</h2>

            <label for="usuarioCuenta">Usuario</label>
            <input type="text" id="usuarioCuenta" name="usuarioCuenta" required>

            <label for="cuentasActuales">Cantidad de cuentas actuales</label>
            <input type="number" id="cuentasActuales" name="cuentasActuales" readonly value="0">

            <label for="nroCuenta">Nro de cuenta</label>
            <input type="text" id="nroCuenta" name="nroCuenta">

            <label for="tipoCuentaExtra">Tipo de cuenta</label>
            <select id="tipoCuentaExtra" name="tipoCuentaExtra">
                <option value="">Seleccione</option>
                <option value="Caja de Ahorro">Caja de Ahorro</option>
                <option value="Cuenta Corriente">Cuenta Corriente</option>
            </select>

            <div class="botones">
                <button type="submit" name="accion" value="altaCuenta">Alta</button>
                <button type="submit" name="accion" value="bajaCuenta" class="baja">Baja</button>
            </div>
        </form>
    </main>
</div>
</body>
</html>