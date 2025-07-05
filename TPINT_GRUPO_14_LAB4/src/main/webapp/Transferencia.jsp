<%@ page import="java.util.List" %>
<%@ page import= "entidad.Cuenta" %>
<%@ page import= "javax.servlet.http.HttpSession" %>
<%@ page import= "entidad.Usuario" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
	List<Cuenta> listaCuentas = null;
	if(request.getAttribute("listaCuentas")!=null)
	{
		listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
	}

	

	Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
 %>

<div style="background-color:blue; width:20%; height:80px; float:left;"></div>
<div style="background-color:dodgerblue; width:80%; height:80px; display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; font-family: Arial, sans-serif;">
	<div>
	</div>
	<div style="display: flex; align-items: center; justify-content: center;">
		<div style="padding: 20px">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
			  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
			  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
			</svg>
			<%= usu.getUsuario() %>
		
		</div>
		
	</div>
</div>
<div style="background-color:skyblue; width:20%; height:500px; float:left; padding:20px">
	
	<nav class="nav flex-column">
		<h3 style="text-align:center; color:grey;">MENU</h3>
  		<a class="nav-link" href="#">Informacion personal</a>
  		<a class="nav-link" href="#">Tranferencia</a>
  		<a class="nav-link" href="#">Historial de transferencias</a>
  		<a class="nav-link" href="#">Solicitud de prestamo</a>
  		<a class="nav-link" href="#">Informacion de prestamos</a>
  		
	</nav>
	</br>
  	<input type="submit" class="btn btn-link" name="btnCerrar" value="Cerrar sesion">
	
</div>
<div style="background-color:antiquewhite; width:80%; height:500px; float:left;">

	<div style="padding: 20px; max-width: 500px; margin: 0 auto;">
	
		<h1>Tranferencia</h1>
		<hr>
		<form class="formulario" method="post" action="ServletTransferencia">
            <div style="padding: 20px">
	            <label for="cuentaOrigen">Cuenta Origen: </label>
	            <select id="cuentaOrigen" name="cuentaOrigen" required>
	                <option value="">Seleccione</option>
	                <% if(listaCuentas != null)
						for(Cuenta cuenta : listaCuentas){ %>
							<option><%=cuenta.getNumeroCuenta() %></option>
					<%} %>
	            </select>
	        </div>
            <div style="padding: 20px">
				<label for="cbu">CBU de cuenta destino: </label>
				<input type="number" name="cbu" id="cbu" requires>
			</div>
			<div style="padding: 20px">
				<label for="importe">Importe: </label>
				<input type="number" name="importe" id="importe" required>
			</div>
			<div style="padding: 20px">
                <label for="motivo">Motivo: </label>
                <input type="text" id="motivo" name="motivo" required>
            </div>
            <div style="text-align:center">
            	<button type="submit" name="transferir" class="btn btn-info">Transferir</button>
            </div>
        </form>
	
		
	
	</div>
	

</div>


</body>
</html>