package com.src.service;

import java.util.List;

import com.src.model.Discount;

public interface DiscountService {
    List<Discount> getAllActiveDiscounts();
    List<Discount> getAllDiscounts();
    Discount getDiscountById(String id);
    boolean createDiscount(Discount discount);
    boolean updateDiscount(Discount discount);
    boolean deleteDiscount(String id);
    List<Discount> search(String keyword);
    
    Discount calculateBestDiscount(double cartTotal, double walletBalance);
}
