package negocio;

import java.util.List;
import java.math.BigDecimal;
import entidad.Cuenta;

public interface ICuentaNegocio {
    
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
    public boolean validarSaldoSuficiente(int idCuenta, BigDecimal monto);
    
    public boolean actualizarSaldo(int idCuenta, BigDecimal nuevoSaldo);
    public BigDecimal obtenerSaldo(int idCuenta);
    public boolean depositarDinero(int idCuenta, BigDecimal monto);
    public boolean retirarDinero(int idCuenta, BigDecimal monto);
    public boolean transferirDinero(int idCuentaOrigen, int idCuentaDestino, BigDecimal monto);
    public boolean pagarCuotaPrestamo(int idCuenta, BigDecimal montoCuota);
    public int contarCuentasPorCliente(int idCliente);
    public int contarCuentasActivas();
    public float totalenSistema();
    
    // Util
    public String generarNumeroCuenta();
    public String generarCBU();
    public boolean crearCuentaCompleta(int idCliente, int idTipoCuenta);
    public String generarNumeroAleatorio(int longitud);
}