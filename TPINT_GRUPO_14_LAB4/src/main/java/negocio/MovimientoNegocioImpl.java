package negocio;

import java.util.List;

import dao.IMovimientoDao;
import daoImpl.MovimientoDaoImpl;
import entidad.Movimiento;

public class MovimientoNegocioImpl implements IMovimientoNegocio {
	
	private IMovimientoDao movimientoDao = new MovimientoDaoImpl();

	@Override
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta) {
		return movimientoDao.getMovimientosPorCuenta(idCuenta);
	}

	@Override
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta, int limite) {
		return movimientoDao.getMovimientosPorCuenta(idCuenta, limite);
	}

	@Override
	public int agregarMovimiento(Movimiento movimiento) {
		return movimientoDao.agregarMovimiento(movimiento);
	}

} 