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
import entidad.Cuenta;
import entidad.CuotaPrestamo;
import entidad.Prestamo;

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
	
	@SuppressWarnings("deprecation")
	@Override
	public List<CuotaPrestamo> listarporFecha(int mes, int año) {
		List<CuotaPrestamo> cuotas = new ArrayList<>();
	    String queryClientes = "select * from cuotas_prestamo c inner join prestamos p on c.id_prestamo = p.id_prestamo;";

	    try (
	        Connection cn = Conexion.getConexion();
	        Statement st = cn.createStatement();
	        ResultSet rs = st.executeQuery(queryClientes)
	    ) {
	        while (rs.next()) {
	        	if((rs.getDate("fecha_vencimiento").getYear()+1900)==año && (rs.getDate("fecha_vencimiento").getMonth()+1)==mes) {
		        	CuotaPrestamo cuota = new CuotaPrestamo();
		        	Prestamo p = new Prestamo();
		        	Cuenta c = new Cuenta();
		        	cuota.setPrestamo(p);
		        	cuota.setCuentaPago(c);
		        	cuota.setId(rs.getInt("id_cuota"));
		        	cuota.setNumeroCuota(rs.getInt("numero_cuota"));
		        	cuota.setMontoCuota(rs.getFloat("monto_cuota"));
		        	cuota.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
		        	cuota.setFechaPago(rs.getDate("fecha_pago"));
		        	cuota.setEstado(rs.getString("estado"));
		        	cuota.getCuentaPago().setIdCuenta(rs.getInt("id_cuenta_pago"));
		        	cuota.getPrestamo().setMontoPedido(rs.getFloat("monto_pedido"));
		        	cuota.getPrestamo().setMontoTotal(rs.getFloat("monto_total"));
		        	cuota.getPrestamo().setCantidadCuotas(rs.getInt("cantidad_cuotas"));
		            cuotas.add(cuota);
	        	}
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cuotas;
	}

	@Override
	public int contarCuotas(List<CuotaPrestamo> lista, String estado) {
		int c = 0;
		for(CuotaPrestamo cuota : lista) {
			if(cuota.getEstado().equals(estado)) {
				c += 1;
			}
		}
		return c;
	}

	@Override
	public float montoTotal(List<CuotaPrestamo> lista, String estado) {
		float t = 0;
		for(CuotaPrestamo cuota : lista) {
			if(cuota.getEstado().equals(estado)) {
				t += cuota.getMontoCuota();
			}
		}
		return t;
	}

	@Override
	public float calcularGanacia(List<CuotaPrestamo> lista) {
		float t = 0;
		for(CuotaPrestamo cuota : lista) {
			if(cuota.getEstado().equals("Pagada")) {
				float g = (cuota.getPrestamo().getMontoTotal() - cuota.getPrestamo().getMontoPedido()) / cuota.getPrestamo().getCantidadCuotas();
				t += g;
			}
		}
		return t;
	}
}
