package negocio;

import java.util.List;
import dao.IProvinciaDao;
import daoImpl.ProvinciaDaoImpl;
import entidad.Provincia;

public class ProvinciaNegocioImpl implements IProvinciaNegocio {
	
	private IProvinciaDao provinciaDao = new ProvinciaDaoImpl();

	@Override
	public List<Provincia> listarProvincias() {
		return provinciaDao.listarProvincias();
	}
} 