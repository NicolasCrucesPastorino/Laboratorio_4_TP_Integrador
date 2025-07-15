package negocio;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;

public interface IPrestamoNegocio {
	void generarPrestamo(Prestamo prestamo) throws PrestamoException;
	List<Prestamo> getPrestamosDe(Usuario usuario);
	List<Prestamo> getPrestamosPendientes();
	void pagarCuotaPrestamo(Prestamo prestamo, CuotaPrestamo cuota)throws PrestamoException;
	void aprobarPrestamo(int idPrestamo, int idAdmin) throws PrestamoException;
	void rechazarPrestamo(int idPrestamo, int idAdmin, String observaciones) throws PrestamoException;
	List<Prestamo> listarPresetamosporFecha(LocalDate fecha1, LocalDate fecha2);
	int contarPrestamosporEstado(List<Prestamo> lista, String estado);
}
