package com.src.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.src.model.Order;
import com.src.model.OrderItem;

public class OrderDAOImpl implements OrderDAO {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String USER = "system";
    private static final String PASSWORD = "TIGER";

    @Override
    public boolean insertOrder(Order order, List<OrderItem> items) {
        Connection con = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        boolean success = false;

        try {
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            ensureTablesExist(con); // ✅ create tables if not exist
            con.setAutoCommit(false);

            // 1️⃣ Insert into ZINKIT_ORDERS
            String sqlOrder =
                "INSERT INTO ZINKIT_ORDERS " +
                "(ORDER_ID, USER_ID, TOTAL_AMOUNT, PAYMENT_METHOD, ORDER_STATUS, DELIVERY_ADDRESS, CITY, STATE, PINCODE) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            psOrder = con.prepareStatement(sqlOrder);
            psOrder.setString(1, order.getOrderId());
            psOrder.setString(2, order.getUserId());
            psOrder.setDouble(3, order.getTotalAmount());
            psOrder.setString(4, order.getPaymentMethod());
            psOrder.setString(5, order.getOrderStatus());
            psOrder.setString(6, order.getDeliveryAddress());
            psOrder.setString(7, order.getCity());
            psOrder.setString(8, order.getState());
            psOrder.setString(9, order.getPincode());
            psOrder.executeUpdate();

            // 2️⃣ Insert order items
            String sqlItem =
                "INSERT INTO ZINKIT_ORDER_ITEMS " +
                "(ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, QUANTITY, PRICE_AT_TIME) " +
                "VALUES (?, ?, ?, ?, ?)";
            psItem = con.prepareStatement(sqlItem);

            for (OrderItem item : items) {
                psItem.setString(1, item.getOrderItemId());
                psItem.setString(2, order.getOrderId());
                psItem.setString(3, item.getProductId());
                psItem.setInt(4, item.getQuantity());
                psItem.setDouble(5, item.getPriceAtTime());
                psItem.addBatch();
            }

            psItem.executeBatch();
            con.commit();
            success = true;
            System.out.println("✅ Order inserted successfully.");

        } catch (Exception e) {
            e.printStackTrace();
            try { if (con != null) con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            try {
                if (psItem != null) psItem.close();
                if (psOrder != null) psOrder.close();
                if (con != null) con.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
        return success;
    }

    @Override
    public List<Order> fetchOrdersByUser(String userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM ZINKIT_ORDERS WHERE USER_ID = ? ORDER BY ORDER_DATE DESC";

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getString("ORDER_ID"));
                o.setUserId(rs.getString("USER_ID"));
                o.setTotalAmount(rs.getDouble("TOTAL_AMOUNT"));
                o.setPaymentMethod(rs.getString("PAYMENT_METHOD"));
                o.setOrderStatus(rs.getString("ORDER_STATUS"));
                o.setOrderDate(rs.getTimestamp("ORDER_DATE"));
                o.setDeliveryAddress(rs.getString("DELIVERY_ADDRESS"));
                o.setCity(rs.getString("CITY"));
                o.setState(rs.getString("STATE"));
                o.setPincode(rs.getString("PINCODE"));
                orders.add(o);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    @Override
    public List<Order> getAllOrders() {
    	List<Order> orders = new ArrayList<>();
    	String query = "SELECT * FROM ZINKIT_ORDERS";
    	
    	try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
    			PreparedStatement ps = con.prepareStatement(query)) {
    		
    		ResultSet rs = ps.executeQuery();
    		
    		while (rs.next()) {
    			Order o = new Order();
    			o.setOrderId(rs.getString("ORDER_ID"));
    			o.setUserId(rs.getString("USER_ID"));
    			o.setTotalAmount(rs.getDouble("TOTAL_AMOUNT"));
    			o.setPaymentMethod(rs.getString("PAYMENT_METHOD"));
    			o.setOrderStatus(rs.getString("ORDER_STATUS"));
    			o.setOrderDate(rs.getTimestamp("ORDER_DATE"));
    			o.setDeliveryAddress(rs.getString("DELIVERY_ADDRESS"));
    			o.setCity(rs.getString("CITY"));
    			o.setState(rs.getString("STATE"));
    			o.setPincode(rs.getString("PINCODE"));
    			orders.add(o);
    		}
    		
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return orders;
    }
    
    @Override
    public List<OrderItem> fetchItemsByOrder(String orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM ZINKIT_ORDER_ITEMS WHERE ORDER_ID = ?";

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getString("ORDER_ITEM_ID"));
                item.setOrderId(rs.getString("ORDER_ID"));
                item.setProductId(rs.getString("PRODUCT_ID"));
                item.setQuantity(rs.getInt("QUANTITY"));
                item.setPriceAtTime(rs.getDouble("PRICE_AT_TIME"));
                items.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    
    @Override
    public Order fetchOrderById(String orderId) {
        Order o = null;
        String query = "SELECT * FROM ZINKIT_ORDERS WHERE ORDER_ID = ?";

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                o = new Order();
                o.setOrderId(rs.getString("ORDER_ID"));
                o.setUserId(rs.getString("USER_ID"));
                o.setTotalAmount(rs.getDouble("TOTAL_AMOUNT"));
                o.setPaymentMethod(rs.getString("PAYMENT_METHOD"));
                o.setOrderStatus(rs.getString("ORDER_STATUS"));
                o.setOrderDate(rs.getTimestamp("ORDER_DATE"));
                o.setDeliveryAddress(rs.getString("DELIVERY_ADDRESS"));
                o.setCity(rs.getString("CITY"));
                o.setState(rs.getString("STATE"));
                o.setPincode(rs.getString("PINCODE"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return o;
    }

    // 🔧 Create tables if not exist
    private void ensureTablesExist(Connection con) {
        try (Statement st = con.createStatement()) {
            ResultSet rs = st.executeQuery(
                "SELECT table_name FROM user_tables WHERE table_name = 'ZINKIT_ORDERS'"
            );
            if (!rs.next()) {
                System.out.println("⚙️ Creating table ZINKIT_ORDERS...");
                st.executeUpdate(
                    "CREATE TABLE ZINKIT_ORDERS (" +
                    "ORDER_ID VARCHAR2(30) PRIMARY KEY, " +
                    "USER_ID VARCHAR2(30) NOT NULL, " +
                    "TOTAL_AMOUNT NUMBER(10,2) NOT NULL, " +
                    "PAYMENT_METHOD VARCHAR2(50) DEFAULT 'COD', " +
                    "ORDER_STATUS VARCHAR2(30) DEFAULT 'Pending', " +
                    "ORDER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "DELIVERY_ADDRESS VARCHAR2(250), " +
                    "CITY VARCHAR2(50), " +
                    "STATE VARCHAR2(50), " +
                    "PINCODE VARCHAR2(10))"
                );
            }

            rs = st.executeQuery(
                "SELECT table_name FROM user_tables WHERE table_name = 'ZINKIT_ORDER_ITEMS'"
            );
            if (!rs.next()) {
                System.out.println("⚙️ Creating table ZINKIT_ORDER_ITEMS...");
                st.executeUpdate(
                    "CREATE TABLE ZINKIT_ORDER_ITEMS (" +
                    "ORDER_ITEM_ID VARCHAR2(36) PRIMARY KEY, " +
                    "ORDER_ID VARCHAR2(30) NOT NULL, " +
                    "PRODUCT_ID VARCHAR2(30) NOT NULL, " +
                    "QUANTITY NUMBER(10) DEFAULT 1 CHECK (QUANTITY > 0), " +
                    "PRICE_AT_TIME NUMBER(10,2) NOT NULL, " +
                    "TOTAL_PRICE NUMBER(10,2) GENERATED ALWAYS AS (QUANTITY * PRICE_AT_TIME) VIRTUAL)"
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
