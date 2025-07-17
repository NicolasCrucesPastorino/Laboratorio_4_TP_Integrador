package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import entidad.Cuenta;
import entidad.Usuario;
import negocio.ICuentaNegocio;
import negocio.CuentaNegocioImpl;
import negocio.IClienteNegocio;
import negocio.ClienteNegocioImpl;

@WebServlet("/ServletAltaCuentas")
public class ServletAltaCuentas extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IClienteNegocio clienteNegocio;
	private ICuentaNegocio cuentaNegocio;

	public ServletAltaCuentas() {
		super();
		this.clienteNegocio = new ClienteNegocioImpl();
		this.cuentaNegocio = new CuentaNegocioImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Verificar que el usuario esté logueado y sea admin
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("usuarioLogueado") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
		if (!"admin".equals(usuario.getTipo_usuario())) {
			response.sendRedirect("Login.jsp");
			return;
		}

		// Mostrar la página de alta de cuentas
		RequestDispatcher rd = request.getRequestDispatcher("AltaCuentaAdmin.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Verificar que el usuario esté logueado y sea admin
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("usuarioLogueado") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
		if (!"admin".equals(usuario.getTipo_usuario())) {
			response.sendRedirect("Login.jsp");
			return;
		}

		String action = request.getParameter("action");

		if ("buscarCliente".equals(action)) {
			buscarCliente(request, response);
		} else if ("crearCuenta".equals(action)) {
			crearCuenta(request, response);
		} else if ("desactivarCuenta".equals(action)) {
			desactivarCuenta(request, response);
		} else {
			// Acción por defecto - mostrar página
			doGet(request, response);
		}
	}

	private void buscarCliente(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");

		if (searchValue == null || searchValue.trim().isEmpty()) {
			request.setAttribute("error", "Debe ingresar un valor para buscar");
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchValue", searchValue);
			RequestDispatcher rd = request.getRequestDispatcher("AltaCuentaAdmin.jsp");
			rd.forward(request, response);
			return;
		}

		Cliente cliente = null;

		try {
			// Buscar cliente
			if ("dni".equals(searchType)) {
				// función de búsqueda por DNI
				List<Cuenta> cuentasPorDNI = cuentaNegocio.buscarCuentasPorDNI(searchValue.trim());
				if (!cuentasPorDNI.isEmpty()) {
					
					cliente = clienteNegocio.buscarClientePorId(String.valueOf(cuentasPorDNI.get(0).getIdCliente()));
				} else {
					
					List<Cliente> todosLosClientes = clienteNegocio.getAllClientes();
					for (Cliente c : todosLosClientes) {
						if (searchValue.trim().equals(c.getDNI())) {
							cliente = c;
							break;
						}
					}
				}
			} else if ("email".equals(searchType)) {
				// Buscar por email
				List<Cliente> todosLosClientes = clienteNegocio.getAllClientes();
				for (Cliente c : todosLosClientes) {
					if (searchValue.trim().equalsIgnoreCase(c.getCorreo())) {
						cliente = c;
						break;
					}
				}
			}

			if (cliente != null) {
				// Cliente encontrado - mostrar información y cuentas
				List<Cuenta> cuentasCliente = cuentaNegocio.buscarCuentasPorCliente(cliente.getId());
				
				// Contar SOLO las cuentas ACTIVAS
				int cantidadCuentasActivas = 0;
				for (Cuenta cuenta : cuentasCliente) {
					if (cuenta.isActiva()) {
						cantidadCuentasActivas++;
					}
				}

				request.setAttribute("cliente", cliente);
				request.setAttribute("cuentasCliente", cuentasCliente);
				request.setAttribute("cantidadCuentasActivas", cantidadCuentasActivas);
			} else {
				// Cliente no encontrado
				request.setAttribute("error", "Cliente no encontrado con " + searchType + ": " + searchValue);
				request.setAttribute("mostrarBotonCrear", true);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error al buscar el cliente: " + e.getMessage());
		}

		// Conservar valores de búsqueda para el formulario
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchValue", searchValue);

		RequestDispatcher rd = request.getRequestDispatcher("AltaCuentaAdmin.jsp");
		rd.forward(request, response);
	}

	private void crearCuenta(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// Obtener parámetros
			String clienteIdStr = request.getParameter("clienteId");
			String accountType = request.getParameter("accountType");
			String initialBalanceStr = request.getParameter("initialBalance");
			String accountDescription = request.getParameter("accountDescription");

			// Validar
			if (clienteIdStr == null || clienteIdStr.trim().isEmpty() || accountType == null
					|| accountType.trim().isEmpty() || initialBalanceStr == null
					|| initialBalanceStr.trim().isEmpty()) {

				request.setAttribute("error", "Todos los campos obligatorios deben ser completados");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			int clienteId = Integer.parseInt(clienteIdStr);
			BigDecimal initialBalance = new BigDecimal(initialBalanceStr);

			// Validar saldo inicial no negativo
			if (initialBalance.compareTo(BigDecimal.ZERO) < 0) {
				request.setAttribute("error", "El saldo inicial no puede ser negativo");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			// Verificar que el cliente existe
			Cliente cliente = clienteNegocio.buscarClientePorId(clienteIdStr);
			if (cliente == null) {
				request.setAttribute("error", "Cliente no encontrado");
				doGet(request, response);
				return;
			}

			// Verificar límite de cuentas ACTIVAS (no todas las cuentas)
			List<Cuenta> cuentasExistentes = cuentaNegocio.buscarCuentasPorCliente(clienteId);
			int cantidadCuentasActivas = 0;
			for (Cuenta cuenta : cuentasExistentes) {
				if (cuenta.isActiva()) {
					cantidadCuentasActivas++;
				}
			}
			
			if (cantidadCuentasActivas >= 3) {
				request.setAttribute("error", "El cliente ya tiene el máximo de 3 cuentas activas permitidas");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			// Determinar el ID del tipo de cuenta
			int idTipoCuenta;

			if ("CA".equals(accountType)) {
				idTipoCuenta = 1; // Cuenta de Ahorro
			} else if ("CC".equals(accountType)) {
				idTipoCuenta = 2; // Cuenta Corriente
			} else {
				request.setAttribute("error", "Tipo de cuenta inválido");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			// Crear nueva cuenta
			boolean cuentaCreada = false;
			String numeroCuenta = "";
			String cbu = "";

			try {
				// Intentar usar la función crearCuentaCompleta primero
				cuentaCreada = cuentaNegocio.crearCuentaCompleta(clienteId, idTipoCuenta);

				if (cuentaCreada) {
					// buscar la cuenta recién creada para obtener sus datos
					List<Cuenta> cuentasActualizadas = cuentaNegocio.buscarCuentasPorCliente(clienteId);
					if (cuentasActualizadas.size() > cuentasExistentes.size()) {
						Cuenta cuentaNueva = cuentasActualizadas.get(cuentasActualizadas.size() - 1);
						numeroCuenta = cuentaNueva.getNumeroCuenta();
						cbu = cuentaNueva.getCbu();

						// Si hay saldo inicial, depositarlo
						if (initialBalance.compareTo(BigDecimal.ZERO) > 0) {
							cuentaNegocio.depositarDinero(cuentaNueva.getIdCuenta(), initialBalance);
						}
					}
				}
			} catch (Exception e) {
				// Si falla, crear manualmente
				cuentaCreada = false;
			}

			// Si no funcionó, crear cuenta manualmente
			if (!cuentaCreada) {
				Cuenta nuevaCuenta = new Cuenta();
				nuevaCuenta.setIdCliente(clienteId);
				nuevaCuenta.setIdTipoCuenta(idTipoCuenta);
				nuevaCuenta.setNumeroCuenta(cuentaNegocio.generarNumeroCuenta());
				nuevaCuenta.setCbu(cuentaNegocio.generarCBU());
				nuevaCuenta.setSaldo(initialBalance);
				nuevaCuenta.setActiva(true);

				int resultado = cuentaNegocio.agregarCuenta(nuevaCuenta);
				cuentaCreada = (resultado > 0);
				numeroCuenta = nuevaCuenta.getNumeroCuenta();
				cbu = nuevaCuenta.getCbu();
			}

			if (cuentaCreada) {
				String tipoCuentaDesc = (idTipoCuenta == 1) ? "Cuenta de Ahorro" : "Cuenta Corriente";
				request.setAttribute("success", "Cuenta creada exitosamente. Tipo: " + tipoCuentaDesc + ", Número: "
						+ numeroCuenta + ", CBU: " + cbu);
			} else {
				request.setAttribute("error", "Error al crear la cuenta. Intente nuevamente.");
			}

		} catch (NumberFormatException e) {
			request.setAttribute("error", "Formato de número inválido");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error interno: " + e.getMessage());
		}

		// Recargar información del cliente actualizada
		String clienteIdStr = request.getParameter("clienteId");
		buscarYMostrarCliente(request, response, clienteIdStr);
	}

	private void desactivarCuenta(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String idCuentaStr = request.getParameter("idCuenta");
			String clienteIdStr = request.getParameter("clienteId");

			if (idCuentaStr == null || idCuentaStr.trim().isEmpty()) {
				request.setAttribute("error", "ID de cuenta inválido");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			int idCuenta = Integer.parseInt(idCuentaStr);

			// Verificar que la cuenta existe
			Cuenta cuenta = cuentaNegocio.buscarCuentaPorId(idCuenta);
			if (cuenta == null) {
				request.setAttribute("error", "Cuenta no encontrada");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			// Verificar que la cuenta esté activa
			if (!cuenta.isActiva()) {
				request.setAttribute("warning", "La cuenta ya está inactiva");
				buscarYMostrarCliente(request, response, clienteIdStr);
				return;
			}

			// Desactivar la cuenta
			boolean resultado = cuentaNegocio.desactivarCuenta(idCuenta);

			if (resultado) {
				request.setAttribute("success", "Cuenta " + cuenta.getNumeroCuenta() + " inhabilitada exitosamente");
			} else {
				request.setAttribute("error", "Error al inhabilitar la cuenta");
			}

		} catch (NumberFormatException e) {
			request.setAttribute("error", "Formato de número inválido");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error interno: " + e.getMessage());
		}

		// Recargar información del cliente
		String clienteIdStr = request.getParameter("clienteId");
		buscarYMostrarCliente(request, response, clienteIdStr);
	}

	private void buscarYMostrarCliente(HttpServletRequest request, HttpServletResponse response, String clienteIdStr)
			throws ServletException, IOException {

		try {
			Cliente cliente = clienteNegocio.buscarClientePorId(clienteIdStr);
			if (cliente != null) {

				List<Cuenta> cuentasCliente = cuentaNegocio.buscarCuentasPorCliente(cliente.getId());
				
				// Contar SOLO las cuentas ACTIVAS
				int cantidadCuentasActivas = 0;
				for (Cuenta cuenta : cuentasCliente) {
					if (cuenta.isActiva()) {
						cantidadCuentasActivas++;
					}
				}

				request.setAttribute("cliente", cliente);
				request.setAttribute("cuentasCliente", cuentasCliente);
				request.setAttribute("cantidadCuentasActivas", cantidadCuentasActivas);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error al cargar la información del cliente");
		}

		RequestDispatcher rd = request.getRequestDispatcher("AltaCuentaAdmin.jsp");
		rd.forward(request, response);
	}
}