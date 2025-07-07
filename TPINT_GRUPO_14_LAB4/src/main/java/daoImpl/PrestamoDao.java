package daoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;


import dao.IPrestamoDAO;
import entidad.Cliente;
import entidad.CuotaPrestamo;
import entidad.Prestamo;
import excepciones.PrestamoException;
import util.Conexion;

public class PrestamoDao implements IPrestamoDAO {

	@Override
	public void crearPrestamo(Prestamo prestamo) throws PrestamoException{
		Connection connection = Conexion.getConexion();
		String query = "INSERT INTO prestamos(id_cliente, id_cuenta_deposito, monto_pedido, cantidad_cuotas, monto_cuotas, monto_total, estado, fecha_pedido, fecha_autorizacion, autorizado_por, observaciones ) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, prestamo.getCliente().getId());
			ps.setInt(2, prestamo.getCuenta().getIdCuenta());
			ps.setFloat(3, prestamo.getMontoPedido());
			ps.setInt(4, prestamo.getCantidadCuotas());
			ps.setFloat(5, prestamo.getMontoPorCuota());
			ps.setFloat(6, prestamo.getMontoTotal());
			ps.setBoolean(7, true);
			ps.setDate(8, (Date) prestamo.getFechaPedido());
			ps.setDate(9, (Date) prestamo.getFechaAutorizacion());
			ps.setInt(10, prestamo.getAutorizadoPorUsuario().getId_usuario());
			ps.setString(11, "");
			
			if(!ps.execute()) {
				throw new PrestamoException("No se creo el prestamo");
			}
			
		}catch(SQLException sqlE) {
			throw new PrestamoException("Error creando prestamo");
		}
	}

	@Override
	public void listarPrestamos() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void listarPresetamos(Cliente cliente) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void buscarPrestamoPorId(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void pagarCuota(Prestamo prestamo, CuotaPrestamo cuota) {
		// TODO Auto-generated method stub
		
	}

}
