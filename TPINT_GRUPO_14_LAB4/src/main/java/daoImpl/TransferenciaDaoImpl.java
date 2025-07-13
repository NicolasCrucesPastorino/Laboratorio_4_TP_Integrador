package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import dao.ITransferenciaDao;
import entidad.Cuenta;
import entidad.Cliente;

import util.Conexion;

public class TransferenciaDaoImpl implements ITransferenciaDao{

	@Override
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo) {
		Connection conection = Conexion.getConexion();
		try {
			
            conection.setAutoCommit(false); 

            String updateOrigen = "UPDATE cuentas SET saldo = saldo - ? WHERE id_cuenta = ?";
            String updateDestino = "UPDATE cuentas SET saldo = saldo + ? WHERE id_cuenta = ?";
            String insertTransferencia = "INSERT INTO transferencias(id_cuenta_origen, id_cuenta_destino, concepto, importe, fecha, estado) VALUES (?, ?, ?, ?, NOW(), 'Completa')";
            String insertMovimientoOrigen = "INSERT INTO movimientos(id_cuenta, id_tipo_movimiento, detalle, importe, fecha) VALUES (?, 4, ?, ?, NOW())";
            String insertMovimientoDestino = "INSERT INTO movimientos(id_cuenta, id_tipo_movimiento, detalle, importe, fecha) VALUES (?, 3, ?, ?, NOW())";

            PreparedStatement psOrigen = conection.prepareStatement(updateOrigen);
            psOrigen.setBigDecimal(1, importe);
            psOrigen.setInt(2, origen.getIdCuenta());
            psOrigen.executeUpdate();

            PreparedStatement psDestino = conection.prepareStatement(updateDestino);
            psDestino.setBigDecimal(1, importe);
            psDestino.setInt(2, destino.getIdCuenta());
            psDestino.executeUpdate();

            PreparedStatement psTransferencia = conection.prepareStatement(insertTransferencia);
            psTransferencia.setInt(1, origen.getIdCuenta());
            psTransferencia.setInt(2, destino.getIdCuenta());
            psTransferencia.setString(3, motivo);
            psTransferencia.setBigDecimal(4, importe);
            psTransferencia.executeUpdate();

            // Insertar movimientos para ambas cuentas
            PreparedStatement psMovOrigen = conection.prepareStatement(insertMovimientoOrigen);
            psMovOrigen.setInt(1, origen.getIdCuenta());
            psMovOrigen.setString(2, "Transferencia realizada - " + motivo);
            psMovOrigen.setBigDecimal(3, importe);
            psMovOrigen.executeUpdate();

            PreparedStatement psMovDestino = conection.prepareStatement(insertMovimientoDestino);
            psMovDestino.setInt(1, destino.getIdCuenta());
            psMovDestino.setString(2, "Transferencia recibida - " + motivo);
            psMovDestino.setBigDecimal(3, importe);
            psMovDestino.executeUpdate();

            conection.commit(); 
            conection.setAutoCommit(true);
            System.out.println("Transacción completada exitosamente.");
            return true;

        } catch (SQLException e) {
            System.err.println("Error en la transacción: " + e.getMessage());
            try {
                if (conection != null) {
                    conection.rollback(); 
                    System.out.println("Transacción revertida.");
                }
            } catch (SQLException ex) {
                System.err.println("Error al revertir la transacción: " + ex.getMessage());
            }
        }
		return false;
	}

	@Override
	public Cuenta buscarCuentaPorCBU(String cbu) {
		Connection connection = Conexion.getConexion();
		String query = "SELECT c.id_cuenta, c.numero_cuenta, c.cbu, c.saldo " +
		               "FROM cuentas c " +
		               "WHERE c.cbu = ?";
		
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, cbu);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				Cuenta cuenta = new Cuenta();
				cuenta.setIdCuenta(rs.getInt("id_cuenta"));
				cuenta.setNumeroCuenta(rs.getString("numero_cuenta"));
				cuenta.setCbu(rs.getString("cbu"));
				cuenta.setSaldo(rs.getBigDecimal("saldo"));
				
				return cuenta;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean existeCBU(String cbu) {
		Connection connection = Conexion.getConexion();
		String query = "SELECT 1 FROM cuentas WHERE cbu = ? LIMIT 1";
		
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, cbu);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Cliente obtenerTitularPorCBU(String cbu) {
		Connection connection = Conexion.getConexion();
		String query = "SELECT cl.id_cliente, cl.nombre, cl.apellido " +
		               "FROM clientes cl " +
		               "INNER JOIN cuentas c ON cl.id_cliente = c.id_cliente " +
		               "WHERE c.cbu = ?";
		
		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, cbu);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				Cliente cliente = new Cliente();
				cliente.setId_cliente(rs.getInt("id_cliente"));
				cliente.setNombre(rs.getString("nombre"));
				cliente.setApellido(rs.getString("apellido"));
				
				return cliente;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean validarCBU(String cbu) {
		if (cbu == null || cbu.trim().isEmpty()) {
			return false;
		}
		
		return existeCBU(cbu);
	}

}
