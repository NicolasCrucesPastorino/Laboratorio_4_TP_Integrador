package negocio;

import java.util.ArrayList;
import java.util.List;

import dao.IClienteDao;
import dao.IPrestamoDAO;
import daoImpl.ClienteDaoImpl;
import daoImpl.PrestamoDao;
import entidad.Cliente;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;

public class PrestamoNegocio implements IPrestamoNegocio{

	private IPrestamoDAO prestamoDAO;
	private IClienteDao clienteDAO;
	
	public PrestamoNegocio() {
		this.prestamoDAO = new PrestamoDao();
		this.clienteDAO = new ClienteDaoImpl();
	}
	
	@Override
	public void generarPrestamo(Prestamo prestamo) throws PrestamoException {
		this.prestamoDAO.crearPrestamo(prestamo);
		
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

}
