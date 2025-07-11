package negocio;

import java.util.List;

import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;

public interface IPrestamoNegocio {
	void generarPrestamo(Prestamo prestamo) throws PrestamoException;
	List<Prestamo> getPrestamosDe(Usuario usuario);
	void pagarCuotaPrestamo(Prestamo prestamo, CuotaPrestamo cuota)throws PrestamoException;
}
