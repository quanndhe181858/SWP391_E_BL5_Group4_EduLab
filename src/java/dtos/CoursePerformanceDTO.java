/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

/**
 *
 * @author quan
 */
public class CoursePerformanceDTO {

    private int id;
    private String courseName;
    private float completionRate;

    public CoursePerformanceDTO() {
    }

    public CoursePerformanceDTO(int id, String courseName, float completionRate) {
        this.id = id;
        this.courseName = courseName;
        this.completionRate = completionRate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public float getCompletionRate() {
        return completionRate;
    }

    public void setCompletionRate(float completionRate) {
        this.completionRate = completionRate;
    }
}
