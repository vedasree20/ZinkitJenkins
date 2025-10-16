package com.src.dao;


import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.src.annotations.Column;
import com.src.annotations.Id;
import com.src.annotations.Table;
import com.src.model.Category;
import com.src.model.Product;

public class ProductDAOImpl implements ProductDAO {

    private static final Connection getConnection() {
        return ProductDAO.getConnection(); // Your utility class to get Oracle/MySQL connection
    }

    @Override
    public boolean add(Product product) {
        try (Connection conn = getConnection()) {
            Table table = Product.class.getAnnotation(Table.class);
            String tableName = table.name();
            Field[] fields = Product.class.getDeclaredFields();

            StringBuilder columns = new StringBuilder();
            StringBuilder placeholders = new StringBuilder();

            for (Field field : fields) {
                if (field.isAnnotationPresent(Column.class)) {
                    Column col = field.getAnnotation(Column.class);
                    columns.append(col.name()).append(",");
                    placeholders.append("?,");

                    field.setAccessible(true);
                    // Auto-generate PRODUCT_ID if annotated with @Id and null
                    if (field.isAnnotationPresent(Id.class) && (field.get(product) == null || field.get(product).toString().isEmpty())) {
                        PreparedStatement psSeq = conn.prepareStatement("SELECT PRODUCT_SEQ.NEXTVAL FROM dual");
                        ResultSet rsSeq = psSeq.executeQuery();
                        if (rsSeq.next()) {
                            field.set(product, "P" + rsSeq.getLong(1));
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
                    Object value = field.get(product);
                    if (value instanceof Category) value = value.toString(); // store enum as string
                    ps.setObject(index++, value);
                }
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Product product) {
        try (Connection conn = getConnection()) {
            Table table = Product.class.getAnnotation(Table.class);
            String tableName = table.name();
            Field[] fields = Product.class.getDeclaredFields();

            StringBuilder sql = new StringBuilder("UPDATE " + tableName + " SET ");
            String idColumnName = null;
            Object idValue = null;

            for (Field field : fields) {
                if (field.isAnnotationPresent(Column.class)) {
                    Column col = field.getAnnotation(Column.class);
                    field.setAccessible(true);
                    Object value = field.get(product);

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
                    Object value = field.get(product);
                    if (value instanceof Category) value = value.toString();
                    ps.setObject(index++, value);
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
    public boolean delete(String productId) {
        try (Connection conn = getConnection()) {
            Table table = Product.class.getAnnotation(Table.class);
            String tableName = table.name();

            Field idField = null;
            for (Field f : Product.class.getDeclaredFields()) {
                if (f.isAnnotationPresent(Id.class) && f.isAnnotationPresent(Column.class)) {
                    idField = f;
                    break;
                }
            }

            if (idField == null) throw new RuntimeException("No primary key (@Id) found in Product model");

            String idColumnName = idField.getAnnotation(Column.class).name();
            String sql = "DELETE FROM " + tableName + " WHERE " + idColumnName + "=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Product findById(String productId) {
        Product product = null;
        try (Connection conn = getConnection()) {
            Table table = Product.class.getAnnotation(Table.class);
            String tableName = table.name();

            Field idField = null;
            for (Field f : Product.class.getDeclaredFields()) {
                if (f.isAnnotationPresent(Id.class) && f.isAnnotationPresent(Column.class)) {
                    idField = f;
                    break;
                }
            }

            if (idField == null) throw new RuntimeException("No primary key (@Id) found in Product model");

            String sql = "SELECT * FROM " + tableName + " WHERE " + idField.getAnnotation(Column.class).name() + "=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = mapResultSetToProduct(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM ZINKIT_PRODUCTS";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs)); // map everything
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

 // Helper to map ResultSet → Product
    private Product mapResultSetToProduct(ResultSet rs) throws Exception {
        Product product = new Product();
        Field[] fields = Product.class.getDeclaredFields();

        for (Field field : fields) {
            if (field.isAnnotationPresent(Column.class)) {
                Column col = field.getAnnotation(Column.class);
                field.setAccessible(true);

                Object value;

                // 🧠 Fix: handle Timestamp fields safely (Oracle compatibility)
                if (field.getType() == java.sql.Timestamp.class) {
                    value = rs.getTimestamp(col.name());
                } else {
                    value = rs.getObject(col.name());
                }

                if (value != null) {
                    // 🟢 Enum handling
                    if (field.getType() == Category.class) {
                        value = Category.valueOf(value.toString());
                    }

                    // 🟢 Numeric conversions (Oracle returns BigDecimal)
                    else if (value instanceof java.math.BigDecimal) {
                        Class<?> type = field.getType();
                        if (type == double.class || type == Double.class)
                            value = ((java.math.BigDecimal) value).doubleValue();
                        else if (type == float.class || type == Float.class)
                            value = ((java.math.BigDecimal) value).floatValue();
                        else if (type == long.class || type == Long.class)
                            value = ((java.math.BigDecimal) value).longValue();
                        else if (type == int.class || type == Integer.class)
                            value = ((java.math.BigDecimal) value).intValue();
                    }

                    // 🟢 Assign converted value
                    field.set(product, value);
                }
            }
        }

        return product;
    }

    
    @Override
    public List<Product> findByCategory(Category category) {
        List<Product> products = new ArrayList<>();

        try (Connection conn = getConnection()) { // your existing method
            Table table = Product.class.getAnnotation(Table.class);
            String tableName = table.name();

            String sql = "SELECT * FROM " + tableName + " WHERE UPPER(CATEGORY) = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, category.name());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs)); // your existing helper
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    @Override
    public boolean decrementQuantity(String productId, int quantity) {
        String sql = "UPDATE ZINKIT_PRODUCTS SET STOCK = STOCK - ? WHERE PRODUCT_ID = ? AND STOCK >= ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setString(2, productId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        try (Connection con = getConnection()) {

            String sql = "SELECT * FROM ZINKIT_PRODUCTS WHERE LOWER(PRODUCT_NAME) LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + keyword.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getString("PRODUCT_ID"));
                p.setProductName(rs.getString("PRODUCT_NAME"));
                p.setCategory(Category.valueOf(rs.getString("category").toUpperCase()));
                p.setPrice(rs.getDouble("PRICE"));
                p.setQuantityInStock(rs.getInt("QUANTITY_IN_STOCK"));
                p.setImageUrl(rs.getString("IMAGE_URL"));
                p.setDescription(rs.getString("DESCRIPTION"));
                products.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }


}
