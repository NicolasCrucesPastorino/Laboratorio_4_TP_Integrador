package negocio;

import java.util.List;
import entidad.Movimiento;

public interface IMovimientoNegocio {
	
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta);
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta, int limite);
	public int agregarMovimiento(Movimiento movimiento);

} 