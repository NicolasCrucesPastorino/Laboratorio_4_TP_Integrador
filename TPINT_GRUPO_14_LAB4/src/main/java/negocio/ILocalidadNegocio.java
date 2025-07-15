package negocio;

import entidad.Localidad;

public interface ILocalidadNegocio {
	public Localidad buscarLocalidad(String localidad, int provincia);
} 