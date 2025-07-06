package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dao.IMovimientoDao;
import entidad.Movimiento;
import entidad.Cuenta;
import entidad.TipoMovimiento;
import util.Conexion;

public class MovimientoDaoImpl implements IMovimientoDao {

	@Override
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta) {
		return getMovimientosPorCuenta(idCuenta, 0);
	}

	@Override
	public List<Movimiento> getMovimientosPorCuenta(int idCuenta, int limite) {
		List<Movimiento> movimientos = new ArrayList<>();
		String query = "SELECT m.*, tm.descripcion as tipo_descripcion, tm.tipo as tipo_movimiento, " +
					  "c.numero_cuenta, c.cbu " +
					  "FROM movimientos m " +
					  "INNER JOIN tipos_movimiento tm ON m.id_tipo_movimiento = tm.id_tipo_movimiento " +
					  "INNER JOIN cuentas c ON m.id_cuenta = c.id_cuenta " +
					  "WHERE m.id_cuenta = ? " +
					  "ORDER BY m.fecha DESC";
		
		if (limite > 0) {
			query += " LIMIT " + limite;
		}
		
		try (Connection conn = Conexion.getConexion();
			 PreparedStatement ps = conn.prepareStatement(query)) {
			
			ps.setInt(1, idCuenta);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Movimiento movimiento = crearMovimiento(rs);
				movimientos.add(movimiento);
			}
			
		} catch (SQLException e) {
			System.err.println("Error al obtener movimientos: " + e.getMessage());
			e.printStackTrace();
		}
		
		return movimientos;
	}

	@Override
	public int agregarMovimiento(Movimiento movimiento) {
		String query = "INSERT INTO movimientos (id_cuenta, id_tipo_movimiento, concepto, importe, fecha, detalle) " +
					  "VALUES (?, ?, ?, ?, ?, ?)";
		
		try (Connection conn = Conexion.getConexion();
			 PreparedStatement ps = conn.prepareStatement(query)) {
			
			ps.setInt(1, movimiento.getCuenta().getIdCuenta());
			ps.setInt(2, movimiento.getTipoMovimiento().getId_tipo_movimiento());
			ps.setString(3, movimiento.getConcepto());
			ps.setBigDecimal(4, movimiento.getImporte());
			ps.setObject(5, movimiento.getFecha());
			ps.setString(6, movimiento.getDetalle());
			
			return ps.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println("Error al agregar movimiento: " + e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	
	private Movimiento crearMovimiento(ResultSet rs) throws SQLException {
		Movimiento movimiento = new Movimiento();
		
		movimiento.setId_movimiento(rs.getInt("id_movimiento"));
		movimiento.setConcepto(rs.getString("concepto"));
		movimiento.setImporte(rs.getBigDecimal("importe"));
		movimiento.setFecha(rs.getObject("fecha", LocalDateTime.class));
		movimiento.setDetalle(rs.getString("detalle"));
		
		// Crear Cuenta
		Cuenta cuenta = new Cuenta();
		cuenta.setIdCuenta(rs.getInt("id_cuenta"));
		cuenta.setNumeroCuenta(rs.getString("numero_cuenta"));
		cuenta.setCbu(rs.getString("cbu"));
		movimiento.setCuenta(cuenta);
		
		// Crear TipoMovimiento
		TipoMovimiento tipoMov = new TipoMovimiento();
		tipoMov.setId_tipo_movimiento(rs.getInt("id_tipo_movimiento"));
		tipoMov.setDescripcion(rs.getString("tipo_descripcion"));
		tipoMov.setTipo(rs.getString("tipo_movimiento"));
		movimiento.setTipoMovimiento(tipoMov);
		
		return movimiento;
	}
} 