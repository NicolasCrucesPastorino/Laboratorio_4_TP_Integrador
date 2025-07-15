package negocio;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import dao.IClienteDao;
import dao.ICuotaDao;
import dao.IPrestamoDAO;
import daoImpl.ClienteDaoImpl;
import daoImpl.CuotaPrestamoDaoImpl;
import daoImpl.PrestamoDao;
import entidad.Cliente;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;

public class PrestamoNegocio implements IPrestamoNegocio{

	private IPrestamoDAO prestamoDAO;
	private IClienteDao clienteDAO;
	private ICuotaDao cuotaDAO;
	
	public PrestamoNegocio() {
		this.prestamoDAO = new PrestamoDao();
		this.cuotaDAO = new CuotaPrestamoDaoImpl();
		this.clienteDAO = new ClienteDaoImpl();
	}
	
	@Override
	public void generarPrestamo(Prestamo prestamo) throws PrestamoException {
		Prestamo prestamoGenerado = this.prestamoDAO.crearPrestamo(prestamo);	
		
		for(int numeroCuota = 1; numeroCuota <= prestamo.getCantidadCuotas(); numeroCuota++){
			Calendar calendario = Calendar.getInstance();
			calendario.setTime(prestamoGenerado.getFechaPedido());
			
			calendario.add(Calendar.MONTH, numeroCuota);
			Date fechaVencimiento = calendario.getTime();
			
			CuotaPrestamo cuota = new CuotaPrestamo();
			cuota.setPrestamo(prestamoGenerado);
			cuota.setNumeroCuota(numeroCuota);
			cuota.setMontoCuota(prestamo.getMontoPorCuota());
			cuota.setFechaVencimiento(fechaVencimiento);
			cuota.setEstado("Pendiente");
			
			
			System.out.println(cuota.toString());
			
			this.cuotaDAO.CrearCuota(cuota);
		}
	}

	@Override
	public void pagarCuotaPrestamo(Prestamo prestamo, CuotaPrestamo cuota) throws PrestamoException {
		this.prestamoDAO.pagarCuota(prestamo, cuota);
	}

	@Override
	public List<Prestamo> getPrestamosDe(Usuario usuario) {
		Cliente cliente = clienteDAO.buscarClientePorUsuario(usuario.getId_usuario());
		System.out.println(cliente.getId());
		List<Prestamo> prestamos = this.prestamoDAO.listarPresetamos(cliente);
		System.out.println(prestamos.size());
		return prestamos;
					
	}
	
	@Override
	public List<Prestamo> getPrestamosPendientes() {
		return this.prestamoDAO.listarPrestamosPendientes();
	}
	
	@Override
	public void aprobarPrestamo(int idPrestamo, int idAdmin) throws PrestamoException {
		this.prestamoDAO.aprobarPrestamo(idPrestamo, idAdmin);
	}
	
	@Override
	public void rechazarPrestamo(int idPrestamo, int idAdmin, String observaciones) throws PrestamoException {
		this.prestamoDAO.rechazarPrestamo(idPrestamo, idAdmin, observaciones);
	}

	@Override
	public List<Prestamo> listarPresetamosporFecha(LocalDate fecha1, LocalDate fecha2) {
		return prestamoDAO.listarPresetamosporFecha(fecha1, fecha2);
	}

	@Override
	public int contarPrestamosporEstado(List<Prestamo> lista, String estado) {
		return prestamoDAO.contarPrestamosporEstado(lista, estado);
	}

}
