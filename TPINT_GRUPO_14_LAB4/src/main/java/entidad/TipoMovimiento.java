package entidad;

public class TipoMovimiento {
	
	private int id_tipo_movimiento;
	private String descripcion;
	private String tipo;
	private boolean activo;
	
	public TipoMovimiento() {
		
	}
	
	public TipoMovimiento(int id_tipo_movimiento, String descripcion, String tipo, boolean activo) {
		this.id_tipo_movimiento = id_tipo_movimiento;
		this.descripcion = descripcion;
		this.tipo = tipo;
		this.activo = activo;
	}

	public int getId_tipo_movimiento() {
		return id_tipo_movimiento;
	}

	public void setId_tipo_movimiento(int id_tipo_movimiento) {
		this.id_tipo_movimiento = id_tipo_movimiento;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public boolean isActivo() {
		return activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
	}
} 