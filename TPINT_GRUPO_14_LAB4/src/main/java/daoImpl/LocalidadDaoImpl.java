package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.ILocalidadDao;
import entidad.Localidad;
import entidad.Provincia;
import util.Conexion;

public class LocalidadDaoImpl implements ILocalidadDao {

	

public LocalidadDaoImpl() {};
	
	private static final String qrylistarlocalidades = "SELECT id, nombre, provincia_id FROM localidades";
	
	public List<Localidad> listarLocalidades() {
	    List<Localidad> localidades = new ArrayList<>();

	    try {
	     
	        Connection con = Conexion.getConexion();
	        PreparedStatement statement = con.prepareStatement(qrylistarlocalidades);
	        ResultSet resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            int id = resultSet.getInt("id");
	            String nombre = resultSet.getString("nombre");
	            int provincia_id = resultSet.getInt("provincia_id");
	            
	            Provincia prov = new Provincia();
	            prov.setId(provincia_id);
	           

	            Localidad loc = new Localidad(id, nombre,prov);
	            localidades.add(loc);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } 

	    return localidades;
	}

	 
private static final String qrylistarlocalidadesPorProvincia = "SELECT id, nombre, provincia_id FROM localidades WHERE provincia_id = ?";
	
	public List<Localidad> listarPorProvincia(int idProvincia) {
	    List<Localidad> localidades = new ArrayList<>();

	    try {
	     
	        Connection con = Conexion.getConexion();
	        PreparedStatement statement = con.prepareStatement(qrylistarlocalidadesPorProvincia);
			statement.setInt(1, idProvincia);
	        ResultSet resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            int id = resultSet.getInt("id");
	            String nombre = resultSet.getString("nombre");
	            int provincia_id = resultSet.getInt("provincia_id");
	            
	            Provincia prov = new Provincia();
	            prov.setId(provincia_id);
	           

	            Localidad loc = new Localidad(id, nombre,prov);
	            localidades.add(loc);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return localidades;
	}
	
private static final String qryBuscarLocalidad = "SELECT id, nombre FROM localidades WHERE id = ?";
	
	public Localidad obtenerLocalidadPorId(int id) {
	    Localidad localidad = null;

	    try {
	        
	        Connection con = Conexion.getConexion();
	        
	        
	        PreparedStatement statement = con.prepareStatement(qryBuscarLocalidad);
	        statement.setInt(1, id); 

	    
	        ResultSet resultSet = statement.executeQuery();

	      
	        if (resultSet.next()) {
	            localidad = new Localidad();
	            localidad.setId(resultSet.getInt("id"));
	            localidad.setNombre(resultSet.getString("nombre"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return localidad;
	}
	
	public Localidad buscarLocalidad(String localidad, int provincia) {
		Provincia p = new Provincia();
		Localidad l = new Localidad();
		l.setProvincia(p);
	    String query = "select l.id, l.nombre as localidad, p.nombre from localidades l inner join provincias p on l.provincia_id = p.id;";
	    int id = 1;
	    try (Connection connection = Conexion.getConexion();
	        PreparedStatement ps = connection.prepareStatement(query)) {
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	        	if(localidad.equalsIgnoreCase(rs.getString("localidad"))) {
	                l.setId(rs.getInt("l.id"));
	                l.setNombre(rs.getString("localidad"));
	                l.getProvincia().setNombre(rs.getString("p.nombre"));
	                return l;
	        	}
	        	id += 1;
	        }
	        l.setId(id);
            l.setNombre(localidad);
            l.getProvincia().setId(provincia);
            System.out.println(l.getProvincia().getId());
            try
    		{
    			
    			Statement st = connection.createStatement();
    			String query2 = "INSERT INTO localidades (id, nombre, provincia_id) VALUES ('"+id+"', '"+localidad+"', '"+provincia+"')";
    			st.executeUpdate(query2);
    		}
    		catch(Exception e)
    		{
    			e.printStackTrace();
    		}
            return l;
	        

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return l;
	}

	
	}

	
	