package com.src.mn;

import java.util.List;
import java.util.Scanner;

import com.src.dao.ProductDAO;
import com.src.dao.ProductDAOImpl;
import com.src.model.Category;
import com.src.model.Product;

public class MainProduct {
    private static final ProductDAO productDAO = new ProductDAOImpl();
    private static final Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {
        int choice = 0;
        do {
            System.out.println("\n===== Zinkit Grocery Product Management =====");
            System.out.println("1. Add Product");
            System.out.println("2. Update Product");
            System.out.println("3. Delete Product");
            System.out.println("4. View Product by ID");
            System.out.println("5. List All Products");
            System.out.println("6. List Products by Category");
            System.out.println("7. Exit");
            System.out.print("Enter your choice: ");
            choice = sc.nextInt();
            sc.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    addProduct();
                    break;
                case 2:
                    updateProduct();
                    break;
                case 3:
                    deleteProduct();
                    break;
                case 4:
                    viewProductById();
                    break;
                case 5:
                    listAllProducts();
                    break;
                case 6:
                    listProductsByCategory();
                    break;
                case 7:
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice!");
            }
        } while (choice != 7);
    }

    private static void addProduct() {
        try {
            Product p = new Product();
            System.out.print("Enter product name: ");
            p.setProductName(sc.nextLine());
            System.out.print("Enter price: ");
            p.setPrice(sc.nextDouble());
            System.out.print("Enter quantity: ");
            p.setQuantityInStock(sc.nextInt());
            sc.nextLine(); // consume newline
            System.out.println("Select category: ");
            Category[] cats = Category.values();
            for (int i = 0; i < cats.length; i++) {
                System.out.println((i+1) + ". " + cats[i]);
            }
            int catChoice = sc.nextInt();
            sc.nextLine(); // consume newline
            p.setCategory(cats[catChoice-1]);
            System.out.print("Enter image URL: ");
            p.setImageUrl(sc.nextLine());

            if (productDAO.add(p)) System.out.println("Product added successfully!");
            else System.out.println("Failed to add product!");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static void updateProduct() {
        System.out.print("Enter product ID to update: ");
        String id = sc.nextLine();
        Product p = productDAO.findById(id);
        if (p == null) {
            System.out.println("Product not found!");
            return;
        }
        System.out.print("Enter new name (" + p.getProductName() + "): ");
        String name = sc.nextLine();
        if (!name.isEmpty()) p.setProductName(name);
        System.out.print("Enter new price (" + p.getPrice() + "): ");
        String priceStr = sc.nextLine();
        if (!priceStr.isEmpty()) p.setPrice(Double.parseDouble(priceStr));
        if (productDAO.update(p)) System.out.println("Product updated!");
        else System.out.println("Update failed!");
    }

    private static void deleteProduct() {
        System.out.print("Enter product ID to delete: ");
        String id = sc.nextLine();
        if (productDAO.delete(id)) System.out.println("Deleted successfully!");
        else System.out.println("Delete failed!");
    }

    private static void viewProductById() {
        System.out.print("Enter product ID: ");
        String id = sc.nextLine();
        Product p = productDAO.findById(id);
        if (p != null) System.out.println(p);
        else System.out.println("Product not found!");
    }

    private static void listAllProducts() {
        List<Product> products = productDAO.findAll();
        if (products.isEmpty()) System.out.println("No products found.");
        else products.forEach(System.out::println);
    }

    // New method: List products by category
    private static void listProductsByCategory() {
        System.out.println("Select category: ");
        Category[] cats = Category.values();
        for (int i = 0; i < cats.length; i++) {
            System.out.println((i+1) + ". " + cats[i]);
        }
        int catChoice = sc.nextInt();
        sc.nextLine(); // consume newline
        Category selectedCategory = cats[catChoice - 1];

        List<Product> products = productDAO.findByCategory(selectedCategory);
        if (products.isEmpty()) System.out.println("No products found in this category.");
        else {
            System.out.println("\nProducts in " + selectedCategory + " category:");
            products.forEach(System.out::println);
        }
    }
}
