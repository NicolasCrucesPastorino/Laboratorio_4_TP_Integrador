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
