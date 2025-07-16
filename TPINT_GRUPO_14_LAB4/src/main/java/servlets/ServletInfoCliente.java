package servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import entidad.Usuario;
import negocio.IClienteNegocio;

@WebServlet("/InfoCliente")
public class ServletInfoCliente extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IClienteNegocio clienteNegocio;
    
    public ServletInfoCliente() {
        super();
        this.clienteNegocio = new negocio.ClienteNegocioImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("Login.jsp");
            return;            
        }
        
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        
        try {
            // Obtener el cliente basándose en el usuario logueado
            Cliente cliente = clienteNegocio.buscarClientePorUsuario(usuarioLogueado.getId_usuario());
            
            request.setAttribute("cliente", cliente);
            request.setAttribute("usuarioLogueado", usuarioLogueado);
            
            RequestDispatcher rd = request.getRequestDispatcher("InfoCliente.jsp");
            rd.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar la información del cliente: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("InfoCliente.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 