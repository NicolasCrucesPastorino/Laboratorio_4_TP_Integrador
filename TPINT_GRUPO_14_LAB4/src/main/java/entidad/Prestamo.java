package entidad;

import java.util.Date;
import java.util.List;

public class Prestamo {
	private int id;
	private Cliente cliente;
	private Cuenta cuenta;
	private int cantidadCuotas;
	private float montoPorCuota;
	private float montoTotal;
	private float montoPedido;
	private boolean estado;
	private Date fechaPedido;
	private Date fechaAutorizacion;
	private Usuario autorizadoPorUsuario;
	private List<CuotaPrestamo> cuotas;
	
	
	public Prestamo(int id, Cliente cliente, Cuenta cuenta, int cantidadCuotas, float montoPorCuota, float montoTotal,
			float montoPedido, boolean estado, Date fechaPedido, Date fechaAutorizacion, Usuario autorizadoPorUsuario,
			List<CuotaPrestamo> cuotas) {
		super();
		this.id = id;
		this.cliente = cliente;
		this.cuenta = cuenta;
		this.cantidadCuotas = cantidadCuotas;
		this.montoPorCuota = montoPorCuota;
		this.montoTotal = montoTotal;
		this.montoPedido = montoPedido;
		this.estado = estado;
		this.fechaPedido = fechaPedido;
		this.fechaAutorizacion = fechaAutorizacion;
		this.autorizadoPorUsuario = autorizadoPorUsuario;
		this.cuotas = cuotas;
	}
	public Prestamo(Cliente cliente, Cuenta cuenta, int cantidadCuotas, float montoPorCuota, float montoTotal,
			float montoPedido, boolean estado, Date fechaPedido, Date fechaAutorizacion, Usuario autorizadoPorUsuario) {
		super();
		this.cliente = cliente;
		this.cuenta = cuenta;
		this.cantidadCuotas = cantidadCuotas;
		this.montoPorCuota = montoPorCuota;
		this.montoTotal = montoTotal;
		this.montoPedido = montoPedido;
		this.estado = estado;
		this.fechaPedido = fechaPedido;
		this.fechaAutorizacion = fechaAutorizacion;
		this.autorizadoPorUsuario = autorizadoPorUsuario;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public Cuenta getCuenta() {
		return cuenta;
	}
	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}
	public int getCantidadCuotas() {
		return cantidadCuotas;
	}
	public void setCantidadCuotas(int cantidadCuotas) {
		this.cantidadCuotas = cantidadCuotas;
	}
	public float getMontoPorCuota() {
		return montoPorCuota;
	}
	public void setMontoPorCuota(float montoPorCuota) {
		this.montoPorCuota = montoPorCuota;
	}
	public float getMontoTotal() {
		return montoTotal;
	}
	public void setMontoTotal(float montoTotal) {
		this.montoTotal = montoTotal;
	}
	public float getMontoPedido() {
		return montoPedido;
	}
	public void setMontoPedido(float montoPedido) {
		this.montoPedido = montoPedido;
	}
	public boolean isEstado() {
		return estado;
	}
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	public Date getFechaPedido() {
		return fechaPedido;
	}
	public void setFechaPedido(Date fechaPedido) {
		this.fechaPedido = fechaPedido;
	}
	public Date getFechaAutorizacion() {
		return fechaAutorizacion;
	}
	public void setFechaAutorizacion(Date fechaAutorizacion) {
		this.fechaAutorizacion = fechaAutorizacion;
	}
	public Usuario getAutorizadoPorUsuario() {
		return autorizadoPorUsuario;
	}
	public void setAutorizadoPorUsuario(Usuario autorizadoPorUsuario) {
		this.autorizadoPorUsuario = autorizadoPorUsuario;
	}
	public List<CuotaPrestamo> getCuotas() {
		return cuotas;
	}
	public void setCuotas(List<CuotaPrestamo> cuotas) {
		this.cuotas = cuotas;
	}
	
	
}
