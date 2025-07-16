package dao;

import java.util.List;
import entidad.Cuenta;

public interface ICuentaDao {
    
    public int agregarCuenta(Cuenta cuenta);
    public boolean modificarCuenta(Cuenta cuenta);
    public boolean eliminarCuenta(int idCuenta);
    public boolean desactivarCuenta(int idCuenta);
    public boolean activarCuenta(int idCuenta);
    
    // Búsquedas
    public Cuenta buscarCuentaPorId(int idCuenta);
    public Cuenta buscarCuentaPorCBU(String cbu);
    public Cuenta buscarCuentaPorNumero(String numeroCuenta);
    public List<Cuenta> buscarCuentasPorCliente(int idCliente);
    public List<Cuenta> buscarCuentasPorDNI(String dni);
    public List<Cuenta> buscarCuentasPorTipo(int idTipoCuenta);
    
    // Listados
    public List<Cuenta> getAllCuentas();
    public List<Cuenta> getCuentasActivas();
    public List<Cuenta> getCuentasInactivas();
    public List<Cuenta> getCuentasPorUsuario(int idUsuario);
    
    // Validaciones
    public boolean existeCBU(String cbu);
    public boolean existeNumeroCuenta(String numeroCuenta);
    public boolean cuentaEstaActiva(int idCuenta);
    
    public boolean actualizarSaldo(int idCuenta, java.math.BigDecimal nuevoSaldo);
    public java.math.BigDecimal obtenerSaldo(int idCuenta);
    public boolean restarSaldo(int idCuenta, java.math.BigDecimal monto);
    public int contarCuentasPorCliente(int idCliente);
    public int contarCuentasActivas();
    public float totalenSistema();
    
    // Utilidades
    public String generarNumeroCuenta();
    public int ultimoID();
    public String generarCBU();
	public String generarNumeroAleatorio(int longitud);
}