package dao;

import entidad.Usuario;

public interface IUsuarioDao {
    public Usuario validarUsuario(String usuario, String password);
    public int agregarUsuario(Usuario usuario);
    public boolean verificarUsuarioExistente(String usuario);
    public int ultimoID();
}
