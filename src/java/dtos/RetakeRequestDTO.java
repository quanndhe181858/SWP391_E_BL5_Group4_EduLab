package dtos;

import java.util.Date;

public class RetakeRequestDTO {

    private int userId;
    private String userName;
    private String userEmail;

    private int courseId;
    private String courseTitle;

    private int testId;
    private String testTitle;

    private float grade;
    private int currentAttempted;
    private Date updatedAt;

    public RetakeRequestDTO() {
    }

    public RetakeRequestDTO(int userId, String userName, String userEmail, int courseId, String courseTitle, int testId, String testTitle, float grade, int currentAttempted, Date updatedAt) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.testId = testId;
        this.testTitle = testTitle;
        this.grade = grade;
        this.currentAttempted = currentAttempted;
        this.updatedAt = updatedAt;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
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

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public String getTestTitle() {
        return testTitle;
    }

    public void setTestTitle(String testTitle) {
        this.testTitle = testTitle;
    }

    public float getGrade() {
        return grade;
    }

    public void setGrade(float grade) {
        this.grade = grade;
    }

    public int getCurrentAttempted() {
        return currentAttempted;
    }

    public void setCurrentAttempted(int currentAttempted) {
        this.currentAttempted = currentAttempted;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

}
