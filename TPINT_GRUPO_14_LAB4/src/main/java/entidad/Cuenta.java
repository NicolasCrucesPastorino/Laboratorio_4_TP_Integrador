package entidad;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Cuenta {
    private int idCuenta;
    private int idCliente;
    private int idTipoCuenta;
    private String numeroCuenta;
    private String cbu;
    private BigDecimal saldo;
    private LocalDateTime fechaCreacion;
    private boolean activa;
    
    private Cliente cliente;
    private TipoCuenta tipoCuenta;
    
    public Cuenta() {
        this.saldo = BigDecimal.ZERO;
        this.fechaCreacion = LocalDateTime.now();
        this.activa = true;
    }
    
    public Cuenta(int idCliente, int idTipoCuenta, String numeroCuenta, String cbu) {
        this();
        this.idCliente = idCliente;
        this.idTipoCuenta = idTipoCuenta;
        this.numeroCuenta = numeroCuenta;
        this.cbu = cbu;
    }
    
    public Cuenta(int idCuenta, int idCliente, int idTipoCuenta, String numeroCuenta, 
                  String cbu, BigDecimal saldo, LocalDateTime fechaCreacion, boolean activa) {
        this.idCuenta = idCuenta;
        this.idCliente = idCliente;
        this.idTipoCuenta = idTipoCuenta;
        this.numeroCuenta = numeroCuenta;
        this.cbu = cbu;
        this.saldo = saldo;
        this.fechaCreacion = fechaCreacion;
        this.activa = activa;
    }
    
    public int getIdCuenta() {
        return idCuenta;
    }
    
    public void setIdCuenta(int idCuenta) {
        this.idCuenta = idCuenta;
    }
    
    public int getIdCliente() {
        return idCliente;
    }
    
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
    
    public int getIdTipoCuenta() {
        return idTipoCuenta;
    }
    
    public void setIdTipoCuenta(int idTipoCuenta) {
        this.idTipoCuenta = idTipoCuenta;
    }
    
    public String getNumeroCuenta() {
        return numeroCuenta;
    }
    
    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }
    
    public String getCbu() {
        return cbu;
    }
    
    public void setCbu(String cbu) {
        this.cbu = cbu;
    }
    
    public BigDecimal getSaldo() {
        return saldo;
    }
    
    public void setSaldo(BigDecimal saldo) {
        this.saldo = saldo;
    }
    
    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    public boolean isActiva() {
        return activa;
    }
    
    public void setActiva(boolean activa) {
        this.activa = activa;
    }
    
    public Cliente getCliente() {
        return cliente;
    }
    
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
    public TipoCuenta getTipoCuenta() {
        return tipoCuenta;
    }
    
    public void setTipoCuenta(TipoCuenta tipoCuenta) {
        this.tipoCuenta = tipoCuenta;
    }
    
 
    @Override
    public String toString() {
        return "Cuenta{" +
                "idCuenta=" + idCuenta +
                ", idCliente=" + idCliente +
                ", idTipoCuenta=" + idTipoCuenta +
                ", numeroCuenta='" + numeroCuenta + '\'' +
                ", cbu='" + cbu + '\'' +
                ", saldo=" + saldo +
                ", fechaCreacion=" + fechaCreacion +
                ", activa=" + activa +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Cuenta cuenta = (Cuenta) o;
        return idCuenta == cuenta.idCuenta;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(idCuenta);
    }
}