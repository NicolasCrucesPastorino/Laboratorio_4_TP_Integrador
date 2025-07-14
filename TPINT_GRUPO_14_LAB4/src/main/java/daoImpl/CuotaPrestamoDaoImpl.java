package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import util.Conexion;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
	
import dao.ICuotaDao;
import entidad.CuotaPrestamo;

public class CuotaPrestamoDaoImpl implements ICuotaDao {

	
	Connection cn = Conexion.getConexion();
	
	
	@Override
	public void CrearCuota(CuotaPrestamo cuotaPrestamo) {
		PreparedStatement ps = null;
		String query = "INSERT INTO cuotas_prestamo (id_prestamo, numero_cuota, monto_cuota, fecha_vencimiento, estado) VALUES (?, ?, ?, ?, ?)";
	    try {
	        ps = cn.prepareStatement(query);

	        ps.setInt(1, cuotaPrestamo.getPrestamo().getId() );
	        ps.setInt(2, cuotaPrestamo.getNumeroCuota());
	        ps.setFloat(3, cuotaPrestamo.getMontoCuota());
	        ps.setDate(4, new java.sql.Date(cuotaPrestamo.getFechaVencimiento().getTime()));
	        ps.setString(5, cuotaPrestamo.getEstado());
	        
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null) {
	                ps.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	@Override
	public void CancelarCuota(CuotaPrestamo cuotaPrestamo) {
	    /*
		try {
	        // Opción 1: Actualizar el estado de la cuota a inactiva
	        String query = "UPDATE cuota_prestamo SET activa = false WHERE numero_cuota = ?";
	        Connection cn;
			//PreparedStatement ps = cn.prepareStatement(query);
	        
	        // ps.setInt(1, cuotaPrestamo.getNumero_cuota());
	        
	        //ps.executeUpdate();
	        //ps.close();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // Manejo de errores
	    }
	    
	    */
	}
}
