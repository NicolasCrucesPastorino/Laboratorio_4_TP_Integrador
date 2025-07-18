package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import entidad.Cuenta;
import entidad.Localidad;
import entidad.Provincia;
import entidad.Usuario;
import excepciones.MailInvalidoException;
import excepciones.ValidadorMail;
import util.Conexion;
import util.Mensaje;

import java.sql.Connection;
import java.time.LocalDate;

import negocio.IUsuarioNegocio;
import negocio.IClienteNegocio;
import negocio.ICuentaNegocio;
import negocio.IProvinciaNegocio;
import negocio.ILocalidadNegocio;
import negocio.UsuarioNegocioImpl;
import negocio.ClienteNegocioImpl;
import negocio.CuentaNegocioImpl;
import negocio.ProvinciaNegocioImpl;
import negocio.LocalidadNegocioImpl;

@WebServlet("/ServletAlta")
public class ServletAlta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletAlta() {
        super();
    }

    private IUsuarioNegocio usuarioNegocio = new UsuarioNegocioImpl();
	private IClienteNegocio clienteNegocio = new ClienteNegocioImpl();
	private ICuentaNegocio cuentaNegocio = new CuentaNegocioImpl();
	private IProvinciaNegocio provinciaNegocio = new ProvinciaNegocioImpl();
	private ILocalidadNegocio localidadNegocio = new LocalidadNegocioImpl();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    String provinciaParam = request.getParameter("provincia");
	    
	    if (provinciaParam != null && !provinciaParam.isEmpty()) {
	        // Preservar todos los parámetros del formulario
	        String nombre = request.getParameter("nombre");
	        String apellido = request.getParameter("apellido");
	        String dni = request.getParameter("dni");
	        String usuario = request.getParameter("usuario");
	        String password = request.getParameter("password");
	        String password2 = request.getParameter("password2");
	        String tipoUsuario = request.getParameter("tipoUsuario");
	        String genero = request.getParameter("genero");
	        String nacionalidad = request.getParameter("nacionalidad");
	        String fechanac = request.getParameter("fechanac");
	        String direccion = request.getParameter("direccion");
	        String correo = request.getParameter("correo");
	        String telefono = request.getParameter("telefono");
	        
	        // Crear Map con los datos preservados (usando valores por defecto si son null)
	        java.util.Map<String, String> datosFormulario = new java.util.HashMap<>();
	        datosFormulario.put("nombre", nombre != null ? nombre : "");
	        datosFormulario.put("apellido", apellido != null ? apellido : "");
	        datosFormulario.put("dni", dni != null ? dni : "");
	        datosFormulario.put("usuario", usuario != null ? usuario : "");
	        datosFormulario.put("password", password != null ? password : "");
	        datosFormulario.put("password2", password2 != null ? password2 : "");
	        datosFormulario.put("tipoUsuario", tipoUsuario != null ? tipoUsuario : "Cliente");
	        datosFormulario.put("genero", genero != null ? genero : "");
	        datosFormulario.put("nacionalidad", nacionalidad != null ? nacionalidad : "Argentina");
	        datosFormulario.put("fechanac", fechanac != null ? fechanac : "");
	        datosFormulario.put("direccion", direccion != null ? direccion : "");
	        datosFormulario.put("correo", correo != null ? correo : "");
	        datosFormulario.put("telefono", telefono != null ? telefono : "");
	        
	        // Pasar los datos preservados como atributo
	        request.setAttribute("datosFormulario", datosFormulario);
	        
	        // Cargar provincias
	        List<Provincia> listaProv = provinciaNegocio.listarProvincias();
	        request.setAttribute("listaProv", listaProv);
	        
	        // Cargar localidades de la provincia seleccionada
	        List<Localidad> listaLoc = localidadNegocio.listarLocalidadesPorProvincia(
	            Integer.parseInt(provinciaParam));
	        request.setAttribute("listaLoc", listaLoc);
	        request.setAttribute("provinciaSeleccionada", provinciaParam);
	        
	        RequestDispatcher rd = request.getRequestDispatcher("/AltaClientes.jsp");   
	        rd.forward(request, response);
	        return;
	    }
	    
	    // Caso inicial - cargar solo provincias
	    List<Provincia> listaProv = provinciaNegocio.listarProvincias();
	    request.setAttribute("listaProv", listaProv);
	    RequestDispatcher rd = request.getRequestDispatcher("/AltaClientes.jsp");   
	    rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
		int c=0;
		int u=0;
		int ct=0;

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
						cli.setFecha_nacimiento(LocalDate.parse(request.getParameter("fechanac")));
						cli.setDireccion(request.getParameter("direccion"));
						String Localidad = (request.getParameter("localidad"));
						int Provincia = (Integer.parseInt(request.getParameter("provincia")));
						Localidad localidadCliente = localidadNegocio.buscarLocalidad(Localidad, Provincia);
						Provincia provinciaCliente = new Provincia();
						provinciaCliente.setId(Provincia);
						cli.setLocalidad(localidadCliente);
						cli.setProvincia(provinciaCliente);
						String correo = request.getParameter("correo");
						cli.setCorreo(correo);
						cli.setTelefono(request.getParameter("telefono"));
						
						ValidadorMail validadorMail = new ValidadorMail();
                        try {
                            validadorMail.validarMail1(correo);
                        } catch (MailInvalidoException e) {
                            Mensaje.error(request, e.getMessage());
                            RequestDispatcher rd = request.getRequestDispatcher("AltaClientes.jsp");
                            rd.forward(request, response);
                            return;
                        }
						
						u=usuarioNegocio.agregarUsuario(usu);
						c=clienteNegocio.agregarCliente(cli);
						
						Cuenta cu = new Cuenta();
						cu.setIdCliente(clienteNegocio.ultimoID());
						cu.setIdTipoCuenta(1);
						cu.setNumeroCuenta(cuentaNegocio.generarNumeroAleatorio(10));
						cu.setCbu(cuentaNegocio.generarNumeroAleatorio(22));
						BigDecimal saldo = new BigDecimal("0");
						cu.setSaldo(saldo);
						ct=cuentaNegocio.agregarCuenta(cu);
						
						if(c!=0 && u!=0) {
							boolean exito = true;
							request.setAttribute("exito", exito);
						}
						RequestDispatcher rd = request.getRequestDispatcher("AltaClientes.jsp");   
						rd.forward(request, response);
					}
					else {
						response.sendRedirect("AltaClientes.jsp?error=DNIyausado");
					}
				}
				else {
					response.sendRedirect("AltaClientes.jsp?error=nombredeusuarioyaexiste");
				}
			}
			else {
				response.sendRedirect("AltaClientes.jsp?error=clavesnocoinciden");
			}
		}
	}
}