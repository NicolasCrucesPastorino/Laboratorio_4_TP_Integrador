package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.IClienteDao;
import daoImpl.ClienteDaoImpl;
import entidad.Usuario;

/**
 * Servlet implementation class ServletCliente
 */
@WebServlet("/Cliente")
public class ServletCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private IClienteDao clienteDao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletCliente() {
        super();
        this.clienteDao = new ClienteDaoImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		Usuario usuarioLogueado = (Usuario)session.getAttribute("usuarioLogueado");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
