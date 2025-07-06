package entidad;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDateTime;

public class Movimiento {
	
	private int id_movimiento;
	private Cuenta cuenta;
	private TipoMovimiento tipoMovimiento;
	private String concepto;
	private BigDecimal importe;
	private LocalDateTime fecha;
	private String detalle;
	
	public Movimiento() {
		
	}
	
	public Movimiento(int id_movimiento, Cuenta cuenta, TipoMovimiento tipoMovimiento, 
			String concepto, BigDecimal importe, LocalDateTime fecha, String detalle) {
		this.id_movimiento = id_movimiento;
		this.cuenta = cuenta;
		this.tipoMovimiento = tipoMovimiento;
		this.concepto = concepto;
		this.importe = importe;
		this.fecha = fecha;
		this.detalle = detalle;
	}

	public int getId_movimiento() {
		return id_movimiento;
	}

	public void setId_movimiento(int id_movimiento) {
		this.id_movimiento = id_movimiento;
	}

	public Cuenta getCuenta() {
		return cuenta;
	}

	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}

	public TipoMovimiento getTipoMovimiento() {
		return tipoMovimiento;
	}

	public void setTipoMovimiento(TipoMovimiento tipoMovimiento) {
		this.tipoMovimiento = tipoMovimiento;
	}

	public String getConcepto() {
		return concepto;
	}

	public void setConcepto(String concepto) {
		this.concepto = concepto;
	}

	public BigDecimal getImporte() {
		return importe;
	}

	public void setImporte(BigDecimal importe) {
		this.importe = importe;
	}

	public LocalDateTime getFecha() {
		return fecha;
	}

	public void setFecha(LocalDateTime fecha) {
		this.fecha = fecha;
	}

	public String getDetalle() {
		return detalle;
	}

	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
} 