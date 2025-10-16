package com.src.service;


import java.util.List;

import com.src.dao.ProductDAO;
import com.src.dao.ProductDAOImpl;
import com.src.model.Category;
import com.src.model.Product;

public class ProductServiceImpl implements ProductService {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public boolean addProduct(Product product) {
        return productDAO.add(product);
    }

    @Override
    public boolean updateProduct(Product product) {
        return productDAO.update(product);
    }

    @Override
    public boolean deleteProduct(String productId) {
        return productDAO.delete(productId);
    }

    @Override
    public Product getProductById(String productId) {
        return productDAO.findById(productId);
    }

    @Override
    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }
    @Override
    public List<Product> getProductsByCategory(Category category) {
        return productDAO.findByCategory(category);
    }
    
    @Override
    public List<Product> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }

}

