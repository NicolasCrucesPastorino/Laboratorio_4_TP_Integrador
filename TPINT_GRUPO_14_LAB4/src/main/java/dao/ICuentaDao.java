package dao;

import java.util.List;

import entidad.Cuenta;

public interface ICuentaDao {
    
    boolean insertar(Cuenta cuenta);
    boolean modificar(Cuenta cuenta);
    boolean desactivar(int idCuenta);
    boolean activar(int idCuenta);
    Cuenta buscarporCBU(String cbu);
    List<Cuenta> listarporUsuario(int idusu);
    
    Cuenta obtenerPorId(int idCuenta);
    public String generarNumeroAleatorio(int longitud);
}