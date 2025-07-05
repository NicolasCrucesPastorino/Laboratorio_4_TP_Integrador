package negocio;

import java.util.List;

import dao.ICuentaDao;
import daoImpl.CuentaDaoImpl;
import entidad.Cuenta;

public class CuentaNegocioImpl implements ICuentaNegocio{
	
	private ICuentaDao cuentaDao = new CuentaDaoImpl();

	@Override
	public boolean insertar(Cuenta cuenta) {
		return cuentaDao.insertar(cuenta);
	}

	@Override
	public boolean modificar(Cuenta cuenta) {
		return cuentaDao.modificar(cuenta);
	}

	@Override
	public boolean desactivar(int idCuenta) {
		return cuentaDao.desactivar(idCuenta);
	}

	@Override
	public boolean activar(int idCuenta) {
		return cuentaDao.activar(idCuenta);
	}

	@Override
	public Cuenta buscarporCBU(String cbu) {
		return cuentaDao.buscarporCBU(cbu);
	}

	@Override
	public List<Cuenta> listarporUsuario(int idusu) {
		return cuentaDao.listarporUsuario(idusu);
	}

	@Override
	public Cuenta obtenerPorId(int idCuenta) {
		return cuentaDao.obtenerPorId(idCuenta);
	}

}
