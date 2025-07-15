package negocio;

import java.util.List;

import dao.ICuotaDao;
import daoImpl.CuotaPrestamoDaoImpl;
import entidad.CuotaPrestamo;

public class CuotaNegocioImpl implements ICuotaNegocio{
	
	private ICuotaDao cuotaDao = new CuotaPrestamoDaoImpl();

	@Override
	public List<CuotaPrestamo> listarporFecha(int mes, int año) {
		return cuotaDao.listarporFecha(mes, año);
	}

	@Override
	public int contarCuotas(List<CuotaPrestamo> lista, String estado) {
		return cuotaDao.contarCuotas(lista, estado);
	}

	@Override
	public float montoTotal(List<CuotaPrestamo> lista, String estado) {
		return cuotaDao.montoTotal(lista, estado);
	}

	@Override
	public float calcularGanacia(List<CuotaPrestamo> lista) {
		return cuotaDao.calcularGanacia(lista);
	}

}
