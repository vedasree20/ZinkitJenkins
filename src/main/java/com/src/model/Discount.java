package com.src.model;

public class Discount {

    private String id;              // Unique discount/coupon ID
    private String name;            // Name of the coupon/offer
    private DiscountType type;      // COUPON (wallet handled separately)
    private double value;           // Discount value (fixed or percentage)
    private boolean isPercentage;   // true → percentage, false → fixed
    private double minCartValue;    // Minimum cart total to apply this discount
    private boolean active;         // Whether the discount is active

    // ---- Getters and Setters ----

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public DiscountType getType() {
        return type;
    }

    public void setType(DiscountType type) {
        this.type = type;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public boolean isPercentage() {
        return isPercentage;
    }

    public void setPercentage(boolean isPercentage) {
        this.isPercentage = isPercentage;
    }

    public double getMinCartValue() {
        return minCartValue;
    }

    public void setMinCartValue(double minCartValue) {
        this.minCartValue = minCartValue;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    
    // Optional: for debugging / logging
    @Override
    public String toString() {
        return "Discount{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", type=" + type +
                ", value=" + value +
                ", isPercentage=" + isPercentage +
                ", minCartValue=" + minCartValue +
                ", active=" + active +
                ", "+
                '}';
    }
}
