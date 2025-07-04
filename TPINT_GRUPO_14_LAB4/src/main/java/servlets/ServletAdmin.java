package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.IClienteDao;
import daoImpl.ClienteDaoImpl;
import entidad.Cliente;
import entidad.Localidad;
import entidad.Provincia;

/**
 * Servlet implementation class ServletAdmin
 */
@WebServlet("/Admin")
public class ServletAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private IClienteDao clienteDao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAdmin() {
        super();
        this.clienteDao = new ClienteDaoImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		
		RequestDispatcher rq;
		if(opcion == null) {
			rq = request.getRequestDispatcher("AdminDatos.jsp");
			rq.forward(request, response);
		}else if(opcion.equalsIgnoreCase("clientes")){
			List<Cliente> clientes = clienteDao.getAllClientes();
			System.out.println("CLIENTES " + clientes.size());
			request.setAttribute("clientes", clientes);
			rq = request.getRequestDispatcher("ListaClientes.jsp");
			rq.forward(request, response);
			
		}else if(opcion.equalsIgnoreCase("detalle")){
			String idCliente = request.getParameter("id");
			String editar = request.getParameter("editar");
			Cliente cliente = clienteDao.buscarClientePorId(idCliente);
			
			request.setAttribute("cliente", cliente);
			request.setAttribute("editar", editar);
			rq = request.getRequestDispatcher("InfoPersonalCliente.jsp");
			rq.forward(request, response);
			
		}else {
			response.sendRedirect("Admin");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		
		if(opcion != null && opcion.equalsIgnoreCase("actualizar")){
			String idCliente = request.getParameter("id");
			
			Cliente cliente = new Cliente();
			cliente.setId_cliente(Integer.parseInt(idCliente));
			cliente.setNombre(request.getParameter("nombre"));
			cliente.setApellido(request.getParameter("apellido"));
			cliente.setDNI(request.getParameter("dni"));
			cliente.setGenero(request.getParameter("genero"));
			cliente.setDireccion(request.getParameter("direccion"));
			cliente.setCorreo(request.getParameter("correo"));
			cliente.setTelefono(request.getParameter("telefono"));
			
			int idLocalidad = request.getParameter("localidad") != null ? Integer.parseInt(request.getParameter("localidad")) : -1;
			int idProvincia = request.getParameter("provincia") != null ? Integer.parseInt(request.getParameter("provincia")) : -1;
			
			Localidad localidadCliente = new Localidad();
            localidadCliente.setId(idLocalidad);
            
            Provincia provinciaCliente = new Provincia();
            provinciaCliente.setId(idProvincia);
            
            cliente.setLocalidad(localidadCliente);
            cliente.setProvincia(provinciaCliente);
			
			clienteDao.actualizarCliente(cliente);
			
			response.sendRedirect("Admin?opcion=detalle&id=" + idCliente);
		} else {
			doGet(request, response);
		}
	}
}