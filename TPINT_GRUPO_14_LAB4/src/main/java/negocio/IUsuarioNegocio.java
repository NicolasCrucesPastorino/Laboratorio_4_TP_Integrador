package negocio;

import entidad.Usuario;


public interface IUsuarioNegocio {
    public Usuario validarUsuario(String usuario, String contrasena);
    public Usuario obtenerUsuario(String usuario, String contrasena);
    public int agregarUsuario(Usuario usuario);
    public boolean verificarUsuarioExistente(String usuario);
    
}
