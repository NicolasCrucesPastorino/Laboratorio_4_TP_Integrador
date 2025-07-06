package dao;

import java.util.List;
import entidad.Movimiento;

public interface IMovimientoDao {
	
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta);
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta, int limite);
	public int agregarMovimiento(Movimiento movimiento);

} 