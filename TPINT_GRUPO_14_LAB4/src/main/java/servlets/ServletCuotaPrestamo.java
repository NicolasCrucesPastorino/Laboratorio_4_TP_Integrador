package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidad.CuotaPrestamo;
import entidad.Prestamo;
import negocio.ICuotaNegocio;
import negocio.IPrestamoNegocio;
import negocio.CuotaNegocioImpl;
import negocio.PrestamoNegocio;

/**
 * Servlet implementation class ServletCuotaPrestamo
 */
@WebServlet("/CuotaPrestamo")
public class ServletCuotaPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IPrestamoNegocio prestamoNegocio;
	private ICuotaNegocio cuotaNegocio;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCuotaPrestamo() {
        super();
        this.prestamoNegocio = new PrestamoNegocio();
        this.cuotaNegocio = new CuotaNegocioImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idPrestamoStr = request.getParameter("id");
		
		if (idPrestamoStr != null && !idPrestamoStr.trim().isEmpty()) {
			try {
				int idPrestamo = Integer.parseInt(idPrestamoStr);
				
				// Obtener el préstamo por ID
				Prestamo prestamo = prestamoNegocio.obtenerPrestamoPorId(idPrestamo);
				
				if (prestamo != null) {
					// Obtener las cuotas del préstamo
					List<CuotaPrestamo> cuotas = cuotaNegocio.obtenerCuotasPorPrestamo(idPrestamo);
					
					// Pasar los datos al JSP
					request.setAttribute("prestamo", prestamo);
					request.setAttribute("cuotas", cuotas);
				}
				
			} catch (NumberFormatException e) {
				// ID inválido, no se cargan datos
			}
		}
		
		RequestDispatcher rs = request.getRequestDispatcher("AdelantarPrestamo.jsp");
		rs.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("accion");
		
		if ("pagar".equals(accion)) {
			// Aquí se puede implementar la lógica para procesar el pago de una cuota
			String idCuotaStr = request.getParameter("idCuota");
			String idPrestamoStr = request.getParameter("idPrestamo");
			
			// TODO: Implementar lógica de pago de cuota
			// Por ahora solo redirige de vuelta
			response.sendRedirect("CuotaPrestamo?id=" + idPrestamoStr);
		} else {
			doGet(request, response);
		}
	}

}
