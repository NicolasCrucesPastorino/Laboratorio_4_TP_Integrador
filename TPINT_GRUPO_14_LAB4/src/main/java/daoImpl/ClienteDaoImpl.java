package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
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
		int idusu = udao.ultimoID();
		try
		{
			cn = Conexion.getConexion();
			Statement st = cn.createStatement();
			String query = "INSERT INTO clientes (id_usuario, dni, nombre, apellido, sexo, nacionalidad, fecha_nacimiento, direccion, id_localidad, id_provincia, correo_electronico, telefono, fecha_alta, activo) VALUES ('"+idusu+"', '"+cliente.getDNI()+"', '"+cliente.getNombre()+"', '"+cliente.getApellido()+"', '"+cliente.getGenero()+"', '"+cliente.getNacionalidad()+"', '"+cliente.getFecha_nacimiento()+"', '"+cliente.getDireccion()+"', '"+cliente.getLocalidad().getId()+"', '"+cliente.getProvincia().getId()+"', '"+cliente.getCorreo()+"', '"+cliente.getTelefono()+"', NOW(), true)";
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
	    String queryClientes = "SELECT * FROM clientes ORDER BY id_cliente DESC";

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
	
	public Cliente buscarClientePorUsuario(int idUsuario) {
		Cliente cliente = null;
		String query = "SELECT * FROM clientes WHERE id_usuario=?";
		try {
			PreparedStatement pr = Conexion.getConexion().prepareStatement(query);
			pr.setInt(1, idUsuario);
			ResultSet resultset = pr.executeQuery();
			
			if(resultset.next()) {
				cliente = crearCliente(resultset);				
			}
		}catch(SQLException se) {
			 System.err.println("Error al obtener cliente por usuario: " + se.getMessage());
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
		   cliente.setFecha_nacimiento(resultSet.getDate("fecha_nacimiento") != null ? 
				    resultSet.getDate("fecha_nacimiento").toLocalDate() : null);
		   cliente.setDireccion(resultSet.getString("direccion"));

		   // Localidad y provincia
		   int idLocalidad = resultSet.getInt("id_localidad");
		   int idProvincia = resultSet.getInt("id_provincia");

		   Localidad localidad = new Localidad();
		   localidad.setId(idLocalidad);
		   
		   // CARGA NOMBRE DE LOCALIDAD
		   String queryLocalidad = "SELECT nombre FROM localidades WHERE id = ?";
		   PreparedStatement psLoc = Conexion.getConexion().prepareStatement(queryLocalidad);
		   psLoc.setInt(1, idLocalidad);
		   ResultSet rsLoc = psLoc.executeQuery();
		   if(rsLoc.next()) {
		       localidad.setNombre(rsLoc.getString("nombre"));
		   }

		   Provincia provincia = new Provincia();
		   provincia.setId(idProvincia);
		   
		   // CARGA NOMBRE DE PROVINCIA
		   String queryProvincia = "SELECT nombre FROM provincias WHERE id = ?";
		   PreparedStatement psProv = Conexion.getConexion().prepareStatement(queryProvincia);
		   psProv.setInt(1, idProvincia);
		   ResultSet rsProv = psProv.executeQuery();
		   if(rsProv.next()) {
		       provincia.setNombre(rsProv.getString("nombre"));
		   }

		   cliente.setLocalidad(localidad);
		   cliente.setProvincia(provincia);

		   	   cliente.setCorreo(resultSet.getString("correo_electronico"));
	   cliente.setTelefono(resultSet.getString("telefono"));
	   cliente.setFecha_alta(resultSet.getDate("fecha_alta"));
	   cliente.setActivo(resultSet.getBoolean("activo"));

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
		}

	
	

	public int actualizarCliente(Cliente cliente) {
		String query = "UPDATE clientes SET nombre=?, apellido=?, dni=?, sexo=?, direccion=?, correo_electronico=?, telefono=?, id_localidad=?, id_provincia=?, activo=? WHERE id_cliente=?";

	    try {
	        PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
	        ps.setString(1, cliente.getNombre());
	        ps.setString(2, cliente.getApellido());
	        ps.setString(3, cliente.getDNI());
	        ps.setString(4, cliente.getGenero());
	        ps.setString(5, cliente.getDireccion());
	        // TODO: Implementar correctamente localidad y provincia
	        // ps.setInt(6, cliente.getLocalidad().getId());
	        // ps.setInt(7, cliente.getProvincia().getId());
	        ps.setString(6, cliente.getCorreo());
	        ps.setString(7, cliente.getTelefono());
	        
	        //LOCALIDAD Y PROVINCIA
	        ps.setInt(8, cliente.getLocalidad().getId());
	        ps.setInt(9, cliente.getProvincia().getId());
	        ps.setBoolean(10, cliente.isActivo());
	        
	        
	        ps.setInt(11, cliente.getId());

	        int filas = ps.executeUpdate();
	        
	        // Si se actualizó el cliente, también actualizar el usuario correspondiente
	        if (filas > 0) {
	            // Obtener el id_usuario del cliente
	            String queryUsuario = "SELECT id_usuario FROM clientes WHERE id_cliente=?";
	            PreparedStatement psUsuario = Conexion.getConexion().prepareStatement(queryUsuario);
	            psUsuario.setInt(1, cliente.getId());
	            ResultSet rsUsuario = psUsuario.executeQuery();
	            
	            if (rsUsuario.next()) {
	                int idUsuario = rsUsuario.getInt("id_usuario");
	                // Actualizar el estado del usuario
	                UsuarioDaoImpl usuarioDao = new UsuarioDaoImpl();
	                usuarioDao.actualizarEstadoActivo(idUsuario, cliente.isActivo());
	            }
	        }
	        
	        return filas;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return 0;
	    }
	}
	
	
	public int ultimoID() {
    	Connection cn = null;
    	int id = 1;
        try {
            cn = Conexion.getConexion();
            String query = "SELECT * FROM clientes";
            PreparedStatement pst = cn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                id = rs.getInt("id_cliente");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return id;
    }

}
