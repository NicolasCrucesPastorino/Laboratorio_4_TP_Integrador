package negocio;

import entidad.Localidad;
import java.util.List;

public interface ILocalidadNegocio {
	public Localidad buscarLocalidad(String localidad, int provincia);
	
 public List<Localidad> listarLocalidadesPorProvincia(int provinciaId);
}