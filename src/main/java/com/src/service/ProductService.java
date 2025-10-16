package com.src.service;

import java.util.List;

import com.src.model.Category;
import com.src.model.Product;

public interface ProductService {
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(String productId);
    Product getProductById(String productId);
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(Category category);
    List<Product> searchProducts(String keyword);


}
