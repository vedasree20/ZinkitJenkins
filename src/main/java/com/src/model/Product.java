package com.src.model;

import java.sql.Timestamp;

import com.src.annotations.Column;
import com.src.annotations.Id;
import com.src.annotations.Table;

@Table(name="ZINKIT_PRODUCTS")
public class Product {

    @Id
    @Column(name = "PRODUCT_ID", nullable = false, length = 30, unique = true)
    private String productId;

    @Column(name = "PRODUCT_NAME", nullable = false, length = 100)
    private String productName;

    @Column(name = "CATEGORY", nullable = false, length = 50)
    private Category category; // Enum for categories

    @Column(name = "DESCRIPTION", length = 500)
    private String description;

    @Column(name = "PRICE", nullable = false)
    private double price;

    @Column(name = "DISCOUNT")
    private double discount; // in percentage

    @Column(name = "QUANTITY_IN_STOCK")
    private int quantityInStock;

    @Column(name = "UNIT", length = 20)
    private String unit; // e.g., "kg", "pcs", "liters"

    @Column(name = "IMAGE_URL", length = 255)
    private String imageUrl;

    @Column(name = "CREATED_AT")
    private Timestamp createdAt;

    @Column(name = "UPDATED_AT")
    private Timestamp updatedAt;

    // ======== Getters and Setters ========
    public String getProductId() {
        return productId;
    }
    public void setProductId(String productId) {
        this.productId = productId;
    }
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }
    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }
    
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public double getDiscount() {
        return discount;
    }
    public void setDiscount(double discount) {
        this.discount = discount;
    }
    public int getQuantityInStock() {
        return quantityInStock;
    }
    public void setQuantityInStock(int quantityInStock) {
        this.quantityInStock = quantityInStock;
    }
    public String getUnit() {
        return unit;
    }
    public void setUnit(String unit) {
        this.unit = unit;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // ======== toString() ========
    @Override
    public String toString() {
        return "Product [productId=" + productId + ", productName=" + productName +
                ", category=" + category + ", description=" + description +
                ", price=" + price + ", discount=" + discount +
                ", quantityInStock=" + quantityInStock + ", unit=" + unit +
                ", imageUrl=" + imageUrl + ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt + "]";
    }
}
