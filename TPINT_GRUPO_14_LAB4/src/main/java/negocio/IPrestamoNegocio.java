package negocio;

import entidad.CuotaPrestamo;
import entidad.Prestamo;
import excepciones.PrestamoException;

public interface IPrestamoNegocio {
	void generarPrestamo(Prestamo prestamo) throws PrestamoException;
	void pagarCuotaPrestamo(Prestamo prestamo, CuotaPrestamo cuota)throws PrestamoException;
}
