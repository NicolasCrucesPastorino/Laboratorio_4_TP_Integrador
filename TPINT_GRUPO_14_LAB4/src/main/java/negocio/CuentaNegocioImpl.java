package negocio;

import java.util.List;
import java.math.BigDecimal;

import dao.ICuentaDao;
import daoImpl.CuentaDaoImpl;
import entidad.Cuenta;

public class CuentaNegocioImpl implements ICuentaNegocio {
    
    private ICuentaDao cuentaDao = new CuentaDaoImpl();

    @Override
    public int agregarCuenta(Cuenta cuenta) {
        // Validaciones de negocio antes de agregar
        if (cuenta == null) {
            throw new IllegalArgumentException("La cuenta no puede ser nula");
        }
        
        if (cuenta.getIdCliente() <= 0) {
            throw new IllegalArgumentException("El ID del cliente debe ser válido");
        }
        
        if (cuenta.getIdTipoCuenta() <= 0) {
            throw new IllegalArgumentException("El tipo de cuenta debe ser válido");
        }
        
        // Generar número de cuenta y CBU si no están establecidos
        if (cuenta.getNumeroCuenta() == null || cuenta.getNumeroCuenta().isEmpty()) {
            cuenta.setNumeroCuenta(generarNumeroCuenta());
        }
        
        if (cuenta.getCbu() == null || cuenta.getCbu().isEmpty()) {
            cuenta.setCbu(generarCBU());
        }
        
        // Validar que no existan duplicados
        if (existeNumeroCuenta(cuenta.getNumeroCuenta())) {
            throw new IllegalArgumentException("El número de cuenta ya existe");
        }
        
        if (existeCBU(cuenta.getCbu())) {
            throw new IllegalArgumentException("El CBU ya existe");
        }
        
        // Establecer saldo inicial si no está establecido
        if (cuenta.getSaldo() == null) {
            cuenta.setSaldo(BigDecimal.ZERO);
        }
        
        return cuentaDao.agregarCuenta(cuenta);
    }

    @Override
    public boolean modificarCuenta(Cuenta cuenta) {
        if (cuenta == null || cuenta.getIdCuenta() <= 0) {
            return false;
        }
        
        // Validar que la cuenta existe
        Cuenta cuentaExistente = cuentaDao.buscarCuentaPorId(cuenta.getIdCuenta());
        if (cuentaExistente == null) {
            return false;
        }
        
        return cuentaDao.modificarCuenta(cuenta);
    }

    @Override
    public boolean eliminarCuenta(int idCuenta) {
        if (idCuenta <= 0) {
            return false;
        }
        
        // Validar que la cuenta existe
        Cuenta cuenta = cuentaDao.buscarCuentaPorId(idCuenta);
        if (cuenta == null) {
            return false;
        }
        
        // Verificar que el saldo sea cero antes de eliminar
        if (cuenta.getSaldo().compareTo(BigDecimal.ZERO) != 0) {
            throw new IllegalStateException("No se puede eliminar una cuenta con saldo diferente a cero");
        }
        
        return cuentaDao.eliminarCuenta(idCuenta);
    }

    @Override
    public boolean desactivarCuenta(int idCuenta) {
        if (idCuenta <= 0) {
            return false;
        }
        
        return cuentaDao.desactivarCuenta(idCuenta);
    }

    @Override
    public boolean activarCuenta(int idCuenta) {
        if (idCuenta <= 0) {
            return false;
        }
        
        return cuentaDao.activarCuenta(idCuenta);
    }

    @Override
    public Cuenta buscarCuentaPorId(int idCuenta) {
        if (idCuenta <= 0) {
            return null;
        }
        
        return cuentaDao.buscarCuentaPorId(idCuenta);
    }

    @Override
    public Cuenta buscarCuentaPorCBU(String cbu) {
        if (cbu == null || cbu.trim().isEmpty()) {
            return null;
        }
        
        return cuentaDao.buscarCuentaPorCBU(cbu);
    }

    @Override
    public Cuenta buscarCuentaPorNumero(String numeroCuenta) {
        if (numeroCuenta == null || numeroCuenta.trim().isEmpty()) {
            return null;
        }
        
        return cuentaDao.buscarCuentaPorNumero(numeroCuenta);
    }

    @Override
    public List<Cuenta> buscarCuentasPorCliente(int idCliente) {
        if (idCliente <= 0) {
            return null;
        }
        
        return cuentaDao.buscarCuentasPorCliente(idCliente);
    }

    @Override
    public List<Cuenta> buscarCuentasPorDNI(String dni) {
        if (dni == null || dni.trim().isEmpty()) {
            return null;
        }
        
        return cuentaDao.buscarCuentasPorDNI(dni);
    }

    @Override
    public List<Cuenta> buscarCuentasPorTipo(int idTipoCuenta) {
        if (idTipoCuenta <= 0) {
            return null;
        }
        
        return cuentaDao.buscarCuentasPorTipo(idTipoCuenta);
    }

    @Override
    public List<Cuenta> getAllCuentas() {
        return cuentaDao.getAllCuentas();
    }

    @Override
    public List<Cuenta> getCuentasActivas() {
        return cuentaDao.getCuentasActivas();
    }

    @Override
    public List<Cuenta> getCuentasInactivas() {
        return cuentaDao.getCuentasInactivas();
    }

    @Override
    public List<Cuenta> getCuentasPorUsuario(int idUsuario) {
        if (idUsuario <= 0) {
            return null;
        }
        
        return cuentaDao.getCuentasPorUsuario(idUsuario);
    }

    @Override
    public boolean existeCBU(String cbu) {
        if (cbu == null || cbu.trim().isEmpty()) {
            return false;
        }
        
        return cuentaDao.existeCBU(cbu);
    }

    @Override
    public boolean existeNumeroCuenta(String numeroCuenta) {
        if (numeroCuenta == null || numeroCuenta.trim().isEmpty()) {
            return false;
        }
        
        return cuentaDao.existeNumeroCuenta(numeroCuenta);
    }

    @Override
    public boolean cuentaEstaActiva(int idCuenta) {
        if (idCuenta <= 0) {
            return false;
        }
        
        return cuentaDao.cuentaEstaActiva(idCuenta);
    }

    @Override
    public boolean validarSaldoSuficiente(int idCuenta, BigDecimal monto) {
        if (idCuenta <= 0 || monto == null || monto.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        BigDecimal saldoActual = cuentaDao.obtenerSaldo(idCuenta);
        return saldoActual.compareTo(monto) >= 0;
    }

    @Override
    public boolean actualizarSaldo(int idCuenta, BigDecimal nuevoSaldo) {
        if (idCuenta <= 0 || nuevoSaldo == null || nuevoSaldo.compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }
        
        return cuentaDao.actualizarSaldo(idCuenta, nuevoSaldo);
    }

    @Override
    public BigDecimal obtenerSaldo(int idCuenta) {
        if (idCuenta <= 0) {
            return BigDecimal.ZERO;
        }
        
        return cuentaDao.obtenerSaldo(idCuenta);
    }

    @Override
    public boolean depositarDinero(int idCuenta, BigDecimal monto) {
        if (idCuenta <= 0 || monto == null || monto.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        // Verificar que la cuenta existe y está activa
        if (!cuentaEstaActiva(idCuenta)) {
            return false;
        }
        
        BigDecimal saldoActual = cuentaDao.obtenerSaldo(idCuenta);
        BigDecimal nuevoSaldo = saldoActual.add(monto);
        
        return cuentaDao.actualizarSaldo(idCuenta, nuevoSaldo);
    }

    @Override
    public boolean retirarDinero(int idCuenta, BigDecimal monto) {
        if (idCuenta <= 0 || monto == null || monto.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        // Verificar que la cuenta existe y está activa
        if (!cuentaEstaActiva(idCuenta)) {
            return false;
        }
        
        // Verificar que hay saldo suficiente
        if (!validarSaldoSuficiente(idCuenta, monto)) {
            return false;
        }
        
        BigDecimal saldoActual = cuentaDao.obtenerSaldo(idCuenta);
        BigDecimal nuevoSaldo = saldoActual.subtract(monto);
        
        return cuentaDao.actualizarSaldo(idCuenta, nuevoSaldo);
    }

    @Override
    public boolean transferirDinero(int idCuentaOrigen, int idCuentaDestino, BigDecimal monto) {
        if (idCuentaOrigen <= 0 || idCuentaDestino <= 0 || monto == null || monto.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        // Verificar que no se transfiera a la misma cuenta
        if (idCuentaOrigen == idCuentaDestino) {
            return false;
        }
        
        // Verificar que ambas cuentas existen y están activas
        if (!cuentaEstaActiva(idCuentaOrigen) || !cuentaEstaActiva(idCuentaDestino)) {
            return false;
        }
        
        // Verificar saldo suficiente en cuenta origen
        if (!validarSaldoSuficiente(idCuentaOrigen, monto)) {
            return false;
        }
        
        // Realizar la transferencia (debitar de origen y acreditar en destino)
        if (retirarDinero(idCuentaOrigen, monto)) {
            if (depositarDinero(idCuentaDestino, monto)) {
                return true;
            } else {
                // Si falla el depósito, revertir el retiro
                depositarDinero(idCuentaOrigen, monto);
                return false;
            }
        }
        
        return false;
    }

    @Override
    public int contarCuentasPorCliente(int idCliente) {
        if (idCliente <= 0) {
            return 0;
        }
        
        return cuentaDao.contarCuentasPorCliente(idCliente);
    }

    @Override
    public String generarCBU() {
        return cuentaDao.generarCBU();
    }

    @Override
    public String generarNumeroCuenta() {
        return cuentaDao.generarNumeroCuenta();
    }
    
    @Override
    public String generarNumeroAleatorio(int longitud) {
		return cuentaDao.generarNumeroAleatorio(longitud);
	}
    
    @Override
    public boolean crearCuentaCompleta(int idCliente, int idTipoCuenta) {
        if (idCliente <= 0 || idTipoCuenta <= 0) {
            return false;
        }
        
        // Verificar límite de cuentas por cliente (ejemplo: máximo 3 cuentas)
        int cuentasExistentes = contarCuentasPorCliente(idCliente);
        if (cuentasExistentes >= 3) {
            throw new IllegalStateException("El cliente ya tiene el máximo de cuentas permitidas");
        }
        
        // Crear nueva cuenta
        Cuenta nuevaCuenta = new Cuenta();
        nuevaCuenta.setIdCliente(idCliente);
        nuevaCuenta.setIdTipoCuenta(idTipoCuenta);
        nuevaCuenta.setNumeroCuenta(generarNumeroCuenta());
        nuevaCuenta.setCbu(generarCBU());
        nuevaCuenta.setSaldo(BigDecimal.ZERO);
        nuevaCuenta.setActiva(true);
        
        return agregarCuenta(nuevaCuenta) > 0;
    }
}