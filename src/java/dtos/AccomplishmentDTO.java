/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

import java.sql.Timestamp;

public class AccomplishmentDTO {

    private int courseId;
    private String courseTitle;
    private Timestamp completedAt;
    private String courseStatus;
    private Float passedGrade;

    public AccomplishmentDTO() {
    }

    public AccomplishmentDTO(int courseId, String courseTitle, Timestamp completedAt, String courseStatus, Float passedGrade) {
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.completedAt = completedAt;
        this.courseStatus = courseStatus;
        this.passedGrade = passedGrade;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    public String getCourseStatus() {
        return courseStatus;
    }

    public void setCourseStatus(String courseStatus) {
        this.courseStatus = courseStatus;
    }

    public Float getPassedGrade() {
        return passedGrade;
    }

    public void setPassedGrade(Float passedGrade) {
        this.passedGrade = passedGrade;
    }
}
