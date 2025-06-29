package daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dao.ICuentaDao;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import entidad.Cuenta;
import entidad.Cliente;
import entidad.TipoCuenta;

public class CuentaDaoImpl implements ICuentaDao {
    
    private static final String INSERTAR = 
        "INSERT INTO cuentas (id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo) VALUES (?, ?, ?, ?, ?)";
    
    private static final String MODIFICAR = 
        "UPDATE cuentas SET id_tipo_cuenta = ?, numero_cuenta = ?, cbu = ?, saldo = ? WHERE id_cuenta = ?";
    
    private static final String DESACTIVAR = 
        "UPDATE cuentas SET activa = FALSE WHERE id_cuenta = ?";
    
    private static final String ACTIVAR = 
        "UPDATE cuentas SET activa = TRUE WHERE id_cuenta = ?";
    
    private static final String OBTENER_POR_ID = 
        "SELECT * FROM cuentas WHERE id_cuenta = ?";
    
    private static final String OBTENER_TODAS = 
        "SELECT * FROM cuentas ORDER BY fecha_creacion DESC";
    
    private Connection conexion;
    
    public CuentaDaoImpl() {
        // Constructor vacío - la conexión se pasará como parámetro o se obtendrá de ConnectionManager
    }
    
    public CuentaDaoImpl(Connection conexion) {
        this.conexion = conexion;
    }
    
    @Override
    public boolean insertar(Cuenta cuenta) {
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        boolean insertExitoso = false;
        
        try {
            statement = conexion.prepareStatement(INSERTAR, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, cuenta.getIdCliente());
            statement.setInt(2, cuenta.getIdTipoCuenta());
            statement.setString(3, cuenta.getNumeroCuenta());
            statement.setString(4, cuenta.getCbu());
            statement.setBigDecimal(5, cuenta.getSaldo());
            
            if (statement.executeUpdate() > 0) {
                resultSet = statement.getGeneratedKeys();
                if (resultSet.next()) {
                    cuenta.setIdCuenta(resultSet.getInt(1));
                }
                insertExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return insertExitoso;
    }
    
    @Override
    public boolean modificar(Cuenta cuenta) {
        PreparedStatement statement = null;
        boolean isUpdateExitoso = false;
        
        try {
            statement = conexion.prepareStatement(MODIFICAR);
            statement.setInt(1, cuenta.getIdTipoCuenta());
            statement.setString(2, cuenta.getNumeroCuenta());
            statement.setString(3, cuenta.getCbu());
            statement.setBigDecimal(4, cuenta.getSaldo());
            statement.setInt(5, cuenta.getIdCuenta());
            
            if (statement.executeUpdate() > 0) {
                isUpdateExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return isUpdateExitoso;
    }
    
    @Override
    public boolean desactivar(int idCuenta) {
        PreparedStatement statement = null;
        boolean isUpdateExitoso = false;
        
        try {
            statement = conexion.prepareStatement(DESACTIVAR);
            statement.setInt(1, idCuenta);
            
            if (statement.executeUpdate() > 0) {
                isUpdateExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return isUpdateExitoso;
    }
    
    @Override
    public boolean activar(int idCuenta) {
        PreparedStatement statement = null;
        boolean isUpdateExitoso = false;
        
        try {
            statement = conexion.prepareStatement(ACTIVAR);
            statement.setInt(1, idCuenta);
            
            if (statement.executeUpdate() > 0) {
                isUpdateExitoso = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return isUpdateExitoso;
    }

	@Override
	public Cuenta obtenerPorId(int idCuenta) {
		// TODO Auto-generated method stub
		return null;
	}
}
    

  