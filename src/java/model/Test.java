/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author nguye
 */
public class Test {

    private int id;
    private String code;
    private String title;
    private String description;
    private int timeInterval;
    private int minGrade;
    private int courseId;
    private int courseSectionId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int createdBy;
    private int updatedBy;
    private int numberOfQuizzes;

    public Test() {

    }

    public Test(String code, String title, String description, int timeInterval, int courseId, int createdBy, int numberOfQuizzes) {
        this.code = code;
        this.title = title;
        this.description = description;
        this.timeInterval = timeInterval;
        this.courseId = courseId;
        this.createdBy = createdBy;
        this.numberOfQuizzes = numberOfQuizzes;
        this.courseSectionId = 0; // Đặt mặc định
        this.minGrade = 0; // Đặt mặc định
    }
    
    public Test(int id, String code, String title, String description, int timeInterval, int minGrade, int courseId, int courseSectionId, Timestamp createdAt, Timestamp updatedAt, int createdBy, int updatedBy) {
        this.id = id;
        this.code = code;
        this.title = title;
        this.description = description;
        this.timeInterval = timeInterval;
        this.minGrade = minGrade;
        this.courseId = courseId;
        this.courseSectionId = courseSectionId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.createdBy = createdBy;
        this.updatedBy = updatedBy;
    }

    
  
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTimeInterval() {
        return timeInterval;
    }

    public void setTimeInterval(int timeInterval) {
        this.timeInterval = timeInterval;
    }

    public int getMinGrade() {
        return minGrade;
    }

    public void setMinGrade(int minGrade) {
        this.minGrade = minGrade;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getCourseSectionId() {
        return courseSectionId;
    }

    public void setCourseSectionId(int courseSectionId) {
        this.courseSectionId = courseSectionId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }

    public int getNumberOfQuizzes() {
        return numberOfQuizzes;
    }

    public void setNumberOfQuizzes(int numberOfQuizzes) {
        this.numberOfQuizzes = numberOfQuizzes;
    }

    @Override
    public String toString() {
        return "Test{" + "id=" + id + ", code=" + code + ", title=" + title + ", description=" + description + ", timeInterval=" + timeInterval + ", minGrade=" + minGrade + ", courseId=" + courseId + ", courseSectionId=" + courseSectionId + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", createdBy=" + createdBy + ", updatedBy=" + updatedBy + ", numberOfQuizzes=" + numberOfQuizzes + '}';
    }

    
}
