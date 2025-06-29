package negocio;

import dao.IUsuarioDao;
import daoImpl.UsuarioDaoImpl;
import entidad.Usuario;

public class UsuarioNegocioImpl implements IUsuarioNegocio {

    private IUsuarioDao usuarioDao = new UsuarioDaoImpl();

    @Override
    public Usuario validarUsuario(String usuario, String contrasena) {
        return usuarioDao.validarUsuario(usuario, contrasena);
    }

	@Override
	public int agregarUsuario(Usuario usuario) {
		return usuarioDao.agregarUsuario(usuario);
	}

	@Override
	public boolean verificarUsuarioExistente(String usuario) {
		return usuarioDao.verificarUsuarioExistente(usuario);
	}
}
