package com.src.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	private static final String URL = "jdbc:oracle:thin:@//localhost:1521/xe";
    private static final String USER = "system";
    private static final String PASSWORD = "TIGER";

    private static Connection connection;

    // Return a singleton connection
    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            } catch (ClassNotFoundException e) {
                System.err.println("Oracle JDBC Driver not found!");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Failed to connect to DB!");
                e.printStackTrace();
            }
        }
        return connection;
    }

    // Return Statement object
    public static Statement getMyStatement() {
        try {
            return getConnection().createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

       // ------------------- Get Next ID from Sequence -------------------
    public static String getNextId(String sequenceName, String prefix) {
        String id = null;
        String sql = "SELECT " + sequenceName + ".NEXTVAL AS ID FROM dual";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                long nextVal = rs.getLong("ID");
                id = prefix + nextVal; // e.g., U1001, S2001, P3001, O4001
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }
}
