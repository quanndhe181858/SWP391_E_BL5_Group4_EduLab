/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

/**
 *
 * @author quan
 */
public class InstructorDashboardStatisticDTO {

    private int myCourses;
    private int activeCourses;
    private int totalStudents;
    private int newStudentsThisWeek;
    private float avgCompletionRate;
    private int completedEnrollments;
    private int pendingTests;
    private int testsThisWeek;
    private int totalSections;
    private int totalTests;
    private int certificatesIssued;

    public InstructorDashboardStatisticDTO() {
    }

    public InstructorDashboardStatisticDTO(int myCourses, int activeCourses, int totalStudents,
            int newStudentsThisWeek, float avgCompletionRate,
            int completedEnrollments, int pendingTests,
            int testsThisWeek, int totalSections,
            int totalTests, int certificatesIssued) {
        this.myCourses = myCourses;
        this.activeCourses = activeCourses;
        this.totalStudents = totalStudents;
        this.newStudentsThisWeek = newStudentsThisWeek;
        this.avgCompletionRate = avgCompletionRate;
        this.completedEnrollments = completedEnrollments;
        this.pendingTests = pendingTests;
        this.testsThisWeek = testsThisWeek;
        this.totalSections = totalSections;
        this.totalTests = totalTests;
        this.certificatesIssued = certificatesIssued;
    }

    // Getters and Setters
    public int getMyCourses() {
        return myCourses;
    }

    public void setMyCourses(int myCourses) {
        this.myCourses = myCourses;
    }

    public int getActiveCourses() {
        return activeCourses;
    }

    public void setActiveCourses(int activeCourses) {
        this.activeCourses = activeCourses;
    }

    public int getTotalStudents() {
        return totalStudents;
    }

    public void setTotalStudents(int totalStudents) {
        this.totalStudents = totalStudents;
    }

    public int getNewStudentsThisWeek() {
        return newStudentsThisWeek;
    }

    public void setNewStudentsThisWeek(int newStudentsThisWeek) {
        this.newStudentsThisWeek = newStudentsThisWeek;
    }

    public float getAvgCompletionRate() {
        return avgCompletionRate;
    }

    public void setAvgCompletionRate(float avgCompletionRate) {
        this.avgCompletionRate = avgCompletionRate;
    }

    public int getCompletedEnrollments() {
        return completedEnrollments;
    }

    public void setCompletedEnrollments(int completedEnrollments) {
        this.completedEnrollments = completedEnrollments;
    }

    public int getPendingTests() {
        return pendingTests;
    }

    public void setPendingTests(int pendingTests) {
        this.pendingTests = pendingTests;
    }

    public int getTestsThisWeek() {
        return testsThisWeek;
    }

    public void setTestsThisWeek(int testsThisWeek) {
        this.testsThisWeek = testsThisWeek;
    }

    public int getTotalSections() {
        return totalSections;
    }

    public void setTotalSections(int totalSections) {
        this.totalSections = totalSections;
    }

    public int getTotalTests() {
        return totalTests;
    }

    public void setTotalTests(int totalTests) {
        this.totalTests = totalTests;
    }

    public int getCertificatesIssued() {
        return certificatesIssued;
    }

    public void setCertificatesIssued(int certificatesIssued) {
        this.certificatesIssued = certificatesIssued;
    }
}
