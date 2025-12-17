/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

/**
 *
 * @author quan
 */
public class InstructorCourseDTO {

    private int id;
    private String title;
    private String thumbnail;
    private String status;
    private String categoryName;
    private int studentCount;
    private float completionRate;
    private boolean hide_by_admin;

    public InstructorCourseDTO() {
    }

    public InstructorCourseDTO(int id, String title, String thumbnail, String status,
            String categoryName, int studentCount, float completionRate) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.status = status;
        this.categoryName = categoryName;
        this.studentCount = studentCount;
        this.completionRate = completionRate;
    }

    public boolean isHide_by_admin() {
        return hide_by_admin;
    }

    public void setHide_by_admin(boolean hide_by_admin) {
        this.hide_by_admin = hide_by_admin;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(int studentCount) {
        this.studentCount = studentCount;
    }

    public float getCompletionRate() {
        return completionRate;
    }

    public void setCompletionRate(float completionRate) {
        this.completionRate = completionRate;
    }
}
