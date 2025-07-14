package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.ICuotaDao;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import util.Conexion;

public class CuotaDaoImpl implements ICuotaDao{

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
