/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CategoryDAO;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author quan
 */

public class CategoryServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private CategoryDAO categoryDao = new CategoryDAO();

    public List<Category> getCategories() {
        try {
            return categoryDao.getCategories();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public Category getCategorybyId(int categoryId) {
        try {
            return categoryDao.getCategoryById(categoryId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public int countCategories() {
        try {
            return categoryDao.countCategories();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return 0;
        }
    }
}
