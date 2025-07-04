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
import entidad.Usuario;
import util.Conexion;

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

	@Override
	public Cuenta buscarporCBU(String cbu) {
        Cuenta c = null;
        Connection cn = null;

        try {
            cn = Conexion.getConexion();
            String query = "select * from cuentas where cbu = '"+cbu+"' and activa = true";
            PreparedStatement pst = cn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                c = new Cuenta();
                c.setIdCuenta(rs.getInt("id_cuenta"));
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setIdTipoCuenta(rs.getInt("id_tipo_cuenta"));
                c.setNumeroCuenta(rs.getString("numero_cuenta"));
                c.setCbu(rs.getString("cbu"));
                c.setSaldo(BigDecimal.valueOf(rs.getFloat("saldo")));
                c.setFechaCreacion(rs.getDate("fecha_creacion"));
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

	@Override
	public List<Cuenta> listarporUsuario(int idusu) {
		List<Cuenta> cuentas = new ArrayList<>();
	    String query = "select * from cuentas cu inner join clientes cl on cu.id_cliente = cl.id_cliente where cl.id_usuario = '"+idusu+"'";

	    try (
	        Connection conection = Conexion.getConexion();
	        Statement statement = conection.createStatement();
	        ResultSet rs = statement.executeQuery(query)
	    ) {
	        while (rs.next()) {
	        	Cuenta c = new Cuenta();
                c.setIdCuenta(rs.getInt("id_cuenta"));
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setIdTipoCuenta(rs.getInt("id_tipo_cuenta"));
                c.setNumeroCuenta(rs.getString("numero_cuenta"));
                c.setCbu(rs.getString("cbu"));
                c.setSaldo(BigDecimal.valueOf(rs.getFloat("saldo")));
                c.setFechaCreacion(rs.getDate("fecha_creacion"));
	            cuentas.add(c);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cuentas;
	}
}
    

  