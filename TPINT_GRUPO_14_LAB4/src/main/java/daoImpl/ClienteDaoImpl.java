package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.IClienteDao;
import entidad.Cliente;
import entidad.Usuario;
import entidad.Localidad;
import entidad.Provincia;
import util.Conexion;

public class ClienteDaoImpl implements IClienteDao {

	@Override
	public int agregarCliente(Cliente cliente) {
		UsuarioDaoImpl udao = new UsuarioDaoImpl();
		Connection cn = null;
		int filas=0;
		int idusu = udao.proximoID();
		try
		{
			cn = Conexion.getConexion();
			Statement st = cn.createStatement();
			String query = "INSERT INTO clientes (id_usuario, dni, nombre, apellido, sexo, nacionalidad, fecha_nacimiento, direccion, id_localidad, id_provincia, correo_electronico, telefono, fecha_alta, activo) VALUES ('"+idusu+"', '"+cliente.getDNI()+"', '"+cliente.getNombre()+"', '"+cliente.getApellido()+"', '"+cliente.getGenero()+"', '"+cliente.getNacionalidad()+"', '"+cliente.getFecha_nacimiento()+"', '"+cliente.getDireccion()+"', '"+cliente.getLocalidad()+"', '"+cliente.getProvincia()+"', '"+cliente.getCorreo()+"', '"+cliente.getTelefono()+"', NOW(), true)";
			filas=st.executeUpdate(query);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return filas;
	}
	
	public boolean verificarDNIExistente(String dni) {
    	Connection cn = null;

        try {
            cn = Conexion.getConexion();
            String query = "SELECT * FROM clientes";
            PreparedStatement pst = cn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                if(dni.equalsIgnoreCase(rs.getString("dni"))) {
                	return false;
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

	@Override
	public List<Cliente> getAllClientes() {
	    List<Cliente> clientes = new ArrayList<>();
	    String queryClientes = "SELECT * FROM clientes WHERE activo = 1";

	    try (
	        Connection conection = Conexion.getConexion();
	        Statement statement = conection.createStatement();
	        ResultSet resultSet = statement.executeQuery(queryClientes)
	    ) {
	        while (resultSet.next()) {
	        	Cliente cliente = crearCliente(resultSet);
	            clientes.add(cliente);
	        }

	    } catch (SQLException e) {
	        System.err.println("Error al obtener clientes: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return clientes;
	}

	@Override
	public Cliente buscarClientePorId(String id) {
		int clienteId = Integer.parseInt(id);
		Cliente cliente = null;
		String query = "SELECT * FROM clientes WHERE id_cliente=?";
		try {
			PreparedStatement pr = Conexion.getConexion().prepareStatement(query);
			pr.setInt(1, clienteId);
			ResultSet resultset = pr.executeQuery();
			
			if(resultset.next()) {
				cliente = crearCliente(resultset);				
			}
		}catch(SQLException se) {
			 System.err.println("Error al obtener clientes: " + se.getMessage());
		     se.printStackTrace();
		}
		
		return cliente;
	}
	
	private Cliente crearCliente(ResultSet resultSet) throws SQLException {
		Cliente cliente = new Cliente();
		cliente.setId_cliente(resultSet.getInt("id_cliente"));
        cliente.setNombre(resultSet.getString("nombre"));
        cliente.setApellido(resultSet.getString("apellido"));
        cliente.setDNI(resultSet.getString("dni"));
        cliente.setGenero(resultSet.getString("sexo"));
        cliente.setNacionalidad(resultSet.getString("nacionalidad"));
        cliente.setFecha_nacimiento(resultSet.getDate("fecha_nacimiento"));
        cliente.setDireccion(resultSet.getString("direccion"));
        cliente.getLocalidad().getId();
        cliente.getProvincia().getId();
        cliente.setCorreo(resultSet.getString("correo_electronico"));
        cliente.setTelefono(resultSet.getString("telefono"));
        cliente.setFecha_alta(resultSet.getDate("fecha_alta"));

        String queryUsuario = "SELECT * FROM usuarios WHERE id_usuario = ?";
        PreparedStatement pstatement = Conexion.getConexion().prepareStatement(queryUsuario);
        
            pstatement.setInt(1, resultSet.getInt("id_usuario"));
            ResultSet resultUsuario = pstatement.executeQuery();
                if (resultUsuario.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId_usuario(resultUsuario.getInt("id_usuario"));
                    usuario.setUsuario(resultUsuario.getString("usuario"));
                    usuario.setTipo_usuario(resultUsuario.getString("tipo_usuario"));
                    cliente.setUsuario(usuario);
                }
 
        return cliente;
	};
	
	

	public int actualizarCliente(Cliente cliente) {
	    String query = "UPDATE clientes SET nombre=?, apellido=?, dni=?, sexo=?, direccion=?, localidad=?, provincia=?, correo_electronico=?, telefono=? WHERE id_cliente=?";
	    
	    try {
	        PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
	        ps.setString(1, cliente.getNombre());
	        ps.setString(2, cliente.getApellido());
	        ps.setString(3, cliente.getDNI());
	        ps.setString(4, cliente.getGenero());
	        ps.setString(5, cliente.getDireccion());
	        ps.setInt(6, cliente.getLocalidad().getId());
	        ps.setInt(7, cliente.getProvincia().getId());
	        ps.setString(8, cliente.getCorreo());
	        ps.setString(9, cliente.getTelefono());
	        ps.setInt(10, cliente.getId());
	        
	        return ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return 0;
	    }
	}

}
