package com.src.dao;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.src.annotations.Column;
import com.src.annotations.Id;
import com.src.annotations.Table;
import com.src.model.User;

import oracle.sql.TIMESTAMP;


public class UserDAOImpl implements UserDAO {

    public static final Connection getConnection() {
        return UserDAO.getConnection();
    }

    @Override
    public boolean register(User user) {
        try (Connection conn = getConnection()) {

            // Check if email already exists
            if (findByEmail(user.getEmail()) != null) {
                System.out.println("Email already exists!");
                return false;
            }

            Table table = User.class.getAnnotation(Table.class);
            String tableName = table.name();
            Field[] fields = User.class.getDeclaredFields();

            StringBuilder columns = new StringBuilder();
            StringBuilder placeholders = new StringBuilder();

            for (Field field : fields) {
                if (field.isAnnotationPresent(Column.class)) {
                    Column col = field.getAnnotation(Column.class);
                    columns.append(col.name()).append(",");
                    field.setAccessible(true);      // <-- add this line
                    placeholders.append("?,");

                    // Auto-generate USER_ID using sequence if null
                    if (field.isAnnotationPresent(Id.class) && (field.get(user) == null || field.get(user).toString().isEmpty())) {
                        PreparedStatement psSeq = conn.prepareStatement("SELECT USER_SEQ.NEXTVAL FROM dual");
                        ResultSet rsSeq = psSeq.executeQuery();
                        if (rsSeq.next()) {
                            field.setAccessible(true);
                            field.set(user, "U" + rsSeq.getLong(1));
                        }
                        rsSeq.close();
                        psSeq.close();
                    }
                }
            }

            columns.setLength(columns.length() - 1);
            placeholders.setLength(placeholders.length() - 1);

            String sql = "INSERT INTO " + tableName + " (" + columns + ") VALUES (" + placeholders + ")";
            PreparedStatement ps = conn.prepareStatement(sql);

            int index = 1;
            for (Field field : fields) {
                if (field.isAnnotationPresent(Column.class)) {
                    field.setAccessible(true);
                    ps.setObject(index++, field.get(user));
                }
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(User user) {
        try (Connection conn = getConnection()) {

            Table table = User.class.getAnnotation(Table.class);
            String tableName = table.name();
            Field[] fields = User.class.getDeclaredFields();

            StringBuilder sql = new StringBuilder("UPDATE " + tableName + " SET ");
            String idColumnName = null;
            Object idValue = null;

            for (Field field : fields) {
                if (field.isAnnotationPresent(Column.class)) {
                    Column col = field.getAnnotation(Column.class);
                    field.setAccessible(true);
                    Object value = field.get(user);

                    if (field.isAnnotationPresent(Id.class)) {
                        idColumnName = col.name();
                        idValue = value;
                        continue;
                    }

                    sql.append(col.name()).append("=?,");
                }
            }

            sql.setLength(sql.length() - 1);
            sql.append(" WHERE ").append(idColumnName).append("=?");

            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int index = 1;
            for (Field field : fields) {
                if (field.isAnnotationPresent(Column.class) && !field.isAnnotationPresent(Id.class)) {
                    field.setAccessible(true);
                    ps.setObject(index++, field.get(user));
                }
            }

            ps.setObject(index, idValue);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(String userId) {
        try (Connection conn = getConnection()) {

            Table table = User.class.getAnnotation(Table.class);
            String tableName = table.name();

            Field idField = null;
            for (Field f : User.class.getDeclaredFields()) {
                if (f.isAnnotationPresent(Id.class) && f.isAnnotationPresent(Column.class)) {
                    idField = f;
                    break;
                }
            }

            if (idField == null) throw new RuntimeException("No primary key (@Id) found in User model");

            String idColumnName = idField.getAnnotation(Column.class).name();
            String sql = "DELETE FROM " + tableName + " WHERE " + idColumnName + "=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> displayAll() {
        List<User> users = new ArrayList<>();
        try (Connection conn = getConnection()) {

            Table table = User.class.getAnnotation(Table.class);
            String tableName = table.name();
            String sql = "SELECT * FROM " + tableName;
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public User findByEmail(String email) {
        User user = null;
        try (Connection conn = getConnection()) {

            Table table = User.class.getAnnotation(Table.class);
            String tableName = table.name();

            Field emailField = null;
            for (Field f : User.class.getDeclaredFields()) {
                if (f.isAnnotationPresent(Column.class)) {
                    Column col = f.getAnnotation(Column.class);
                    if ("EMAIL".equalsIgnoreCase(col.name())) {
                        emailField = f;
                        break;
                    }
                }
            }

            if (emailField == null) throw new RuntimeException("EMAIL column not found in User model");

            String sql = "SELECT * FROM " + tableName + " WHERE " + emailField.getAnnotation(Column.class).name() + "=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) user = mapResultSetToUser(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public User findById(String userId) {
        User user = null;
        try (Connection conn = getConnection()) {

            Table table = User.class.getAnnotation(Table.class);
            String tableName = table.name();

            Field idField = null;
            for (Field f : User.class.getDeclaredFields()) {
                if (f.isAnnotationPresent(Id.class) && f.isAnnotationPresent(Column.class)) {
                    idField = f;
                    break;
                }
            }

            if (idField == null) throw new RuntimeException("No primary key (@Id) found in User model");

            String sql = "SELECT * FROM " + tableName + " WHERE " + idField.getAnnotation(Column.class).name() + "=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) user = mapResultSetToUser(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Helper method: Map ResultSet → User safely
    private User mapResultSetToUser(ResultSet rs) throws Exception {
        User user = new User();
        Field[] fields = User.class.getDeclaredFields();

        for (Field field : fields) {
            if (field.isAnnotationPresent(Column.class)) {
                Column col = field.getAnnotation(Column.class);
                field.setAccessible(true);
                Object value = rs.getObject(col.name());

                if (value instanceof TIMESTAMP) {
                    value = ((TIMESTAMP) value).timestampValue();
                } else if (value instanceof java.sql.Timestamp) {
                    value = (Timestamp) value;
                } else if (value instanceof java.math.BigDecimal) {
                    Class<?> type = field.getType();
                    if (type == double.class || type == Double.class) value = ((java.math.BigDecimal) value).doubleValue();
                    else if (type == float.class || type == Float.class) value = ((java.math.BigDecimal) value).floatValue();
                    else if (type == long.class || type == Long.class) value = ((java.math.BigDecimal) value).longValue();
                    else if (type == int.class || type == Integer.class) value = ((java.math.BigDecimal) value).intValue();
                }

                field.set(user, value);
            }
        }

        return user;
    }
}
