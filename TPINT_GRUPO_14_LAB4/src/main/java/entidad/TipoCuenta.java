package entidad;

import java.math.BigDecimal;

public class TipoCuenta {
    private int idTipoCuenta;
    private String descripcion;
    private BigDecimal interes;
    private boolean activo;
    
    public TipoCuenta() {
        this.interes = BigDecimal.ZERO;
        this.activo = true;
    }
    
    public TipoCuenta(String descripcion, BigDecimal interes) {
        this();
        this.descripcion = descripcion;
        this.interes = interes;
    }
    
    public TipoCuenta(int idTipoCuenta, String descripcion, BigDecimal interes, boolean activo) {
        this.idTipoCuenta = idTipoCuenta;
        this.descripcion = descripcion;
        this.interes = interes;
        this.activo = activo;
    }
    
    // Getters y Setters
    public int getIdTipoCuenta() {
        return idTipoCuenta;
    }
    
    public void setIdTipoCuenta(int idTipoCuenta) {
        this.idTipoCuenta = idTipoCuenta;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public BigDecimal getInteres() {
        return interes;
    }
    
    public void setInteres(BigDecimal interes) {
        this.interes = interes;
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    @Override
    public String toString() {
        return "TipoCuenta{" +
                "idTipoCuenta=" + idTipoCuenta +
                ", descripcion='" + descripcion + '\'' +
                ", interes=" + interes +
                ", activo=" + activo +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        TipoCuenta that = (TipoCuenta) o;
        return idTipoCuenta == that.idTipoCuenta;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(idTipoCuenta);
    }
}