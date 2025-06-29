package dao;

import entidad.Cuenta;

public interface ICuentaDao {
    
    boolean insertar(Cuenta cuenta);
    boolean modificar(Cuenta cuenta);
    boolean desactivar(int idCuenta);
    boolean activar(int idCuenta);
    
    Cuenta obtenerPorId(int idCuenta);
}