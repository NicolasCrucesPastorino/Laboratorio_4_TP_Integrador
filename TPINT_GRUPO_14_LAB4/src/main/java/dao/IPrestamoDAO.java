package dao;

import java.util.List;

import entidad.Cliente;
import entidad.Cuenta;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;

public interface IPrestamoDAO {
	Prestamo crearPrestamo(Prestamo prestamo) throws PrestamoException;
	void listarPrestamos();
	List<Prestamo> listarPresetamos(Cliente cliente);
	List<Prestamo> listarPrestamosPendientes();
	void buscarPrestamoPorId(int id);
	void pagarCuota(Prestamo prestamo, CuotaPrestamo cuota);
	void aprobarPrestamo(int idPrestamo, int idAdmin) throws PrestamoException;
	void rechazarPrestamo(int idPrestamo, int idAdmin, String observaciones) throws PrestamoException;
}