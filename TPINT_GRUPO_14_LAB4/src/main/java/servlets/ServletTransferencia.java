package servlets;

import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import negocio.ICuentaNegocio;
import negocio.CuentaNegocioImpl;
import negocio.ITransferenciaNegocio;
import negocio.TranferenciaNegocio;
import entidad.Cuenta;
import entidad.Cliente;
import entidad.Usuario;
import excepciones.TransferenciaException;

@WebServlet("/ServletTransferencia")
public class ServletTransferencia extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ServletTransferencia() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
		
		if (usu == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		ICuentaNegocio cuentaNeg = new CuentaNegocioImpl();
	    List<Cuenta> listaCuentas = cuentaNeg.listarporUsuario(usu.getId_usuario());
	    request.setAttribute("listaCuentas", listaCuentas);
	    
	    RequestDispatcher rd = request.getRequestDispatcher("/Transferencia.jsp");   
	    rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
		
		if (usu == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		String action = request.getParameter("action");
		
		if ("validarCBU".equals(action)) {
			// Validar CBU y obtener datos del destinatario
			validarCBU(request, response, session);
		} else if ("confirmar".equals(action)) {
			// Mostrar página de confirmación
			mostrarConfirmacion(request, response, session);
		} else if ("transferir".equals(action)) {
			// Procesar la transferencia
			procesarTransferencia(request, response, session);
		} else {
			// Cargar la página de transferencia
			doGet(request, response);
		}
	}
	
	private void validarCBU(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		String cbu = request.getParameter("cbu");
		ITransferenciaNegocio transNeg = new TranferenciaNegocio();
		
		try {
			Cuenta cuentaDestino = transNeg.buscarCuentaPorCBU(cbu);
			Cliente titular = transNeg.obtenerTitularPorCBU(cbu);
			
			// Guardar datos del destinatario en sesión
			session.setAttribute("cuentaDestinoValidada", cuentaDestino);
			session.setAttribute("titularDestino", titular);
			session.setAttribute("cbuValidado", cbu);
			
			request.setAttribute("mensaje", "CBU válido - Destinatario: " + titular.getNombre() + " " + titular.getApellido());
			request.setAttribute("cbuValidado", true);
			
		} catch (TransferenciaException e) {
			request.setAttribute("error", e.getMessage());
			// Limpiar datos de sesión si hay error
			session.removeAttribute("cuentaDestinoValidada");
			session.removeAttribute("titularDestino");
			session.removeAttribute("cbuValidado");
		}
		
		doGet(request, response);
	}
	
	private void mostrarConfirmacion(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		try {
			// Obtener parámetros del formulario
			String cuentaOrigenNum = request.getParameter("cuentaOrigen");
			String cbu = request.getParameter("cbu");
			String importeStr = request.getParameter("importe");
			String motivo = request.getParameter("motivo");
			
			// Validar parámetros
			if (cuentaOrigenNum == null || cbu == null || importeStr == null || motivo == null) {
				request.setAttribute("error", "Todos los campos son obligatorios");
				doGet(request, response);
				return;
			}
			
			// Validar que el CBU esté validado
			String cbuValidado = (String) session.getAttribute("cbuValidado");
			if (cbuValidado == null || !cbuValidado.equals(cbu)) {
				request.setAttribute("error", "Debe validar el CBU antes de continuar");
				doGet(request, response);
				return;
			}
			
			BigDecimal importe = new BigDecimal(importeStr);
			
			// Buscar cuenta de origen
			ICuentaNegocio cuentaNeg = new CuentaNegocioImpl();
			Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
			List<Cuenta> listaCuentas = cuentaNeg.listarporUsuario(usu.getId_usuario());
			Cuenta origen = null;
			for (Cuenta cuenta : listaCuentas) {
				if (cuenta.getNumeroCuenta().equals(cuentaOrigenNum)) {
					origen = cuenta;
					break;
				}
			}
			
			if (origen == null) {
				request.setAttribute("error", "Cuenta de origen no encontrada");
				doGet(request, response);
				return;
			}
			
			// Obtener datos del destinatario de la sesión
			Cuenta cuentaDestino = (Cuenta) session.getAttribute("cuentaDestinoValidada");
			Cliente titular = (Cliente) session.getAttribute("titularDestino");
			
			// Guardar datos de la transferencia en sesión para confirmar
			session.setAttribute("transferenciaOrigen", origen);
			session.setAttribute("transferenciaImporte", importe);
			session.setAttribute("transferenciaMotivo", motivo);
			
			// Preparar datos para mostrar en la confirmación
			request.setAttribute("cuentaOrigen", origen);
			request.setAttribute("cuentaDestino", cuentaDestino);
			request.setAttribute("titular", titular);
			request.setAttribute("importe", importe);
			request.setAttribute("motivo", motivo);
			
			RequestDispatcher rd = request.getRequestDispatcher("/ConfirmarTransferencia.jsp");
			rd.forward(request, response);
			
		} catch (NumberFormatException e) {
			request.setAttribute("error", "El importe debe ser un número válido");
			doGet(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error interno del servidor");
			doGet(request, response);
		}
	}
	
	private void procesarTransferencia(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		try {
			ITransferenciaNegocio transNeg = new TranferenciaNegocio();
			
			// Obtener datos de la transferencia de la sesión
			Cuenta origen = (Cuenta) session.getAttribute("transferenciaOrigen");
			Cuenta destino = (Cuenta) session.getAttribute("cuentaDestinoValidada");
			BigDecimal importe = (BigDecimal) session.getAttribute("transferenciaImporte");
			String motivo = (String) session.getAttribute("transferenciaMotivo");
			
			if (origen == null || destino == null || importe == null || motivo == null) {
				request.setAttribute("error", "Datos de transferencia no encontrados. Intente nuevamente.");
				doGet(request, response);
				return;
			}
			
			// Realizar transferencia
			boolean resultado = transNeg.RealizarTransferencia(origen, destino, importe, motivo);
			
			if (resultado) {
				// Limpiar datos de sesión
				session.removeAttribute("cuentaDestinoValidada");
				session.removeAttribute("titularDestino");
				session.removeAttribute("cbuValidado");
				session.removeAttribute("transferenciaOrigen");
				session.removeAttribute("transferenciaImporte");
				session.removeAttribute("transferenciaMotivo");
				
				request.setAttribute("mensaje", "Transferencia realizada exitosamente");
				request.setAttribute("exito", true);
			} else {
				request.setAttribute("error", "Error al procesar la transferencia");
			}
			
		} catch (TransferenciaException e) {
			request.setAttribute("error", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error interno del servidor");
		}
		
		doGet(request, response);
	}
}
