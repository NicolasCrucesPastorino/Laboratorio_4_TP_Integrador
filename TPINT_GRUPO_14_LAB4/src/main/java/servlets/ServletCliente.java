package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Usuario;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.Movimiento;
import negocio.IMovimientoNegocio;
import negocio.MovimientoNegocioImpl;
import negocio.ICuentaNegocio;
import negocio.CuentaNegocioImpl;

@WebServlet("/Cliente")
public class ServletCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private ICuentaNegocio cuentaNegocio;
	private IMovimientoNegocio movimientoNegocio;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCliente() {
        super();
        this.cuentaNegocio = new CuentaNegocioImpl();
        this.movimientoNegocio = new MovimientoNegocioImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		Usuario usuarioLogueado = (Usuario)session.getAttribute("usuarioLogueado");
		
		if (usuarioLogueado == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		List<Cuenta> cuentas = cuentaNegocio.getCuentasPorUsuario(usuarioLogueado.getId_usuario());
		
		if (cuentas == null || cuentas.isEmpty()) {
			request.setAttribute("mensaje", "No tienes cuentas asociadas");
			request.setAttribute("usuarioLogueado", usuarioLogueado);
			request.getRequestDispatcher("PrincipalCliente.jsp").forward(request, response);
			return;
		}
		
		// Obtener la cuenta seleccionada del parámetro o usar la primera cuenta activa
		String cuentaSeleccionadaParam = request.getParameter("cuentaSeleccionada");
		Cuenta cuentaActiva = null;
		
		if (cuentaSeleccionadaParam != null) {
			int idCuentaSeleccionada = Integer.parseInt(cuentaSeleccionadaParam);
			for (Cuenta cuenta : cuentas) {
				if (cuenta.getIdCuenta() == idCuentaSeleccionada && cuenta.isActiva()) {
					cuentaActiva = cuenta;
					break;
				}
			}
		}
		
		if (cuentaActiva == null) {
			for (Cuenta cuenta : cuentas) {
				if (cuenta.isActiva()) {
					cuentaActiva = cuenta;
					break;
				}
			}
		}
		
		if (cuentaActiva == null) {
			request.setAttribute("mensaje", "No tienes cuentas activas");
			request.setAttribute("usuarioLogueado", usuarioLogueado);
			request.getRequestDispatcher("PrincipalCliente.jsp").forward(request, response);
			return;
		}
		
		List<Movimiento> movimientos = movimientoNegocio.getMovimientosPorCuenta(cuentaActiva.getIdCuenta(), 10);
		request.setAttribute("movimientos", movimientos);
		request.setAttribute("cuentaActiva", cuentaActiva);
		request.setAttribute("cuentas", cuentas);
		request.setAttribute("usuarioLogueado", usuarioLogueado);
		
		request.getRequestDispatcher("PrincipalCliente.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	
	
}
