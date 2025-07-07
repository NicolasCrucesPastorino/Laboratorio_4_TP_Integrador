package negocio;

import dao.IPrestamoDAO;
import daoImpl.PrestamoDao;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import excepciones.PrestamoException;

public class PrestamoNegocio implements IPrestamoNegocio{

	private IPrestamoDAO prestamoDAO;
	
	public PrestamoNegocio() {
		this.prestamoDAO = new PrestamoDao();
	}
	
	@Override
	public void generarPrestamo(Prestamo prestamo) throws PrestamoException {
		this.prestamoDAO.crearPrestamo(prestamo);
		
	}

	@Override
	public void pagarCuotaPrestamo(Prestamo prestamo, CuotaPrestamo cuota) throws PrestamoException {
		this.prestamoDAO.pagarCuota(prestamo, cuota);
	}

}
