package servlets;

import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import entidad.Cliente;
import entidad.Localidad;
import entidad.Provincia;
import negocio.IClienteNegocio;
import negocio.ClienteNegocioImpl;
import negocio.IProvinciaNegocio;
import negocio.ProvinciaNegocioImpl;
import negocio.ILocalidadNegocio;
import negocio.LocalidadNegocioImpl;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServletEditarCliente
 */
@WebServlet("/EditarCliente")
public class ServletEditarCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private IClienteNegocio clienteNegocio;
	private IProvinciaNegocio provinciaNegocio;
	private ILocalidadNegocio localidadNegocio;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletEditarCliente() {
        super();
        this.clienteNegocio = new ClienteNegocioImpl();
        this.provinciaNegocio = new ProvinciaNegocioImpl();
        this.localidadNegocio = new LocalidadNegocioImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// PARAMETROS
	    String idCliente = request.getParameter("id");
	    HttpSession session = request.getSession();
	    
	    Cliente cliente = null;
	    
	    if (idCliente != null) {
	        // ADMIN
	        cliente = clienteNegocio.buscarClientePorId(idCliente);
	        List<Provincia> provincias = provinciaNegocio.listarProvincias();
	        request.setAttribute("provincias", provincias);
	        
	        String provinciaParam = request.getParameter("provincia");
	        
	        //PRESERVAR DATOS EN EDICION
	        if (provinciaParam != null) {
	            String nombre = request.getParameter("nombre");
	            String apellido = request.getParameter("apellido");
	            String genero = request.getParameter("genero");
	            String direccion = request.getParameter("direccion");
	            String correo = request.getParameter("correo");
	            String telefono = request.getParameter("telefono");
	            
	            
	            if (nombre != null) cliente.setNombre(nombre);
	            if (apellido != null) cliente.setApellido(apellido);
	            if (genero != null) cliente.setGenero(genero);
	            if (direccion != null) cliente.setDireccion(direccion);
	            if (correo != null) cliente.setCorreo(correo);
	            if (telefono != null) cliente.setTelefono(telefono);
	        }
	        
	        int provinciaId = (provinciaParam != null) ? Integer.parseInt(provinciaParam) : cliente.getProvincia().getId();
	        List<Localidad> localidades = localidadNegocio.listarLocalidadesPorProvincia(provinciaId);
	        
	       
	        
	        request.setAttribute("localidades", localidades);
	        System.out.println("YOU ARE AN ADMIN editando cliente ID " + idCliente);
	    }
	    else {
	    	System.out.println("you are cliente editando tus datos");
	    }
	    
	    if (cliente != null) {
	    	request.setAttribute("cliente", cliente);
	    	request.setAttribute("editar", "si");
	    	
	    	RequestDispatcher rd = request.getRequestDispatcher("InfoPersonalCliente.jsp");
	    	rd.forward(request, response);
	    }
	 else {
		// Usuario inválido
		response.sendRedirect("InfoPersonalCliente.jsp?error=1");
	    
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String idCliente = request.getParameter("id");
		String nombre = request.getParameter("nombre");
		
		if (nombre == null) {
	        Cliente cliente = clienteNegocio.buscarClientePorId(idCliente);
	        request.setAttribute("cliente", cliente);
	        request.setAttribute("editar", "no");
	        
	        RequestDispatcher rd = request.getRequestDispatcher("InfoPersonalCliente.jsp");
	        rd.forward(request, response);
	        return;
	    }
		
		Cliente cliente = new Cliente();
		
		String accion = request.getParameter("accion");
		cliente.setActivo(true);
		
		if("Dar de baja".equals(accion)) {
			cliente.setActivo(false);
		}
		
		cliente.setId_cliente(Integer.parseInt(idCliente));
		cliente.setNombre(request.getParameter("nombre"));
		cliente.setApellido(request.getParameter("apellido"));
		cliente.setDNI(request.getParameter("dni"));
		cliente.setGenero(request.getParameter("genero"));
		cliente.setDireccion(request.getParameter("direccion"));
		cliente.setCorreo(request.getParameter("correo"));
		cliente.setTelefono(request.getParameter("telefono"));
		
		String localidadId = request.getParameter("localidad");
		String provinciaId = request.getParameter("provincia");

		Localidad localidadObj = new Localidad();
		localidadObj.setId(Integer.parseInt(localidadId));
		
		Provincia provinciaObj = new Provincia();
		provinciaObj.setId(Integer.parseInt(provinciaId));

		cliente.setLocalidad(localidadObj);
		cliente.setProvincia(provinciaObj);
		
		clienteNegocio.actualizarCliente(cliente);
		
		if ("Dar de baja".equals(accion)) {
		    response.sendRedirect("Admin?opcion=detalle&id=" + idCliente + "&baja=ok");
		} else {
		    response.sendRedirect("Admin?opcion=detalle&id=" + idCliente);
		}
		//response.sendRedirect("Admin?opcion=detalle&id=" + idCliente);
		//response.sendRedirect("Admin?opcion=detalle&id=" + idCliente + "&baja=ok");
		
	}

}