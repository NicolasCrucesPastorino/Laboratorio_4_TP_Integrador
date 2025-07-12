package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;
import negocio.IPrestamoNegocio;
import negocio.PrestamoNegocio;

@WebServlet("/SolicitudesPrestamo")
public class ServletSolicitudesPrestamo extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IPrestamoNegocio prestamoNegocio;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletSolicitudesPrestamo() {
        super();
        this.prestamoNegocio = new PrestamoNegocio();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Verificar si el usuario está logueado
        if (session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioLogueado");
        
        // Verificar si es administrador
        if (!"admin".equals(usuarioSesion.getTipo_usuario())) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            // Obtener lista de préstamos pendientes
            List<Prestamo> prestamosPendientes = prestamoNegocio.getPrestamosPendientes();
            
            // Enviar datos al JSP
            request.setAttribute("prestamosPendientes", prestamosPendientes);
            
            RequestDispatcher rd = request.getRequestDispatcher("SolicitudesPrestamo.jsp");
            rd.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar las solicitudes de préstamos");
            RequestDispatcher rd = request.getRequestDispatcher("SolicitudesPrestamo.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Verificar si el usuario está logueado
        if (session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioLogueado");
        
        // Verificar si es administrador
        if (!"admin".equals(usuarioSesion.getTipo_usuario())) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String idPrestamoStr = request.getParameter("idPrestamo");
        
        if (idPrestamoStr == null || idPrestamoStr.trim().isEmpty()) {
            response.sendRedirect("SolicitudesPrestamo");
            return;
        }
        
        try {
            int idPrestamo = Integer.parseInt(idPrestamoStr);
            
            if ("aprobar".equals(action)) {
                // Aprobar préstamo
                prestamoNegocio.aprobarPrestamo(idPrestamo, usuarioSesion.getId_usuario());
                request.setAttribute("mensaje", "Préstamo aprobado exitosamente");
                
            } else if ("rechazar".equals(action)) {
                // Rechazar préstamo
                String observaciones = request.getParameter("observaciones");
                if (observaciones == null || observaciones.trim().isEmpty()) {
                    observaciones = "Sin observaciones";
                }
                prestamoNegocio.rechazarPrestamo(idPrestamo, usuarioSesion.getId_usuario(), observaciones);
                request.setAttribute("mensaje", "Préstamo rechazado exitosamente");
            }
            
        } catch (PrestamoException e) {
            request.setAttribute("error", e.getMessage());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de préstamo inválido");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud");
        }
        
        // Redirigir a la página de solicitudes
        response.sendRedirect("SolicitudesPrestamo");
    }
} 