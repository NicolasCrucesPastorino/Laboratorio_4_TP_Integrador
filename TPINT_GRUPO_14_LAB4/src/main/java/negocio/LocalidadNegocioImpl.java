package negocio;

import java.util.List;

import dao.ILocalidadDao;
import daoImpl.LocalidadDaoImpl;
import entidad.Localidad;

public class LocalidadNegocioImpl implements ILocalidadNegocio {
	
	private ILocalidadDao localidadDao = new LocalidadDaoImpl();

	@Override
	public List<Localidad> listarLocalidadesPorProvincia(int provinciaId) {
		// TODO Auto-generated method stub
		return localidadDao.listarPorProvincia(provinciaId);
	}

	@Override
	public Localidad buscarLocalidad(String localidad, int provincia) {
		return localidadDao.buscarLocalidad(localidad, provincia);
	}
} 