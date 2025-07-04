package dao;

import java.util.List;

import entidad.Provincia;

public interface IProvinciaDao {
	
	List<Provincia> listarProvincias();
	Provincia obtenerProvinciaPorId(int id);


}