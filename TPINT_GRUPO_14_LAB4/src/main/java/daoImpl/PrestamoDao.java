package daoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	public void crearPrestamo(Prestamo prestamo) throws PrestamoException{
		Connection connection = Conexion.getConexion();
		String query = "INSERT INTO prestamos(id_cliente, id_cuenta_deposito, monto_pedido, cantidad_cuotas, monto_cuota, monto_total, estado, fecha_pedido, observaciones ) VALUES(?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(query);
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
			
		}catch(SQLException sqlE) {
			try {
				throw new Exception("Error creando prestamo");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
	
	private Prestamo transformarResultSetAPrestamo(ResultSet resultSet) {
		Prestamo prestamo = new Prestamo();
		
		
		try {
			prestamo.setId(resultSet.getInt("id_prestamo"));
			
			
			ICuentaDao cuentaDAO = new CuentaDaoImpl();
			Cuenta cuenta = cuentaDAO.obtenerPorId(resultSet.getInt("id_cuenta_deposito"));
			prestamo.setCuenta(cuenta);
			
			IClienteDao clienteDAO = new ClienteDaoImpl();
			Cliente cliente = clienteDAO.buscarClientePorId(resultSet.getString("id_cliente"));
			prestamo.setCliente(cliente);

			prestamo.setMontoPedido(resultSet.getFloat("monto_pedido"));
			prestamo.setMontoPorCuota(resultSet.getFloat("monto_cuota"));
			prestamo.setMontoTotal(resultSet.getFloat("monto_total"));
			prestamo.setEstado(resultSet.getString("estado"));
			prestamo.setCantidadCuotas(resultSet.getInt("cantidad_cuotas"));
			prestamo.setFechaPedido(resultSet.getDate("fecha_pedido"));
			prestamo.setFechaAutorizacion(resultSet.getDate("fecha_autorizado"));
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prestamo;
	}

}
