package dao;



import entidad.CuotaPrestamo;;

public interface ICuotaDao {	
	
	void CrearCuota(CuotaPrestamo cuotaPrestamo);
	void CancelarCuota(CuotaPrestamo cuotaPrestamo);
}
