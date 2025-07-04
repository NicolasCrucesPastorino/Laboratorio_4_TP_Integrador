package dao;

import java.util.List;

import entidad.Localidad;

public interface ILocalidadDao {

	List<Localidad> listarLocalidades();
	List<Localidad> listarPorProvincia(int idProvincia);
	Localidad obtenerLocalidadPorId(int id);
}
