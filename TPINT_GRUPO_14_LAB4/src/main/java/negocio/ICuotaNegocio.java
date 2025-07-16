package negocio;

import java.util.List;

import entidad.CuotaPrestamo;

public interface ICuotaNegocio {
	public List<CuotaPrestamo> listarporFecha(int mes, int año);
	public int contarCuotas(List<CuotaPrestamo> lista, String estado);
	public float montoTotal(List<CuotaPrestamo> lista, String estado);
	public float calcularGanacia(List<CuotaPrestamo> lista);
	public List<CuotaPrestamo> obtenerCuotasPorPrestamo(int idPrestamo);

}
