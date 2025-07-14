//package servlets;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import entidad.CuotaPrestamo;
//import entidad.ReporteCuotas;
//import negocio.ICuotaNegocio;
//
//
//@WebServlet("/ServletReportes")
//public class ServletReportes extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    
//    public ServletReportes() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//    
//    private ICuotaNegocio cuotaNeg = new CuotaNegocioImpl();
//	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//		
//		List<ReporteCuotas> lista = new ArrayList<ReporteCuotas>();
//		for(int i=1;i<=12;i++) {
//			List<CuotaPrestamo> lista2 = cuotaNeg.listarporFecha(i, Integer.parseInt(request.getParameter("año")));
//			ReporteCuotas rp = new ReporteCuotas();
//			rp.setMes(i);
//			rp.setCuotasPagas(cuotaNeg.contarCuotas(lista2, "Pagada"));
//			rp.setCuotasPendientes(cuotaNeg.contarCuotas(lista2, "Pendiente"));
//			rp.setTotalCobrado(cuotaNeg.montoTotal(lista2, "Pagada"));
//			rp.setTotalPendiente(cuotaNeg.montoTotal(lista2, "Pendiente"));
//			rp.setGanancia(cuotaNeg.calcularGanacia(lista2));
//			lista.add(rp);
//		}
//		request.setAttribute("listaCuotas", lista);
//	    RequestDispatcher rd = request.getRequestDispatcher("/Reportes.jsp");
//	    rd.forward(request, response);
//	    
//	}
//
//	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}
