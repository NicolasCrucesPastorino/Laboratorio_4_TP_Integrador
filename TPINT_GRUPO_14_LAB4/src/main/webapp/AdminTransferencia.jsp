<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/app.css">
<title>Transferencias</title>
<style>


	body {
    font-family: Arial, sans-serif;
	}
	
	.formulario {
    background: white;
    padding: 20px;
    border-radius: 8px;
    margin: 20px 0;
	}
	
	.container-menu a:hover {
    background-color: #5557d9;
	}
	
	.container {
		margin:0;
		padding:0;
		height: 100vh;
		display:grid;
		grid-template-columns: 2fr 6fr;
	}
	
	div{
	margin: 5px;
	padding: 5px;
	}
	
	.container-menu {
		background-color: #92a8d1;
		display:flex;
		flex-direction: column;
	}
	
	.container-main {
		padding: 20px;
	    
	    max-width: 600px;
	    margin: 0 auto;
	}
	
	.info-cuenta {
    margin-bottom: 30px;
    padding: 15px;
    background: #f9f9f9;
	}
	
	.info-cuenta p {
    margin: 15px 0;
    font-size: 16px;
	}
	
	.campo {
    margin-bottom: 25px;
	}
	
	.btn {
		padding:8px;
		text-decoration: none;
		background-color: gray;
		border: 1px solid black;
		border-radiud: 10px;
	}
	
	.btn-primary {
		background-color: #92a8d1;
	}
	
	.visible {
		display:block;
	}
	
	.oculto {
		display:none;
	}
</style>
	
</head>

<body class="container">
	

	<aside class="container-menu">
	    <figure style="text-align: center; margin: 20px 0;">
	        <img alt="logo" src="/imagen.jpg" style="width: 80px; height: 80px;">
	    </figure>
	    <header style="text-align: center; margin-bottom: 20px;">
	        <h2 style="color: #2c3e50; margin: 0;">Panel de Opc</h2> 
	    </header>
	    <menu>
	        <ul style="list-style: none; padding: 0; margin: 0;">
	            <li style="margin-bottom: 10px;"><a href="" style="display: block; padding: 12px; color: white; text-decoration: none; border-radius: 4px; transition: background 0.3s;">Principal</a></li>
	            <li style="margin-bottom: 10px;"><a href="" style="display: block; padding: 12px; color: white; text-decoration: none; border-radius: 4px; transition: background 0.3s;">Opciones</a></li>
	            <li style="margin-bottom: 10px;"><a href="" style="display: block; padding: 12px; color: white; text-decoration: none; border-radius: 4px; transition: background 0.3s;">Créditos</a></li>
	            <li style="margin-bottom: 10px;"><a href="" style="display: block; padding: 12px; color: white; text-decoration: none; border-radius: 4px; transition: background 0.3s;">Cerrar sesión</a></li>
	        </ul>
	    </menu>
	</aside>



	<main class="container-main">
		<header>
			<h1 style="font-family: Verdana, sans-serif;text-align: center; margin: 30px 0;">Transferencia</h1>
		</header>
		<section>
			<article>
				<p><strong>nro de cuenta:  </strong> <span>  1203912332</span></p>
				<p><strong>saldo   ARS$</strong><span>123000</span></p>
			</article>
			<article>
				<form action="">
					<div>
						<label for="cbu-id">Desde cuenta</label>
						<input type="text" name="cbu" id="cbu-id">
					</div>
					
					<div>
						<label for="cantidad-id">cantidad de dinero a transferir</label>
						<input type="number" name="cantidad" id="cantidad-id">
					</div>
					
					<div>
						<label for="cuenta-inicio-id">CBU - alias destino </label>
						<select name="cuentaInicio" id="cuenta-inicio-id"> 
							<option value="1">cuenta personal</option>
							<option value="2">caja ahorros pesos</option>
							<option value="3">caja solidaria</option> 
						</select>
					</div>
					
					<div>
						<button type="submit">Enviar</button>
					</div>
				</form>
			</article>
		</section>
		<section class="visible">
			<h2>Resultado de la transferencia</h2>
			<!-- informacion de la transferencia -->
		</section>
	</main>
</body>
</html>