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
import entidad.Transferencia;
import entidad.Usuario;


@WebServlet("/ServletTransferencia")
public class ServletTransferencia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ServletTransferencia() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ICuentaNegocio cuentaNeg = new CuentaNegocioImpl();
		HttpSession session = request.getSession();
		Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
	    List<Cuenta> listaCuentas = cuentaNeg.listarporUsuario(usu.getId_usuario());
	    request.setAttribute("listaCuentas", listaCuentas);
	    RequestDispatcher rd = request.getRequestDispatcher("/Transferencia.jsp");   
	    rd.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("transferir")!=null) {
			ICuentaNegocio cuentaNeg = new CuentaNegocioImpl();
			ITransferenciaNegocio transNeg = new TranferenciaNegocio();
			HttpSession session = request.getSession();
			Usuario usu = (Usuario) session.getAttribute("usuarioLogueado");
		    List<Cuenta> listaCuentas = cuentaNeg.listarporUsuario(usu.getId_usuario());
			Cuenta origen = new Cuenta();
			Cuenta destino = cuentaNeg.buscarporCBU(request.getParameter("cbu"));
			BigDecimal importe = new BigDecimal(request.getParameter("importe"));
			String motivo = request.getParameter("motivo");
			for(Cuenta cuenta : listaCuentas){
				if(cuenta.getNumeroCuenta().equals(request.getParameter("cuentaOrigen"))) {
					origen = cuenta;
				}
			}
			if(!origen.getNumeroCuenta().equals(destino.getNumeroCuenta())) {
				if(destino != null) {
					if(importe.compareTo(origen.getSaldo()) <= 0) {
						transNeg.RealizarTransferencia(origen, destino, importe, motivo);
						
						RequestDispatcher rd = request.getRequestDispatcher("PrincipalCliente.jsp");   
				        rd.forward(request, response);
					}
					else {
						response.sendRedirect("PrincipalCliente.jsp?error=SaldoInsuficiente");
					}
				}
				else {
					response.sendRedirect("PrincipalCliente.jsp?error=CBUInexistente");
				}
			}
			else {
				response.sendRedirect("PrincipalCliente.jsp?error=CuentasOrigenyDestinoIguales");
			}
			
		}
	}

}
