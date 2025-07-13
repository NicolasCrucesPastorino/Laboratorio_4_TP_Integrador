package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import dao.ICuentaDao;
import entidad.Cuenta;
import entidad.Cliente;
import entidad.TipoCuenta;
import util.Conexion;

public class CuentaDaoImpl implements ICuentaDao {

    @Override
    public int agregarCuenta(Cuenta cuenta) {
        Connection cn = null;
        int filas = 0;
        
        try {
            cn = Conexion.getConexion();
            String query = "INSERT INTO cuentas (id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, activa) " +
                          "VALUES (?, ?, ?, ?, ?, NOW(), ?)";
            
            PreparedStatement pst = cn.prepareStatement(query);
            pst.setInt(1, cuenta.getIdCliente());
            pst.setInt(2, cuenta.getIdTipoCuenta());
            pst.setString(3, cuenta.getNumeroCuenta());
            pst.setString(4, cuenta.getCbu());
            pst.setBigDecimal(5, cuenta.getSaldo());
            pst.setBoolean(6, cuenta.isActiva());
            
            filas = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return filas;
    }

    @Override
    public boolean modificarCuenta(Cuenta cuenta) {
        Connection cn = null;
        
        try {
            cn = Conexion.getConexion();
            String query = "UPDATE cuentas SET id_tipo_cuenta=?, numero_cuenta=?, cbu=?, saldo=?, activa=? " +
                          "WHERE id_cuenta=?";
            
            PreparedStatement pst = cn.prepareStatement(query);
            pst.setInt(1, cuenta.getIdTipoCuenta());
            pst.setString(2, cuenta.getNumeroCuenta());
            pst.setString(3, cuenta.getCbu());
            pst.setBigDecimal(4, cuenta.getSaldo());
            pst.setBoolean(5, cuenta.isActiva());
            pst.setInt(6, cuenta.getIdCuenta());
            
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public boolean eliminarCuenta(int idCuenta) {
        Connection cn = null;
        
        try {
            cn = Conexion.getConexion();
            String query = "DELETE FROM cuentas WHERE id_cuenta=?";
            
            PreparedStatement pst = cn.prepareStatement(query);
            pst.setInt(1, idCuenta);
            
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public boolean desactivarCuenta(int idCuenta) {
        Connection cn = null;
        
        try {
            cn = Conexion.getConexion();
            String query = "UPDATE cuentas SET activa=false WHERE id_cuenta=?";
            
            PreparedStatement pst = cn.prepareStatement(query);
            pst.setInt(1, idCuenta);
            
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public boolean activarCuenta(int idCuenta) {
        Connection cn = null;
        
        try {
            cn = Conexion.getConexion();
            String query = "UPDATE cuentas SET activa=true WHERE id_cuenta=?";
            
            PreparedStatement pst = cn.prepareStatement(query);
            pst.setInt(1, idCuenta);
            
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public Cuenta buscarCuentaPorId(int idCuenta) {
        String query = "SELECT * FROM cuentas WHERE id_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idCuenta);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return crearCuenta(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public Cuenta buscarCuentaPorCBU(String cbu) {
        String query = "SELECT * FROM cuentas WHERE cbu = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setString(1, cbu);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return crearCuenta(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public Cuenta buscarCuentaPorNumero(String numeroCuenta) {
        String query = "SELECT * FROM cuentas WHERE numero_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setString(1, numeroCuenta);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return crearCuenta(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public String generarNumeroAleatorio(int longitud) {
		Random random = new Random();
        StringBuilder sb = new StringBuilder(longitud);
        for (int i = 0; i < longitud; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
	}

    @Override
    public List<Cuenta> buscarCuentasPorCliente(int idCliente) {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT * FROM cuentas WHERE id_cliente = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public List<Cuenta> buscarCuentasPorDNI(String dni) {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT c.* FROM cuentas c " +
                      "INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente " +
                      "WHERE cl.dni = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public List<Cuenta> buscarCuentasPorTipo(int idTipoCuenta) {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT * FROM cuentas WHERE id_tipo_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idTipoCuenta);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public List<Cuenta> getAllCuentas() {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT * FROM cuentas";
        
        try (Connection connection = Conexion.getConexion();
             Statement statement = connection.createStatement();
             ResultSet rs = statement.executeQuery(query)) {
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener cuentas: " + e.getMessage());
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public List<Cuenta> getCuentasActivas() {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT * FROM cuentas WHERE activa = true";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public List<Cuenta> getCuentasInactivas() {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT * FROM cuentas WHERE activa = false";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public List<Cuenta> getCuentasPorUsuario(int idUsuario) {
        List<Cuenta> cuentas = new ArrayList<>();
        String query = "SELECT c.* FROM cuentas c " +
                      "INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente " +
                      "WHERE cl.id_usuario = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                cuentas.add(crearCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cuentas;
    }

    @Override
    public boolean existeCBU(String cbu) {
        String query = "SELECT 1 FROM cuentas WHERE cbu = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setString(1, cbu);
            ResultSet rs = ps.executeQuery();
            
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public boolean existeNumeroCuenta(String numeroCuenta) {
        String query = "SELECT 1 FROM cuentas WHERE numero_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setString(1, numeroCuenta);
            ResultSet rs = ps.executeQuery();
            
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public boolean cuentaEstaActiva(int idCuenta) {
        String query = "SELECT activa FROM cuentas WHERE id_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idCuenta);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getBoolean("activa");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public boolean actualizarSaldo(int idCuenta, BigDecimal nuevoSaldo) {
        String query = "UPDATE cuentas SET saldo = ? WHERE id_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setBigDecimal(1, nuevoSaldo);
            ps.setInt(2, idCuenta);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    @Override
    public BigDecimal obtenerSaldo(int idCuenta) {
        String query = "SELECT saldo FROM cuentas WHERE id_cuenta = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idCuenta);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getBigDecimal("saldo");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return BigDecimal.ZERO;
    }

    @Override
    public int contarCuentasPorCliente(int idCliente) {
        String query = "SELECT COUNT(*) as total FROM cuentas WHERE id_cliente = ?";
        
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(query);
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }

    @Override
    public int ultimoID() {
        Connection cn = null;
        int id = 1;
        
        try {
            cn = Conexion.getConexion();
            String query = "SELECT MAX(id_cuenta) as ultimo_id FROM cuentas";
            PreparedStatement pst = cn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next() && rs.getInt("ultimo_id") > 0) {
                id = rs.getInt("ultimo_id") + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return id;
    }
    
    @Override
    public String generarNumeroCuenta() {
        String numeroCuenta;
        do {
            // Generar número de cuenta de 10 dígitos
            Random random = new Random();
            StringBuilder sb = new StringBuilder(10);
            for (int i = 0; i < 10; i++) {
                sb.append(random.nextInt(10));
            }
            numeroCuenta = sb.toString();
        } while (existeNumeroCuenta(numeroCuenta));
        
        return numeroCuenta;
    }

    @Override
    public String generarCBU() {
        String cbu;
        do {
            // Generar CBU de 22 dígitos
            Random random = new Random();
            StringBuilder sb = new StringBuilder(22);
            for (int i = 0; i < 22; i++) {
                sb.append(random.nextInt(10));
            }
            cbu = sb.toString();
        } while (existeCBU(cbu));
        
        return cbu;
    }

    private Cuenta crearCuenta(ResultSet rs) throws SQLException {
        Cuenta cuenta = new Cuenta();
        cuenta.setIdCuenta(rs.getInt("id_cuenta"));
        cuenta.setIdCliente(rs.getInt("id_cliente"));
        cuenta.setIdTipoCuenta(rs.getInt("id_tipo_cuenta"));
        cuenta.setNumeroCuenta(rs.getString("numero_cuenta"));
        cuenta.setCbu(rs.getString("cbu"));
        cuenta.setSaldo(rs.getBigDecimal("saldo"));
        cuenta.setFechaCreacion(rs.getDate("fecha_creacion"));
        cuenta.setActiva(rs.getBoolean("activa"));
        
        // Aquí podrías cargar también los objetos Cliente y TipoCuenta relacionados
        // si necesitas esa información completa
        
        return cuenta;
    }
}