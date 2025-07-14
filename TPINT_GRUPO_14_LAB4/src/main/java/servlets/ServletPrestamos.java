package servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.IClienteDao;
import dao.ICuentaDao;
import daoImpl.ClienteDaoImpl;
import daoImpl.CuentaDaoImpl;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;
import negocio.IPrestamoNegocio;
import negocio.PrestamoNegocio;

@WebServlet("/Prestamos")
public class ServletPrestamos extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private IPrestamoNegocio prestamoNegocio;
    private IClienteDao clienteDAO;
    private ICuentaDao cuentaDAO;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPrestamos() {
        super();
        this.cuentaDAO = new CuentaDaoImpl();
        this.clienteDAO = new ClienteDaoImpl();
        this.prestamoNegocio = new PrestamoNegocio();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false); // Evita crear sesión nueva si no existe

		if(session.getAttribute("usuarioLogueado") == null) {
			response.sendRedirect("Login.jsp");
			return;			
		}
		Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioLogueado");
		
		String opcion = request.getParameter("opcion");

		RequestDispatcher rd;

		if ("exito".equalsIgnoreCase(opcion)) {
		    rd = request.getRequestDispatcher("PrestamoCreado.jsp");

		} else if ("lista".equalsIgnoreCase(opcion)) {
			
			
			List<Prestamo> prestamos = this.prestamoNegocio.getPrestamosDe(usuarioSesion);
			
			request.setAttribute("prestamos", prestamos);
		    rd = request.getRequestDispatcher("ListaPrestamosCliente.jsp");

		} else {
		    Cliente cliente = this.clienteDAO.buscarClientePorUsuario(usuarioSesion.getId_usuario());
		    List<Cuenta> cuentas = this.cuentaDAO.listarporUsuario(usuarioSesion.getId_usuario());

		    request.setAttribute("usuario", usuarioSesion);
		    request.setAttribute("cliente", cliente);
		    request.setAttribute("cuentas", cuentas);

		    rd = request.getRequestDispatcher("FormularioPrestamo.jsp");
		}

		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String esFormulario = request.getParameter("formulario");
		
		if(esFormulario.equals("si")) {
			Prestamo prestamo = new Prestamo();
			
			Cliente cliente = this.clienteDAO.buscarClientePorId(request.getParameter("cliente_id"));
			Cuenta cuenta = this.cuentaDAO.obtenerPorId(Integer.parseInt(request.getParameter("cuenta_id")));
			// valores del formulario
			prestamo.setCliente(cliente);
			prestamo.setCuenta(cuenta);
			
			float montoPedido = Float.parseFloat(request.getParameter("monto_pedido"));
			int cantidadCuotas = Integer.parseInt(request.getParameter("cantidad_cuotas"));
			
			prestamo.setMontoPedido(montoPedido);
			prestamo.setCantidadCuotas(cantidadCuotas);
			prestamo.setFechaPedido((new Date()));
	
			// valores calculados
			
			prestamo.setMontoPorCuota(montoPedido/cantidadCuotas);
			prestamo.setMontoTotal(montoPedido);
			prestamo.setEstado("Pendiente");
			
			HttpSession session = request.getSession(false);
			session.setAttribute("prestamoTemporal", prestamo);

			request.setAttribute("prestamo", prestamo);
			RequestDispatcher rd = request.getRequestDispatcher("ConfirmacionPrestamoFormulario.jsp");
			rd.forward(request, response);
		}else
		{
			HttpSession session = request.getSession(false);
			Prestamo prestamo = (Prestamo) session.getAttribute("prestamoTemporal");
			System.out.println(prestamo.getMontoPedido() + "");
			if(prestamo != null) {
				try {
					this.prestamoNegocio.generarPrestamo(prestamo);
					response.sendRedirect("Prestamos?opcion=lista");
				}catch (PrestamoException e) {
					response.sendRedirect("Prestamos?opcion=error");
				}
			}
		}
		
	}

}
