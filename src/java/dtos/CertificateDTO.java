/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

import java.sql.Timestamp;

public class CertificateDTO {

    private int id;
    private String title;
    private int courseId;
    private String courseTitle;
    private Integer categoryId;
    private String categoryName;
    private String description;
    private String codePrefix;
    private String status;
    private Timestamp createdAt;
    private int issuedCount;

    public CertificateDTO() {
    }

    public CertificateDTO(int id, String title, int courseId, String courseTitle, Integer categoryId, String categoryName, String description, String codePrefix, String status, Timestamp createdAt, int issuedCount) {
        this.id = id;
        this.title = title;
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.codePrefix = codePrefix;
        this.status = status;
        this.createdAt = createdAt;
        this.issuedCount = issuedCount;
    }

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

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCodePrefix() {
        return codePrefix;
    }

    public void setCodePrefix(String codePrefix) {
        this.codePrefix = codePrefix;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getIssuedCount() {
        return issuedCount;
    }

    public void setIssuedCount(int issuedCount) {
        this.issuedCount = issuedCount;
    }

}
