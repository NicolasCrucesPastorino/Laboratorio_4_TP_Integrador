package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import daoImpl.UsuarioDaoImpl;
import entidad.Cliente;
import entidad.Localidad;
import entidad.Provincia;
import entidad.Usuario;
import negocio.IUsuarioNegocio;
import negocio.IClienteNegocio;
import negocio.UsuarioNegocioImpl;
import negocio.ClienteNegocioImpl;

@WebServlet("/ServletLogin")
public class ServletLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUsuarioNegocio usuarioNegocio = new UsuarioNegocioImpl();
    private IClienteNegocio clienteNegocio = new ClienteNegocioImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreUsuario = request.getParameter("usuario");
        String contrasena = request.getParameter("password");

        Usuario usuario = usuarioNegocio.validarUsuario(nombreUsuario, contrasena);

        if (usuario != null && usuario.isActivo()) {
            // Usuario válido
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

            if ("admin".equalsIgnoreCase(usuario.getTipo_usuario())) {
            	response.sendRedirect("Admin");
            } else if ("cliente".equalsIgnoreCase(usuario.getTipo_usuario())) {
                response.sendRedirect("PrincipalCliente.jsp");
            } else {
                response.sendRedirect("Login.jsp?error=tipoDesconocido");
            }

        } else {
            // Usuario inválido
            response.sendRedirect("Login.jsp?error=1");
        }
        
        
        
    }
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	int c=0;
    	int u=0;
    	
    	String contra1 = request.getParameter("password");
    	String contra2 = request.getParameter("password2");
		if(request.getParameter("alta")!=null)
		{
			if(contra1.equals(contra2)) {
				if(usuarioNegocio.verificarUsuarioExistente(request.getParameter("usuario"))) {
					if(clienteNegocio.verificarDNIExistente(request.getParameter("dni"))) {
						Usuario usu  =  new Usuario();
						usu.setUsuario(request.getParameter("usuario"));
						usu.setContrasena(request.getParameter("password"));
						usu.setTipo_usuario(request.getParameter("tipoUsuario"));
						
						Cliente cli = new Cliente();
						cli.setNombre(request.getParameter("nombre"));
						cli.setApellido(request.getParameter("apellido"));
						cli.setDNI(request.getParameter("dni"));
						cli.setNacionalidad(request.getParameter("nacionalidad"));
						cli.setGenero(request.getParameter("genero"));
						//cli.setFecha_nacimiento(LocalDate.parse(request.getParameter("fechanac")));
						cli.setDireccion(request.getParameter("direccion"));
						int idLocalidad = request.getParameter("localidad") != null ? Integer.parseInt(request.getParameter("localidad")) : -1;
						int idProvincia = request.getParameter("provincia") != null ? Integer.parseInt(request.getParameter("provincia")) : -1;
						
						Localidad localidadCliente = new Localidad();
			            localidadCliente.setId(idLocalidad);
			            
			            Provincia provinciaCliente = new Provincia();
			            provinciaCliente.setId(idProvincia);
			            
			            cli.setLocalidad(localidadCliente);
			            cli.setProvincia(provinciaCliente);
						cli.setCorreo(request.getParameter("correo"));
						cli.setTelefono(request.getParameter("telefono"));
						
						u=usuarioNegocio.agregarUsuario(usu);
						c=clienteNegocio.agregarCliente(cli);

						if(c!=0 && u!=0) {
							boolean exito = true;
						    request.setAttribute("exito", exito);
						}
						RequestDispatcher rd = request.getRequestDispatcher("AltaBajaCuentas.jsp");   
				        rd.forward(request, response);
					}
					else {
						response.sendRedirect("AltaBajaCuentas.jsp?error=DNIyausado");
					}
				}
				else {
					response.sendRedirect("AltaBajaCuentas.jsp?error=nombredeusuarioyaexiste");
				}
			}
			else {
				response.sendRedirect("AltaBajaCuentas.jsp?error=clavesnocoinciden");
			}
			
		}
    	
    }
    
}
