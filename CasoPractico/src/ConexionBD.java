import java.sql.*;

public class ConexionBD {

    private static final String HOST = "database-luis.clrialamxgfn.us-east-1.rds.amazonaws.com";
    private static final String DB_NAME = "IESCaminas";
    private static final String USUARIO = "admin";
    private static final String PASSWORD = "Clave1391";
    private static final String URL = "jdbc:mysql://" + HOST + ":3306/" + DB_NAME;

    public static Connection conectar() {
        Connection conexion = null;
        try {
            System.out.println("Intentando conectar a la base de datos...");
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            System.out.println("¡Conexión establecida con éxito!");
        } catch (SQLException e) {
            System.err.println("Error de conexión: " + e.getMessage());
        }
        return conexion;
    }

    public static void main(String[] args) {
        System.out.println("Iniciando aplicación de prueba...");

        try (Connection con = conectar()) {

            if (con != null) {
                String sqlSelect = "SELECT * FROM alumnos";

                try (PreparedStatement pstmt = con.prepareStatement(sqlSelect);
                     ResultSet rs = pstmt.executeQuery()) {

                    while (rs.next()) {
                        System.out.println("ID: " + rs.getInt("id") +
                                ", Nombre: " + rs.getString("nombre") +
                                ", Curso: " + rs.getString("curso") +
                                ", Edad: " + rs.getInt("edad"));
                    }

                } catch (SQLException e) {
                    System.err.println("Error ejecutando la consulta: " + e.getMessage());
                }
            }

        } catch (SQLException e) {
            System.err.println("Fallo inesperado al cerrar la base de datos: " + e.getMessage());
        }
    }
}