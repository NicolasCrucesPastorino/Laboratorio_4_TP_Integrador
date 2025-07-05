package entidad;

import java.math.BigDecimal;
import java.sql.Date;

public class Transferencia {
	
	private int id_transferencia;
	private Cuenta cuenta_origen;
	private Cuenta cuenta_destino;
	private String motivo;
	private BigDecimal importe;
	private Date fecha;
	private String estado;
	
	
	
	public Transferencia(int id_transferencia, Cuenta cuenta_origen, Cuenta cuenta_destino, String motivo,
			BigDecimal importe, Date fecha, String estado) {
		super();
		this.id_transferencia = id_transferencia;
		this.cuenta_origen = cuenta_origen;
		this.cuenta_destino = cuenta_destino;
		this.motivo = motivo;
		this.importe = importe;
		this.fecha = fecha;
		this.estado = estado;
	}
	
	
	public int getId_transferencia() {
		return id_transferencia;
	}
	public void setId_transferencia(int id_transferencia) {
		this.id_transferencia = id_transferencia;
	}
	public Cuenta getCuenta_origen() {
		return cuenta_origen;
	}
	public void setCuenta_origen(Cuenta cuenta_origen) {
		this.cuenta_origen = cuenta_origen;
	}
	public Cuenta getCuenta_destino() {
		return cuenta_destino;
	}
	public void setCuenta_destino(Cuenta cuenta_destino) {
		this.cuenta_destino = cuenta_destino;
	}
	public String getMotivo() {
		return motivo;
	}
	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}
	public BigDecimal getImporte() {
		return importe;
	}
	public void setImporte(BigDecimal importe) {
		this.importe = importe;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	
	

}
