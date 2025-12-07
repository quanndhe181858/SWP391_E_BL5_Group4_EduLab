package DTO;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import java.sql.Timestamp;

/**
 *
 * @author nguye
 */
public class TestDetailDTO {
    private int id;
    private String title;
    private String courseName;
    private String instructorName;
    private String categoryName;
    private Timestamp dateCreated;

    public TestDetailDTO() {}
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public Timestamp getDateCreated() { return dateCreated; }
    public void setDateCreated(Timestamp dateCreated) { this.dateCreated = dateCreated; }
    
    @Override
public String toString() {
    return "TestDetailDTO{" + "id=" + id + ", title=" + title + ", courseName=" + courseName + ", instructorName=" + instructorName + ", categoryName=" + categoryName + ", dateCreated=" + dateCreated + '}';
}
}
