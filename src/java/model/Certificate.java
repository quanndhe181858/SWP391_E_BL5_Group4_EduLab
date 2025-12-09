/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author vomin
 */
public class Certificate {

    private String userName;
    private String courseTitle;
    private String accomplishmentTitle;
    private String issuedAt;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public String getAccomplishmentTitle() {
        return accomplishmentTitle;
    }

    public void setAccomplishmentTitle(String accomplishmentTitle) {
        this.accomplishmentTitle = accomplishmentTitle;
    }

    public String getIssuedAt() {
        return issuedAt;
    }

    public void setIssuedAt(String issuedAt) {
        this.issuedAt = issuedAt;
    }
}
