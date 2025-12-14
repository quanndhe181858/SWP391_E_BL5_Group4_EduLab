/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author quann
 */
public class TestAttempt {

    private int userId;
    private int testId;
    private int currentAttempted;
    private Float grade;
    private String status;

    public TestAttempt() {
    }

    public TestAttempt(int userId, int testId, int currentAttempted, Float grade, String status) {
        this.userId = userId;
        this.testId = testId;
        this.currentAttempted = currentAttempted;
        this.grade = grade;
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public int getCurrentAttempted() {
        return currentAttempted;
    }

    public void setCurrentAttempted(int currentAttempted) {
        this.currentAttempted = currentAttempted;
    }

    public Float getGrade() {
        return grade;
    }

    public void setGrade(Float grade) {
        this.grade = grade;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
