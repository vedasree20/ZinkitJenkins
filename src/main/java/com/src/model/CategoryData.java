package com.src.model;


import java.util.HashMap;
import java.util.Map;

public class CategoryData {
    public static final Map<Category, String> IMAGES = new HashMap<>();
    public static final Map<Category, String> COLORS = new HashMap<>();

    static {
        IMAGES.put(Category.VEGETABLES, "https://i.pinimg.com/736x/ae/f4/f1/aef4f1fef5b031d49f03b5f155fa7d20.jpg");
        IMAGES.put(Category.FRUITS, "https://i.pinimg.com/736x/ed/14/79/ed1479c008c5ee7c50e7522a06f84fec.jpg");
        IMAGES.put(Category.DAIRY, "https://i.pinimg.com/1200x/a2/97/ca/a297caaca573e1ea85623d3061c85a7e.jpg");
        IMAGES.put(Category.BAKERY, "https://i.pinimg.com/1200x/e6/34/56/e63456c60da1e41470e0d36e91f8b3c4.jpg");
        IMAGES.put(Category.BEVERAGES, "https://i.pinimg.com/736x/f5/af/90/f5af905ecab5603fe6278b3bd6e9428c.jpg");
        IMAGES.put(Category.SNACKS, "https://i.pinimg.com/736x/cd/cd/f5/cdcdf5dd71263951bd24be1ed118c379.jpg");
        IMAGES.put(Category.MEAT_SEAFOOD, "https://i.pinimg.com/736x/4e/56/2b/4e562b2fe00aa1699c65056842f2fba8.jpg");
        IMAGES.put(Category.FROZEN_FOODS, "https://i.pinimg.com/736x/ab/af/47/abaf47625be9817c6561820b613b47c4.jpg");
        IMAGES.put(Category.HOUSEHOLD_ITEMS, "https://i.pinimg.com/736x/7b/1e/ca/7b1eca81497bc26431a8cc38caa5d314.jpg");
        IMAGES.put(Category.PERSONAL_CARE, "https://i.pinimg.com/1200x/f5/13/99/f5139906cc4bc5f8337c1767189dcd18.jpg");
        IMAGES.put(Category.GRAINS_PULSES, "https://i.pinimg.com/1200x/35/75/d2/3575d2b839b3ff57292536ea156c1d58.jpg");
        IMAGES.put(Category.SPICES_CONDIMENTS, "https://i.pinimg.com/1200x/93/6d/e8/936de808af511abb44e98fdc9d57c2c8.jpg");
        IMAGES.put(Category.OILS_FATS, "https://i.pinimg.com/736x/f1/c1/ca/f1c1cad377ceae44f010d74f5d90b4c1.jpg");
        IMAGES.put(Category.BABY_CARE, "https://i.pinimg.com/1200x/d0/68/1a/d0681a2c7810d2f7081ca08ed7ede309.jpg");
        IMAGES.put(Category.CLEANING_SUPPLIES, "https://i.pinimg.com/736x/2a/a4/41/2aa441ffed749e8f1242c7db0a5658e2.jpg");

        COLORS.put(Category.VEGETABLES, "#F1F1EE");
        COLORS.put(Category.FRUITS, "#FEF0E9");
        COLORS.put(Category.DAIRY, "#FEE9E9");
        COLORS.put(Category.BAKERY, "#FEE9E9");
        COLORS.put(Category.BEVERAGES, "#FEF0E9");
        COLORS.put(Category.SNACKS, "#F1F1EE");
        COLORS.put(Category.MEAT_SEAFOOD, "#E9FEF3");
        COLORS.put(Category.FROZEN_FOODS, "#F1F1EE");
        COLORS.put(Category.HOUSEHOLD_ITEMS, "#FEF0E9");
        COLORS.put(Category.PERSONAL_CARE, "#FEE9E9");
        COLORS.put(Category.GRAINS_PULSES, "#F1F1EE");
        COLORS.put(Category.SPICES_CONDIMENTS, "#FEF0E9");
        COLORS.put(Category.OILS_FATS, "#FEE9E9");
        COLORS.put(Category.BABY_CARE, "#E9FEF3");
        COLORS.put(Category.CLEANING_SUPPLIES, "#F1F1EE");
    }
}
