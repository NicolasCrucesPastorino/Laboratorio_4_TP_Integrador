package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.IProvinciaDao;
import entidad.Provincia;
import util.Conexion;

public class ProvinciaDaoImpl implements IProvinciaDao {

public ProvinciaDaoImpl() {};
	
	private static final String qrylistarprovincias = "SELECT id, nombre FROM provincias";
	
	public List<Provincia> listarProvincias() {
	    List<Provincia> provincias = new ArrayList<>();


	    try {
	     
	        Connection con = Conexion.getConexion();	
	        System.out.println("[DEBUG] Conexión a la base de datos establecida");

	        System.out.println("[DEBUG] Conexión establecida: " + con);

	        PreparedStatement statement = con.prepareStatement(qrylistarprovincias);
	        ResultSet resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            int id = resultSet.getInt("id");
	            String nombre = resultSet.getString("nombre");
	        
	            Provincia prov = new Provincia(id, nombre);
	            provincias.add(prov);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return provincias;
	}
	
	
	private static final String qrybuscarProvincia = "SELECT id, nombre FROM provincias WHERE id = ?";

	public Provincia obtenerProvinciaPorId(int id) {
	    Provincia provincia = null;

	    try {
	        Connection con = Conexion.getConexion();
	        PreparedStatement statement = con.prepareStatement(qrybuscarProvincia);
	        statement.setInt(1, id);
	        ResultSet resultSet = statement.executeQuery();

	        if (resultSet.next()) {
	            provincia = new Provincia();
	            provincia.setId(resultSet.getInt("id"));
	            provincia.setNombre(resultSet.getString("nombre"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return provincia;
	}

	}
