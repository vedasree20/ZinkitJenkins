package com.src.dao;

import java.util.List;

import com.src.model.Discount;

public interface DiscountDao {

    boolean add(Discount discount);

    boolean update(Discount discount);

    boolean delete(String discountId);

    Discount findById(String discountId);

    List<Discount> findAll();

    List<Discount> findAllActive();
    
    List<Discount> search(String keyword);

}
