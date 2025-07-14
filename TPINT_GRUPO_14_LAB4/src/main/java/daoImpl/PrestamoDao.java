package daoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.IClienteDao;
import dao.ICuentaDao;
import dao.IPrestamoDAO;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import entidad.Usuario;
import excepciones.PrestamoException;
import negocio.ICuentaNegocio;
import util.Conexion;

public class PrestamoDao implements IPrestamoDAO {

	@Override
	public Prestamo crearPrestamo(Prestamo prestamo) throws PrestamoException{
		Connection connection = Conexion.getConexion();
		String query = "INSERT INTO prestamos(id_cliente, id_cuenta_deposito, monto_pedido, cantidad_cuotas, monto_cuota, monto_total, estado, fecha_pedido, observaciones ) VALUES(?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, prestamo.getCliente().getId());
			ps.setInt(2, prestamo.getCuenta().getIdCuenta());
			ps.setFloat(3, prestamo.getMontoPedido());
			ps.setInt(4, prestamo.getCantidadCuotas());
			ps.setFloat(5, prestamo.getMontoPorCuota());
			ps.setFloat(6, prestamo.getMontoTotal());
			ps.setString(7, "pendiente");
			ps.setDate(8, new java.sql.Date(prestamo.getFechaPedido().getTime()));
			ps.setString(9, "");
			
			if(ps.executeUpdate() == 0){
				throw new PrestamoException("No se creo el prestamo");
			}
			
			 ResultSet rs = ps.getGeneratedKeys();
		        if (rs.next()) {
		            int idPrestamo = rs.getInt(1);
		            prestamo.setId(idPrestamo); 
		        }

			
		}catch(SQLException sqlE) {
			try {
				sqlE.printStackTrace();
				throw new Exception("Error creando prestamo");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(prestamo.getId() == 0) {
			return null;
		}else {
			return prestamo;			
		}
		
		
	}

	@Override
	public void listarPrestamos() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Prestamo> listarPresetamos(Cliente cliente) {
		ArrayList<Prestamo> prestamos = new ArrayList();
		
		String query = "SELECT * FROM prestamos WHERE id_cliente = ?";
		

		try {
			PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
			ps.setInt(1, cliente.getId());
			
			ResultSet resultSet = ps.executeQuery();
			
			
			while(resultSet.next()) {
				Prestamo prestamo = this.transformarResultSetAPrestamo(resultSet);
				prestamos.add(prestamo);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prestamos;
	}

	@Override
	public void buscarPrestamoPorId(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void pagarCuota(Prestamo prestamo, CuotaPrestamo cuota) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public List<Prestamo> listarPrestamosPendientes() {
		ArrayList<Prestamo> prestamos = new ArrayList<>();
		
		String query = "SELECT p.*, c.nombre as cliente_nombre, c.apellido as cliente_apellido, c.dni as cliente_dni " +
				"FROM prestamos p " +
				"INNER JOIN clientes c ON p.id_cliente = c.id_cliente " +
				"WHERE p.estado = 'pendiente' " +
				"ORDER BY p.fecha_pedido ASC";
		
		try {
			PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
			ResultSet resultSet = ps.executeQuery();
			
			while(resultSet.next()) {
				Prestamo prestamo = this.transformarResultSetAPrestamo(resultSet);
				prestamos.add(prestamo);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return prestamos;
	}
	
	@Override
	public void aprobarPrestamo(int idPrestamo, int idAdmin) throws PrestamoException {
		Connection connection = Conexion.getConexion();
		
		try {
			// Obtener datos del préstamo primero
			String queryPrestamo = "SELECT monto_pedido, id_cuenta_deposito FROM prestamos WHERE id_prestamo = ?";
			PreparedStatement psPrestamo = connection.prepareStatement(queryPrestamo);
			psPrestamo.setInt(1, idPrestamo);
			ResultSet rs = psPrestamo.executeQuery();
			
			if (!rs.next()) {
				throw new PrestamoException("Préstamo no encontrado");
			}
			
			float montoPrestamo = rs.getFloat("monto_pedido");
			int idCuenta = rs.getInt("id_cuenta_deposito");
			
			// Actualizar saldo de la cuenta
			String queryActualizarCuenta = "UPDATE cuentas SET saldo = saldo + ? WHERE id_cuenta = ?";
			PreparedStatement psActualizarCuenta = connection.prepareStatement(queryActualizarCuenta);
			psActualizarCuenta.setFloat(1, montoPrestamo);
			psActualizarCuenta.setInt(2, idCuenta);
			psActualizarCuenta.executeUpdate();
			
			// Registrar movimiento
			String queryMovimiento = "INSERT INTO movimientos (id_cuenta, id_tipo_movimiento, concepto, importe, fecha, detalle) VALUES (?, 1, 'Depósito por préstamo aprobado', ?, NOW(), ?)";
			PreparedStatement psMovimiento = connection.prepareStatement(queryMovimiento);
			psMovimiento.setInt(1, idCuenta);
			psMovimiento.setFloat(2, montoPrestamo);
			psMovimiento.setString(3, "Préstamo #" + idPrestamo + " aprobado");
			psMovimiento.executeUpdate();
			
			// Actualizar estado del préstamo
			String queryAprobar = "UPDATE prestamos SET estado = 'Aprobado', fecha_autorizacion = NOW(), autorizado_por = ? WHERE id_prestamo = ?";
			PreparedStatement psAprobar = connection.prepareStatement(queryAprobar);
			psAprobar.setInt(1, idAdmin);
			psAprobar.setInt(2, idPrestamo);
			psAprobar.executeUpdate();
			
		} catch(SQLException sqlE) {
			throw new PrestamoException("Error al aprobar el préstamo: " + sqlE.getMessage());
		}
	}
	
	@Override
	public void rechazarPrestamo(int idPrestamo, int idAdmin, String observaciones) throws PrestamoException {
		Connection connection = Conexion.getConexion();
		String query = "UPDATE prestamos SET estado = 'Rechazado', fecha_autorizacion = NOW(), autorizado_por = ?, observaciones = ? WHERE id_prestamo = ?";
		
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, idAdmin);
			ps.setString(2, observaciones);
			ps.setInt(3, idPrestamo);
			
			if(ps.executeUpdate() == 0) {
				throw new PrestamoException("No se pudo rechazar el préstamo");
			}
			
		} catch(SQLException sqlE) {
			throw new PrestamoException("Error al rechazar el préstamo: " + sqlE.getMessage());
		}
	}
	
	private Prestamo transformarResultSetAPrestamo(ResultSet resultSet) {
		Prestamo prestamo = new Prestamo();
		
		
		try {
			prestamo.setId(resultSet.getInt("id_prestamo"));
			
			
			ICuentaDao cuentaDAO = new CuentaDaoImpl();
			Cuenta cuenta = cuentaDAO.buscarCuentaPorId(resultSet.getInt("id_cuenta_deposito"));
			prestamo.setCuenta(cuenta);
			
			IClienteDao clienteDAO = new ClienteDaoImpl();
			Cliente cliente = clienteDAO.buscarClientePorId(String.valueOf(resultSet.getInt("id_cliente")));
			prestamo.setCliente(cliente);

			prestamo.setMontoPedido(resultSet.getFloat("monto_pedido"));
			prestamo.setMontoPorCuota(resultSet.getFloat("monto_cuota"));
			prestamo.setMontoTotal(resultSet.getFloat("monto_total"));
			prestamo.setEstado(resultSet.getString("estado"));
			prestamo.setCantidadCuotas(resultSet.getInt("cantidad_cuotas"));
			prestamo.setFechaPedido(resultSet.getDate("fecha_pedido"));
			prestamo.setFechaAutorizacion(resultSet.getDate("fecha_autorizacion"));
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prestamo;
	}

}
