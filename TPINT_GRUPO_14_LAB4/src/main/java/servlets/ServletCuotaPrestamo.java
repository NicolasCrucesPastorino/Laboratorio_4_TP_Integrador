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
import negocio.ICuentaNegocio;
import negocio.CuotaNegocioImpl;
import negocio.PrestamoNegocio;
import negocio.CuentaNegocioImpl;
import java.math.BigDecimal;

/**
 * Servlet implementation class ServletCuotaPrestamo
 */
@WebServlet("/CuotaPrestamo")
public class ServletCuotaPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IPrestamoNegocio prestamoNegocio;
	private ICuotaNegocio cuotaNegocio;
	private ICuentaNegocio cuentaNegocio;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCuotaPrestamo() {
        super();
        this.prestamoNegocio = new PrestamoNegocio();
        this.cuotaNegocio = new CuotaNegocioImpl();
        this.cuentaNegocio = new CuentaNegocioImpl();
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
			String idCuotaStr = request.getParameter("idCuota");
			String idPrestamoStr = request.getParameter("idPrestamo");
			
			if (idCuotaStr != null && idPrestamoStr != null) {
				try {
					int idCuota = Integer.parseInt(idCuotaStr);
					int idPrestamo = Integer.parseInt(idPrestamoStr);
					
					// Verificar que la cuota exista y no esté ya pagada
					CuotaPrestamo cuota = cuotaNegocio.obtenerCuotaPorId(idCuota);
					
					if (cuota != null && !"Pagada".equals(cuota.getEstado())) {
						// Verificar que el préstamo esté aprobado
						Prestamo prestamo = prestamoNegocio.obtenerPrestamoPorId(idPrestamo);
						
						if (prestamo != null && "Aprobado".equalsIgnoreCase(prestamo.getEstado())) {
							// Verificar que la cuenta tenga saldo suficiente y procesar pago
							BigDecimal montoCuota = BigDecimal.valueOf(cuota.getMontoCuota());
							int idCuenta = prestamo.getCuenta().getIdCuenta();
							
							boolean pagoExitoso = cuentaNegocio.pagarCuotaPrestamo(idCuenta, montoCuota);
							
							if (pagoExitoso) {
								// Si el pago fue exitoso, marcar la cuota como pagada
								cuotaNegocio.pagarCuota(idCuota);
								response.sendRedirect("CuotaPrestamo?id=" + idPrestamoStr + "&mensaje=exito");
							} else {
								// Saldo insuficiente o error en el pago
								response.sendRedirect("CuotaPrestamo?id=" + idPrestamoStr + "&mensaje=saldo_insuficiente");
							}
						} else {
							// Préstamo no aprobado
							response.sendRedirect("CuotaPrestamo?id=" + idPrestamoStr + "&mensaje=error_prestamo");
						}
					} else {
						// Cuota ya pagada o no existe
						response.sendRedirect("CuotaPrestamo?id=" + idPrestamoStr + "&mensaje=error_cuota");
					}
					
				} catch (NumberFormatException e) {
					// IDs inválidos
					response.sendRedirect("CuotaPrestamo?id=" + idPrestamoStr + "&mensaje=error");
				}
			} else {
				// Parámetros faltantes
				response.sendRedirect("CuotaPrestamo?mensaje=error");
			}
		} else {
			doGet(request, response);
		}
	}

}
