package servlets;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.ReporteCuotas;
import entidad.ReporteTransferencia;
import entidad.ReporteAprobacion;
import negocio.CuotaNegocioImpl;
import negocio.ICuotaNegocio;
import negocio.IPrestamoNegocio;
import negocio.PrestamoNegocio;
import negocio.ITransferenciaNegocio;
import negocio.TranferenciaNegocio;


@WebServlet("/ServletReportes")
public class ServletReportes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ServletReportes() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    private ICuotaNegocio cuotaNeg = new CuotaNegocioImpl();
    private IPrestamoNegocio pNeg = new PrestamoNegocio();
    private ITransferenciaNegocio tNeg = new TranferenciaNegocio();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		List<ReporteCuotas> lista = new ArrayList<ReporteCuotas>();
		for(int i=1;i<=12;i++) {
			List<CuotaPrestamo> lista2 = cuotaNeg.listarporFecha(i, Integer.parseInt(request.getParameter("año")));
			ReporteCuotas rp = new ReporteCuotas();
			rp.setMes(i);
			rp.setCuotasPagas(cuotaNeg.contarCuotas(lista2, "Pagada"));
			rp.setCuotasPendientes(cuotaNeg.contarCuotas(lista2, "Pendiente"));
			rp.setTotalCobrado(cuotaNeg.montoTotal(lista2, "Pagada"));
			rp.setTotalPendiente(cuotaNeg.montoTotal(lista2, "Pendiente"));
			rp.setGanancia(cuotaNeg.calcularGanacia(lista2));
			lista.add(rp);
		}
		request.setAttribute("listaCuotas", lista);
		
	    RequestDispatcher rd = request.getRequestDispatcher("/Reportes.jsp");
	    rd.forward(request, response);
	    
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("fecha1")!=null && request.getParameter("fecha2")!=null) {
			ReporteAprobacion ap = new ReporteAprobacion();
			List<Prestamo> listaP = pNeg.listarPresetamosporFecha(LocalDate.parse(request.getParameter("fecha1")), LocalDate.parse(request.getParameter("fecha2")));
			if(listaP.size()!=0) {
				float porcAp = pNeg.contarPrestamosporEstado(listaP, "Aprobado") * 100 / listaP.size();
				float porcPe = pNeg.contarPrestamosporEstado(listaP, "pendiente") * 100 / listaP.size();
				float porcRe = pNeg.contarPrestamosporEstado(listaP, "Rechazado") * 100 / listaP.size();
				ap.setPrestamos(listaP.size());
				ap.setPrestamosAprobados(pNeg.contarPrestamosporEstado(listaP, "Aprobado"));
				ap.setPrestamosPendientes(pNeg.contarPrestamosporEstado(listaP, "pendiente"));
				ap.setPrestamosRechazados(pNeg.contarPrestamosporEstado(listaP, "Rechazado"));
				ap.setPorcentajeAprobados(porcAp);
				ap.setPorcentajePendientes(porcPe);
				ap.setPorcentajeRechazados(porcRe);
				request.setAttribute("Aprobacion", ap);
			}
		}
		
		
		if(request.getParameter("ano")!=null) {
			if(request.getParameter("mes")!=null) {
				ReporteTransferencia rt = new ReporteTransferencia();
				rt.setTransferenciasAño(tNeg.transferencias(Integer.parseInt(request.getParameter("ano")), 0, "año"));
				rt.setTransferenciasMes(tNeg.transferencias(0, Integer.parseInt(request.getParameter("mes")), "mes"));
				rt.setTotalAño(tNeg.totalTransferido(Integer.parseInt(request.getParameter("ano")), 0, "año"));
				rt.setTotalMes(tNeg.totalTransferido(0, Integer.parseInt(request.getParameter("mes")), "mes"));
				rt.setMaximoAño(tNeg.maximoTransferido(Integer.parseInt(request.getParameter("ano")), 0, "año"));
				rt.setMaximoMes(tNeg.maximoTransferido(0, Integer.parseInt(request.getParameter("mes")), "mes"));
				rt.setPromedioAño(tNeg.promedioTransferido(Integer.parseInt(request.getParameter("ano")), 0, "año"));
				rt.setPromedioMes(tNeg.promedioTransferido(0, Integer.parseInt(request.getParameter("mes")), "mes"));
				request.setAttribute("Transferencias", rt);
			}
			
		}
		
		
	    RequestDispatcher rd = request.getRequestDispatcher("/Reportes.jsp");
	    rd.forward(request, response);
	}

}
