package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import dao.ITransferenciaDao;
import entidad.Cuenta;
import util.Conexion;

public class TransferenciaDaoImpl implements ITransferenciaDao{

	@Override
	public boolean RealizarTransferencia(Cuenta origen, Cuenta destino, BigDecimal importe, String motivo) {
		Connection conection = Conexion.getConexion();
		try {
			
            conection.setAutoCommit(false); // Desactivar autocommit

            Statement statement = conection.createStatement();
            statement.executeUpdate("update cuentas set saldo = saldo - '"+importe+"' WHERE id_cuenta = '"+origen.getIdCuenta()+"'");
            statement.executeUpdate("update cuentas set saldo = saldo + '"+importe+"' WHERE id_cuenta = '"+destino.getIdCuenta()+"'");
            statement.executeUpdate("insert into transferencias(id_cuenta_origen, id_cuenta_destino, concepto, importe, fecha, estado) values ('"+origen.getIdCuenta()+"', '"+destino.getIdCuenta()+"', '"+motivo+"', '"+importe+"', NOW(), 'Completa')");

            conection.commit(); // Confirmar transacción
            conection.setAutoCommit(true);
            System.out.println("Transacción completada exitosamente.");
            return true;

        } catch (SQLException e) {
            System.err.println("Error en la transacción: " + e.getMessage());
            try {
                if (conection != null) {
                    conection.rollback(); // Revertir transacción
                    System.out.println("Transacción revertida.");
                }
            } catch (SQLException ex) {
                System.err.println("Error al revertir la transacción: " + ex.getMessage());
            }
        }
		return false;
	}

}
