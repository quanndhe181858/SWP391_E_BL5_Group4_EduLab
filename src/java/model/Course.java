/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author quan
 */
public class Course {

    private int id;
    private String uuid;
    private String title;
    private String description;
    private String status;
    private String thumbnail;

    private int category_id;
    private Category category;

    private Timestamp created_at;
    private Timestamp updated_at;
    private int created_by;
    private int updated_by;

    private int totalSections;
    private String categoryName;
    private int enrollmentCount;

    public Course() {
    }

    public Course(int id, String title, String thumbnail, String categoryName, int enrollmentCount) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.categoryName = categoryName;
        this.enrollmentCount = enrollmentCount;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getEnrollmentCount() {
        return enrollmentCount;
    }

    public void setEnrollmentCount(int enrollmentCount) {
        this.enrollmentCount = enrollmentCount;
    }

    public int getTotalSections() {
        return totalSections;
    }

    public void setTotalSections(int totalSections) {
        this.totalSections = totalSections;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
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

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    public int getCreated_by() {
        return created_by;
    }

    public void setCreated_by(int created_by) {
        this.created_by = created_by;
    }

    public int getUpdated_by() {
        return updated_by;
    }

    public void setUpdated_by(int updated_by) {
        this.updated_by = updated_by;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getUpdatedAgo() {
        if (updated_at == null) {
            return "Chưa có cập nhật gì";
        }

        long diffMillis = System.currentTimeMillis() - updated_at.getTime();

        long seconds = diffMillis / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;
        long months = days / 30;
        long years = days / 365;

        if (seconds < 60) {
            return "Vừa mới cập nhật";
        } else if (minutes < 60) {
            return "Cập nhật " + minutes + " phút" + " trước";
        } else if (hours < 24) {
            return "Cập nhật " + hours + " giờ" + " trước";
        } else if (days < 30) {
            return "Cập nhật " + days + " ngày" + " trước";
        } else if (months < 12) {
            return "Cập nhật " + months + " tháng" + " trước";
        } else {
            return "Cập nhật " + years + " năm" + " trước";
        }
    }

    @Override
    public String toString() {
        return "Course{" + "id=" + id + ", uuid=" + uuid + ", title=" + title + ", description=" + description + ", status=" + status + ", category_id=" + category_id + ", category=" + category + ", created_at=" + created_at + ", updated_at=" + updated_at + ", created_by=" + created_by + ", updated_by=" + updated_by + '}';
    }

}
