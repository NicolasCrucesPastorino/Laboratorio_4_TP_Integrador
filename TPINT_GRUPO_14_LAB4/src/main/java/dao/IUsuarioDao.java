package dao;

import entidad.Usuario;

public interface IUsuarioDao {
    public Usuario validarUsuario(String usuario, String contrasena);
    public Usuario obtenerUsuario(String usuario, String contrasena);
    public int agregarUsuario(Usuario usuario);
    public boolean verificarUsuarioExistente(String usuario);
    public int ultimoID();
    public int actualizarEstadoActivo(int idUsuario, boolean activo);
}
