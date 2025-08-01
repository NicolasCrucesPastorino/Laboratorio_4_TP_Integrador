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

import entidad.Cliente;
import entidad.Localidad;
import entidad.Prestamo;
import entidad.Provincia;
import entidad.Usuario;
import excepciones.PrestamoException;
import negocio.IPrestamoNegocio;
import negocio.PrestamoNegocio;
import negocio.IClienteNegocio;
import negocio.ICuentaNegocio;
import negocio.ClienteNegocioImpl;
import negocio.CuentaNegocioImpl;

@WebServlet("/Admin")
public class ServletAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private IClienteNegocio clienteNegocio;
	private IPrestamoNegocio prestamoNegocio;
	private ICuentaNegocio cuentaNegocio;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletAdmin() {
        super();
        this.clienteNegocio = new ClienteNegocioImpl();
        this.prestamoNegocio = new PrestamoNegocio();
        this.cuentaNegocio = new CuentaNegocioImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		
		RequestDispatcher rq;
		if(opcion == null) {
			// Valores para el resumen en la vista principal
			int cantcli = clienteNegocio.contarClientes();
			int cuentas = cuentaNegocio.contarCuentasActivas();
			float total = cuentaNegocio.totalenSistema();
			int pendientes = prestamoNegocio.contarPrestamosPendientes();
			request.setAttribute("cantclientes", cantcli);
			request.setAttribute("cantcuentas", cuentas);
			request.setAttribute("total", total);
			request.setAttribute("pend", pendientes);
			rq = request.getRequestDispatcher("AdminDatos.jsp");
			rq.forward(request, response);
		}else if(opcion.equalsIgnoreCase("clientes")){
			List<Cliente> clientes = clienteNegocio.getAllClientes();
			System.out.println("CLIENTES " + clientes.size());
			request.setAttribute("clientes", clientes);
			rq = request.getRequestDispatcher("ListaClientes.jsp");
			rq.forward(request, response);
			
		}else if(opcion.equalsIgnoreCase("detalle")){
			String idCliente = request.getParameter("id");
			Cliente cliente = clienteNegocio.buscarClientePorId(idCliente);
			
			request.setAttribute("cliente", cliente);
			request.setAttribute("editar", "no");
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
		
		
	}
}