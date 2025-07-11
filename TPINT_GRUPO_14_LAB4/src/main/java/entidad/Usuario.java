package entidad;

public class Usuario {
    private int id_usuario;
    private String usuario;
    private String contrasena;
    private String tipo_usuario;
    private boolean activo;

    // Getters y Setters

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

	@Override
	public String toString() {
		return "Usuario [id_usuario=" + id_usuario + ", usuario=" + usuario + ", contrasena=" + contrasena
				+ ", tipo_usuario=" + tipo_usuario + ", activo=" + activo + "]";
	}
    
    
}
