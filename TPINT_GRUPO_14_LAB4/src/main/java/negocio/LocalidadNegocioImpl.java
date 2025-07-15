package negocio;

import dao.ILocalidadDao;
import daoImpl.LocalidadDaoImpl;
import entidad.Localidad;

public class LocalidadNegocioImpl implements ILocalidadNegocio {
	
	private ILocalidadDao localidadDao = new LocalidadDaoImpl();

	@Override
	public Localidad buscarLocalidad(String localidad, int provincia) {
		return localidadDao.buscarLocalidad(localidad, provincia);
	}
} 