package daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dao.IUsuarioDao;
import entidad.Usuario;
import util.Conexion;

public class UsuarioDaoImpl implements IUsuarioDao {

    @Override
    public Usuario validarUsuario(String usuario, String password) {
        Usuario usu = null;
        String query = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ? AND activo = 1";
        
        try (PreparedStatement pst = Conexion.getConexion().prepareStatement(query)) {
            pst.setString(1, usuario);
            pst.setString(2, password);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    usu = new Usuario();
                    usu.setId_usuario(rs.getInt("id_usuario"));
                    usu.setUsuario(rs.getString("usuario"));
                    usu.setContrasena(rs.getString("contrasena"));
                    usu.setTipo_usuario(rs.getString("tipo_usuario"));
                    usu.setActivo(rs.getInt("activo") == 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return usu;
    }
    
    @Override
    public Usuario obtenerUsuario(String usuario, String password) {
        Usuario usu = null;
        String query = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ?";
        
        try (PreparedStatement pst = Conexion.getConexion().prepareStatement(query)) {
            pst.setString(1, usuario);
            pst.setString(2, password);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    usu = new Usuario();
                    usu.setId_usuario(rs.getInt("id_usuario"));
                    usu.setUsuario(rs.getString("usuario"));
                    usu.setContrasena(rs.getString("contrasena"));
                    usu.setTipo_usuario(rs.getString("tipo_usuario"));
                    usu.setActivo(rs.getInt("activo") == 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return usu;
    }
    
    public int agregarUsuario(Usuario usuario){
    	Connection cn = null;
		int filas=0;
		
		try
		{
			cn = Conexion.getConexion();
			Statement st = cn.createStatement();
			String query = "INSERT INTO usuarios (usuario, contrasena, tipo_usuario, activo, fecha_creacion, fecha_modificacion) VALUES ('"+usuario.getUsuario()+"', '"+usuario.getContrasena()+"', '"+usuario.getTipo_usuario()+"', true, NOW(), NOW())";
			filas=st.executeUpdate(query);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return filas;
	}
    
    
    public boolean verificarUsuarioExistente(String usuario) {
    	Connection cn = null;

        try {
            cn = Conexion.getConexion();
            String query = "SELECT * FROM usuarios";
            PreparedStatement pst = cn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                if(usuario.equalsIgnoreCase(rs.getString("usuario"))) {
                	return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }
    
    
    public int ultimoID() {
    	Connection cn = null;
    	int id = 1;
        try {
            cn = Conexion.getConexion();
            String query = "SELECT * FROM usuarios";
            PreparedStatement pst = cn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                id = rs.getInt("id_usuario");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return id;
    }
    
    @Override
    public int actualizarEstadoActivo(int idUsuario, boolean activo) {
        String query = "UPDATE usuarios SET activo=? WHERE id_usuario=?";
        try (PreparedStatement ps = Conexion.getConexion().prepareStatement(query)) {
            ps.setBoolean(1, activo);
            ps.setInt(2, idUsuario);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
