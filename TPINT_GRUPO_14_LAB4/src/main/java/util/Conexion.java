package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    private static final String HOST = "jdbc:mysql://localhost:3306/";
    private static final String DB_NAME = "banco_db?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConexion() {
        Connection conn = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(HOST + DB_NAME, USER, PASSWORD);
        } catch (Exception e) {
            System.out.println("Error al conectar a la base de datos:");
            e.printStackTrace();
        }

        return conn;
    }
}
