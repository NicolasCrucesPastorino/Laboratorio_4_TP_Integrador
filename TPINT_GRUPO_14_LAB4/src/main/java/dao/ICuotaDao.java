package dao;

import java.math.BigDecimal;
import java.util.List;

import entidad.CuotaPrestamo;

public interface ICuotaDao {
	public List<CuotaPrestamo> listarporFecha(int mes, int año);
	public int contarCuotas(List<CuotaPrestamo> lista, String estado);
	public float montoTotal(List<CuotaPrestamo> lista, String estado);
	public float calcularGanacia(List<CuotaPrestamo> lista);

}
