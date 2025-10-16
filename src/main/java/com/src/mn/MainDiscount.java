package com.src.mn;


import com.src.dao.DiscountDaoImpl;
import com.src.model.Discount;
import com.src.model.DiscountType;

public class MainDiscount {
    public static void main(String[] args) {

    	DiscountDaoImpl dao = new DiscountDaoImpl();

        Discount discount = new Discount();
        discount.setId("DISC1002");
        discount.setName("Festival SS");
        discount.setType(DiscountType.COUPON);
        discount.setValue(15.0);
        discount.setPercentage(true);
        discount.setMinCartValue(500);
        discount.setActive(true);

        System.out.println("Adding discount...");
        System.out.println(dao.add(discount) ? "✅ Added successfully" : "❌ Failed to add");

//        System.out.println("\nFetching all discounts:");
//        dao.findAll().forEach(System.out::println);

//        System.out.println("\nSearching for 'festival':");
//        dao.search("festival").forEach(System.out::println);
//
//        System.out.println("\nUpdating discount...");
//        discount.setValue(20.0);
//        System.out.println(dao.update(discount) ? "✅ Updated successfully" : "❌ Update failed");
//
//        System.out.println("\nFetching by ID:");
//        System.out.println(dao.findById("DISC1001"));

//        System.out.println("\nDeleting discount...");
//        System.out.println(dao.delete("DISC1001") ? "✅ Deleted successfully" : "❌ Deletion failed");
    }
}
