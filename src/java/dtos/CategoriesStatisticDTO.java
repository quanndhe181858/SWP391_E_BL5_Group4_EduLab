/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

/**
 *
 * @author quan
 */
public class CategoriesStatisticDTO {

    private String categoryName;
    private int courseCount;
    private float percentage;

    public CategoriesStatisticDTO() {
    }

    public CategoriesStatisticDTO(String categoryName, int courseCount, float percentage) {
        this.categoryName = categoryName;
        this.courseCount = courseCount;
        this.percentage = percentage;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getCourseCount() {
        return courseCount;
    }

    public void setCourseCount(int courseCount) {
        this.courseCount = courseCount;
    }

    public float getPercentage() {
        return percentage;
    }

    public void setPercentage(float percentage) {
        this.percentage = percentage;
    }

}
