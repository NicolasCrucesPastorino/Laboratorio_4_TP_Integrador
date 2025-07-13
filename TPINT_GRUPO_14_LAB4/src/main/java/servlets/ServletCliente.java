package servlets;

import java.io.IOException;
import java.util.List;
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
import entidad.Usuario;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.Movimiento;
import negocio.IMovimientoNegocio;
import negocio.MovimientoNegocioImpl;

@WebServlet("/Cliente")
public class ServletCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private IClienteDao clienteDao;
	private ICuentaDao cuentaDao;
	private IMovimientoNegocio movimientoNegocio;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCliente() {
        super();
        this.clienteDao = new ClienteDaoImpl();
        this.cuentaDao = new CuentaDaoImpl();
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
		
		List<Cuenta> cuentas = cuentaDao.getCuentasPorUsuario(usuarioLogueado.getId_usuario());
		
		if (cuentas == null || cuentas.isEmpty()) {
			request.setAttribute("mensaje", "No tienes cuentas asociadas");
			request.setAttribute("usuarioLogueado", usuarioLogueado);
			request.getRequestDispatcher("PrincipalCliente.jsp").forward(request, response);
			return;
		}
		
		Cuenta cuentaActiva = null;
		for (Cuenta cuenta : cuentas) {
			if (cuenta.isActiva()) {
				cuentaActiva = cuenta;
				break;
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
