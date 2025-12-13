/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

/**
 *
 * @author quan
 */
public class DashboardStatisticDTO {

    private int totalUsers;
    private int newUsersThisMonth;
    private int totalCourses;
    private int activeCourses;
    private int totalEnrollments;
    private int enrollmentsThisWeek;
    private float completionRate;
    private int completedCourse;
    private int totalCategories;
    private int totalTests;
    private int totalQuizzes;
    private int totalMedia;

    public DashboardStatisticDTO() {
    }

    public DashboardStatisticDTO(int totalUsers, int newUsersThisMonth, int totalCourses, int activeCourses, int totalEnrollments, int enrollmentsThisWeek, float completionRate, int completedCourse, int totalCategories, int totalTests, int totalQuizzes, int totalMedia) {
        this.totalUsers = totalUsers;
        this.newUsersThisMonth = newUsersThisMonth;
        this.totalCourses = totalCourses;
        this.activeCourses = activeCourses;
        this.totalEnrollments = totalEnrollments;
        this.enrollmentsThisWeek = enrollmentsThisWeek;
        this.completionRate = completionRate;
        this.completedCourse = completedCourse;
        this.totalCategories = totalCategories;
        this.totalTests = totalTests;
        this.totalQuizzes = totalQuizzes;
        this.totalMedia = totalMedia;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getNewUsersThisMonth() {
        return newUsersThisMonth;
    }

    public void setNewUsersThisMonth(int newUsersThisMonth) {
        this.newUsersThisMonth = newUsersThisMonth;
    }

    public int getTotalCourses() {
        return totalCourses;
    }

    public void setTotalCourses(int totalCourses) {
        this.totalCourses = totalCourses;
    }

    public int getActiveCourses() {
        return activeCourses;
    }

    public void setActiveCourses(int activeCourses) {
        this.activeCourses = activeCourses;
    }

    public int getTotalEnrollments() {
        return totalEnrollments;
    }

    public void setTotalEnrollments(int totalEnrollments) {
        this.totalEnrollments = totalEnrollments;
    }

    public int getEnrollmentsThisWeek() {
        return enrollmentsThisWeek;
    }

    public void setEnrollmentsThisWeek(int enrollmentsThisWeek) {
        this.enrollmentsThisWeek = enrollmentsThisWeek;
    }

    public float getCompletionRate() {
        return completionRate;
    }

    public void setCompletionRate(float completionRate) {
        this.completionRate = completionRate;
    }

    public int getCompletedCourse() {
        return completedCourse;
    }

    public void setCompletedCourse(int completedCourse) {
        this.completedCourse = completedCourse;
    }

    public int getTotalCategories() {
        return totalCategories;
    }

    public void setTotalCategories(int totalCategories) {
        this.totalCategories = totalCategories;
    }

    public int getTotalTests() {
        return totalTests;
    }

    public void setTotalTests(int totalTests) {
        this.totalTests = totalTests;
    }

    public int getTotalQuizzes() {
        return totalQuizzes;
    }

    public void setTotalQuizzes(int totalQuizzes) {
        this.totalQuizzes = totalQuizzes;
    }

    public int getTotalMedia() {
        return totalMedia;
    }

    public void setTotalMedia(int totalMedia) {
        this.totalMedia = totalMedia;
    }

    @Override
    public String toString() {
        return "DashboardStatisticDTO{" + "totalUsers=" + totalUsers + ", newUsersThisMonth=" + newUsersThisMonth + ", totalCourses=" + totalCourses + ", activeCourses=" + activeCourses + ", totalEnrollments=" + totalEnrollments + ", enrollmentsThisWeek=" + enrollmentsThisWeek + ", completionRate=" + completionRate + ", completedCourse=" + completedCourse + ", totalCategories=" + totalCategories + ", totalTests=" + totalTests + ", totalQuizzes=" + totalQuizzes + ", totalMedia=" + totalMedia + '}';
    }

}
