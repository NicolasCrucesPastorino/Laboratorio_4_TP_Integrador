package dao;

import entidad.Cliente;
import entidad.Cuenta;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;

public interface IPrestamoDAO {
	void crearPrestamo(Prestamo prestamo) throws PrestamoException;
	void listarPrestamos();
	void listarPresetamos(Cliente cliente);
	void buscarPrestamoPorId(int id);
	void pagarCuota(Prestamo prestamo, CuotaPrestamo cuota);
}