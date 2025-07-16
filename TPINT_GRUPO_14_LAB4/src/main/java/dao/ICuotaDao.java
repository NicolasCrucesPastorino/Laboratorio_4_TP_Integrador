package dao;

import java.util.List;

import entidad.CuotaPrestamo;;

public interface ICuotaDao {

	void CrearCuota(CuotaPrestamo cuotaPrestamo);

	void CancelarCuota(CuotaPrestamo cuotaPrestamo);

	public List<CuotaPrestamo> listarporFecha(int mes, int año);

	public int contarCuotas(List<CuotaPrestamo> lista, String estado);

	public float montoTotal(List<CuotaPrestamo> lista, String estado);

	public float calcularGanacia(List<CuotaPrestamo> lista);
	
	public List<CuotaPrestamo> obtenerCuotasPorPrestamo(int idPrestamo);
	
	public void pagarCuota(int idCuota);
	
	public CuotaPrestamo obtenerCuotaPorId(int idCuota);

}
