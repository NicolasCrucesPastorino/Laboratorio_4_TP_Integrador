package entidad;

import java.util.Date;

public class CuotaPrestamo {
	private int id;
	private int numeroCuota;
	private float montoCuota;
	private Date fechaVencimiento;
	private Date fechaPago;
	private boolean estado;
	private Cuenta cuentaPago;
	

	public CuotaPrestamo(int numeroCuota, float montoCuota, Date fechaVencimiento, Date fechaPago, boolean estado,
			Cuenta cuentaPago) {
		super();
		this.numeroCuota = numeroCuota;
		this.montoCuota = montoCuota;
		this.fechaVencimiento = fechaVencimiento;
		this.fechaPago = fechaPago;
		this.estado = estado;
		this.cuentaPago = cuentaPago;
	}
	public CuotaPrestamo(int id, int numeroCuota, float montoCuota, Date fechaVencimiento, Date fechaPago,
			boolean estado, Cuenta cuentaPago) {
		super();
		this.id = id;
		this.numeroCuota = numeroCuota;
		this.montoCuota = montoCuota;
		this.fechaVencimiento = fechaVencimiento;
		this.fechaPago = fechaPago;
		this.estado = estado;
		this.cuentaPago = cuentaPago;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getNumeroCuota() {
		return numeroCuota;
	}
	public void setNumeroCuota(int numeroCuota) {
		this.numeroCuota = numeroCuota;
	}
	public float getMontoCuota() {
		return montoCuota;
	}
	public void setMontoCuota(float montoCuota) {
		this.montoCuota = montoCuota;
	}
	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public Date getFechaPago() {
		return fechaPago;
	}
	public void setFechaPago(Date fechaPago) {
		this.fechaPago = fechaPago;
	}
	public boolean isEstado() {
		return estado;
	}
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	public Cuenta getCuentaPago() {
		return cuentaPago;
	}
	public void setCuentaPago(Cuenta cuentaPago) {
		this.cuentaPago = cuentaPago;
	}
	
	
}
