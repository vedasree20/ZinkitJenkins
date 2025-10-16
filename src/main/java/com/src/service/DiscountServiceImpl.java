package com.src.service;
import java.util.List;

import com.src.dao.DiscountDao;
import com.src.model.Discount;

public class DiscountServiceImpl implements DiscountService {

    private DiscountDao discountDao;

    public DiscountServiceImpl(DiscountDao discountDao) {
        this.discountDao = discountDao;
    }

    @Override
    public List<Discount> getAllActiveDiscounts() {
        return discountDao.findAllActive();
    }
    
    @Override
    public List<Discount> getAllDiscounts() {
    	return discountDao.findAll();
    }

    @Override
    public Discount getDiscountById(String id) {
        return discountDao.findById(id);
    }

    @Override
    public boolean createDiscount(Discount discount) {
       return discountDao.add(discount);
    }

    @Override
    public boolean updateDiscount(Discount discount) {
       return discountDao.update(discount);
    }

    @Override
    public boolean deleteDiscount(String id) {
        return discountDao.delete(id);
    }

    @Override
    public Discount calculateBestDiscount(double cartTotal, double walletBalance) {
        double maxDiscountValue = 0;
        Discount bestDiscount = null;

        // Wallet discount (from user table)
        if (walletBalance > 0) {
            double walletDiscount = Math.min(cartTotal, walletBalance);
            maxDiscountValue = walletDiscount;
            bestDiscount = new Discount();
            bestDiscount.setType(null); // Could use WALLET type if needed
            bestDiscount.setValue(walletDiscount);
            bestDiscount.setName("Wallet Balance");
        }

        // Check coupons
        for (Discount d : discountDao.findAllActive()) {
            if (cartTotal >= d.getMinCartValue()) {
                double discountAmount = d.isPercentage() ? (cartTotal * d.getValue() / 100) : d.getValue();
                if (discountAmount > maxDiscountValue) {
                    maxDiscountValue = discountAmount;
                    bestDiscount = d;
                }
            }
        }

        return bestDiscount;
    }

	@Override
	public List<Discount> search(String keyword) {
		// TODO Auto-generated method stub
		return discountDao.search(keyword);
	}
}
