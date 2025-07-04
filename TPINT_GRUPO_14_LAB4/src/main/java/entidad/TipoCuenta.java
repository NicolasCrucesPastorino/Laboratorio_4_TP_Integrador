package entidad;

import java.math.BigDecimal;

public class TipoCuenta {
    private int idTipoCuenta;
    private String descripcion;
    private boolean activo;
    
    public TipoCuenta() {
        this.activo = true;
    }
    
    public TipoCuenta(String descripcion) {
        this();
        this.descripcion = descripcion;
    }
    
    public TipoCuenta(int idTipoCuenta, String descripcion, boolean activo) {
        this.idTipoCuenta = idTipoCuenta;
        this.descripcion = descripcion;
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