<%@ page import="java.util.List" %>
<%@ page import= "entidad.Provincia" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		.contra {
    	width: 100%;
	    max-width: 100%;
	    padding: 8px;
	    box-sizing: border-box;
		}
		<jsp:include page="css\AltaBajaCuentas.css"></jsp:include>
	</style>
</head>
<body>

<% 
	List<Provincia> listaProv = null;
	if(request.getAttribute("listaProv")!=null)
	{
		listaProv = (List<Provincia>) request.getAttribute("listaProv");
	}
 %>

<div class="container">
		<aside class="sidebar">
			<div class="logo">Banco Admin</div>
			<nav class="menu">
				<a href="AdminDatos.jsp">Principal</a>
				 <a href="#">Opciones</a>
				 <a href="#">Creditos</a>
				<a href="#">Cerrar sesion</a>
			</nav>
		</aside>

    <main class="main-content">
    
	    
    
        <h1>Alta de Clientes - Cuentas</h1>

        <!-- FORMULARIO DE ALTA/BAJA DE USUARIOS -->
        <form class="formulario" method="post" action="ServletAlta">
            <h2>Gestión de Cliente</h2>

            <label for="usuario">Usuario</label>
            <input type="text" id="usuario" name="usuario" required>
            
            <div class="fila">
                <div>
                    <label for="password">Contraseña</label>
            		<input id="password" type="password" name="password" required class="contra">
                </div>
                <div>
                    <label for="password">Repetir Contraseña</label>
            		<input id="password2" type="password" name="password2" required class="contra">
                </div>
            </div>
            
            <label for="tipoUsuario">Tipo de usuario</label>
            <select id="tipoUsuario" name="tipoUsuario" required>
                <option value="">Seleccione</option>
                <option value="admin">Administrador</option>
                <option value="cliente">Cliente</option>
            </select>
            
            <div class="fila">
                <div>
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>
                <div>
                    <label for="apellido">Apellido</label>
                    <input type="text" id="apellido" name="apellido" required>
                </div>
            </div>
            
            <div class="fila">
                <div>
                    <label for="dni">DNI</label>
                    <input type="text" id="dni" name="dni" required>
                </div>
                <div>
                    <label for="genero">Genero</label>
		            <select id="genero" name="genero" required>
		                <option value="">Seleccione</option>
		                <option value="masculino">Masculino</option>
		                <option value="femenino">Femenino</option>
		                <option value="indefinido">Indefinido</option>
		            </select>
                </div>
            </div>
            
            <div class="fila">
                <div>
                    <label for="nacionalidad">Nacionalidad</label>
                    <input type="text" id="nacionalidad" name="nacionalidad" required>
                </div>
                <div>
                    <label for="fechanac">Fecha de nacimiento</label>
                    <input type="date" id="fechanac" name="fechanac" class="contra" required>
                </div>
            </div>
            
            <div class="fila">
            	<div>
            		<label for="direccion">Dirección</label>
            		<input type="text" id="direccion" name="direccion" required>
            	</div>
                <div>
                    <label for="localidad">Localidad</label>
                    <input type="text" id="localidad" name="localidad" required>
                </div>
                <div>
                    <label for="provincia">Provincia</label>
                    <select id="provincia" name="provincia" required>
	                <option value="">Seleccione</option>
	                <% if(listaProv != null)
						for(Provincia prov : listaProv){ %>
							<option value=<%=prov.getId() %> ><%=prov.getNombre() %></option>
					<%} %>
	            </select>
                </div>
            </div>
            
            <div class="fila">
                <div>
                    <label for="correo">Correo Electronico</label>
                    <input type="email" id="correo" name="correo" class="contra" required>
                </div>
                <div>
                    <label for="telefono">Telefono</label>
                    <input type="number" id="telefono" name="telefono" required>
                </div>
            </div>

            

            

            <div class="botones">
                <button type="submit" name="alta" value="altaUsuario">Alta</button>
                <button type="submit" name="accion" value="bajaUsuario" class="baja">Baja</button>
            </div>
        </form>

        <hr>

        
    </main>
</div>

</body>
</html>