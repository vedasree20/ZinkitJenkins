package com.src.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.src.model.Discount;
import com.src.model.DiscountType;

public class DiscountDaoImpl implements DiscountDao {

    private static Connection getConnection() throws Exception {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "system";
        String password = "TIGER";
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(url, username, password);
    }

    @Override
    public boolean add(Discount discount) {
        String sql = "INSERT INTO DISCOUNTS(ID, NAME, TYPE, VALUE, IS_PERCENTAGE, MIN_CART_VALUE, ACTIVE) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, discount.getId());
            ps.setString(2, discount.getName());
            ps.setString(3, discount.getType().name());
            ps.setDouble(4, discount.getValue());
            ps.setInt(5, discount.isPercentage() ? 1 : 0);
            ps.setDouble(6, discount.getMinCartValue());
            ps.setInt(7, discount.isActive() ? 1 : 0);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(Discount discount) {
        String sql = "UPDATE DISCOUNTS SET NAME=?, TYPE=?, VALUE=?, IS_PERCENTAGE=?, MIN_CART_VALUE=?, ACTIVE=? WHERE ID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, discount.getName());
            ps.setString(2, discount.getType().name());
            ps.setDouble(3, discount.getValue());
            ps.setInt(4, discount.isPercentage() ? 1 : 0);
            ps.setDouble(5, discount.getMinCartValue());
            ps.setInt(6, discount.isActive() ? 1 : 0);
            ps.setString(7, discount.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(String discountId) {
        String sql = "DELETE FROM DISCOUNTS WHERE ID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, discountId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Discount findById(String discountId) {
        String sql = "SELECT * FROM DISCOUNTS WHERE ID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, discountId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapResultSetToDiscount(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Discount> findAll() {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM DISCOUNTS";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToDiscount(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Discount> findAllActive() {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM DISCOUNTS WHERE ACTIVE=1";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToDiscount(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Discount mapResultSetToDiscount(ResultSet rs) throws Exception {
        Discount discount = new Discount();
        discount.setId(rs.getString("ID"));
        discount.setName(rs.getString("NAME"));
        discount.setType(DiscountType.valueOf(rs.getString("TYPE")));
        discount.setValue(rs.getDouble("VALUE"));
        discount.setPercentage(rs.getInt("IS_PERCENTAGE") == 1);
        discount.setMinCartValue(rs.getDouble("MIN_CART_VALUE"));
        discount.setActive(rs.getInt("ACTIVE") == 1);

        return discount;
    }
    
    @Override
    public List<Discount> search(String keyword) {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM DISCOUNTS WHERE LOWER(NAME) LIKE ? OR LOWER(TYPE) LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String likeKeyword = "%" + keyword.toLowerCase() + "%";
            ps.setString(1, likeKeyword);
            ps.setString(2, likeKeyword);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToDiscount(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
