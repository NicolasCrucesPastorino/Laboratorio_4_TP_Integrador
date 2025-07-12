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
import entidad.Prestamo;
import entidad.Provincia;
import entidad.Usuario;
import excepciones.PrestamoException;
import negocio.IPrestamoNegocio;
import negocio.PrestamoNegocio;

@WebServlet("/Admin")
public class ServletAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private IClienteDao clienteDao;
	private IPrestamoNegocio prestamoNegocio;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAdmin() {
        super();
        this.clienteDao = new ClienteDaoImpl();
        this.prestamoNegocio = new PrestamoNegocio();
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
			
		}else if(opcion.equalsIgnoreCase("prestamos")){
			try {
				List<Prestamo> prestamosPendientes = prestamoNegocio.getPrestamosPendientes();
				request.setAttribute("prestamosPendientes", prestamosPendientes);
				rq = request.getRequestDispatcher("SolicitudesPrestamo.jsp");
				rq.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("error", "Error al cargar las solicitudes de préstamos");
				rq = request.getRequestDispatcher("SolicitudesPrestamo.jsp");
				rq.forward(request, response);
			}
			
		}else {
			response.sendRedirect("Admin");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Verificar si es una acción de cerrar sesión
		
        String accion = request.getParameter("accion");
        if ("cerrarSesion".equals(accion)) {
            // Invalidar la sesión actual
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            // Redirigir al login
            response.sendRedirect("Login.jsp");
            return;
        }
		
		String opcion = request.getParameter("opcion");
		String action = request.getParameter("action");
		
		// Manejar acciones de préstamos
		if(action != null && (action.equals("aprobar") || action.equals("rechazar"))){
			HttpSession session = request.getSession(false);
			Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioLogueado");
			
			String idPrestamoStr = request.getParameter("idPrestamo");
			
			if (idPrestamoStr != null && !idPrestamoStr.trim().isEmpty()) {
				try {
					int idPrestamo = Integer.parseInt(idPrestamoStr);
					
					if ("aprobar".equals(action)) {
						prestamoNegocio.aprobarPrestamo(idPrestamo, usuarioSesion.getId_usuario());
						request.setAttribute("mensaje", "Préstamo aprobado exitosamente");
					} else if ("rechazar".equals(action)) {
						String observaciones = request.getParameter("observaciones");
						if (observaciones == null || observaciones.trim().isEmpty()) {
							observaciones = "Sin observaciones";
						}
						prestamoNegocio.rechazarPrestamo(idPrestamo, usuarioSesion.getId_usuario(), observaciones);
						request.setAttribute("mensaje", "Préstamo rechazado exitosamente");
					}
					
				} catch (PrestamoException e) {
					request.setAttribute("error", e.getMessage());
				} catch (NumberFormatException e) {
					request.setAttribute("error", "ID de préstamo inválido");
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("error", "Error al procesar la solicitud");
				}
			}
			
			response.sendRedirect("Admin?opcion=prestamos");
			return;
		}
		
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
		} else {
			doGet(request, response);
		}
	}
}