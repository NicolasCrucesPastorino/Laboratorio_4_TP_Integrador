package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import dao.IClienteDao;
import daoImpl.ClienteDaoImpl;
import entidad.Cliente;
import entidad.Localidad;
import entidad.Provincia;

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
       
	private IClienteDao clienteDao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletEditarCliente() {
        super();
        this.clienteDao = new ClienteDaoImpl();
        // TODO Auto-generated constructor stub
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
	        cliente = clienteDao.buscarClientePorId(idCliente);
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
	        Cliente cliente = clienteDao.buscarClientePorId(idCliente);
	        request.setAttribute("cliente", cliente);
	        request.setAttribute("editar", "no");
	        
	        RequestDispatcher rd = request.getRequestDispatcher("InfoPersonalCliente.jsp");
	        rd.forward(request, response);
	        return;
	    }
		
		Cliente cliente = new Cliente();
		
		
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
		
		clienteDao.actualizarCliente(cliente);
		response.sendRedirect("Admin?opcion=detalle&id=" + idCliente);
		
	}

}
