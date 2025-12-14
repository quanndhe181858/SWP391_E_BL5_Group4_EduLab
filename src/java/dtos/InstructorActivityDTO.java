/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

import java.time.LocalDateTime;

/**
 *
 * @author quan
 */
public class InstructorActivityDTO {

    private String type;
    private String description;
    private String courseName;
    private LocalDateTime activityTime;
    private String timeAgo;

    public InstructorActivityDTO() {
    }

    public InstructorActivityDTO(String type, String description, String courseName,
            LocalDateTime activityTime, String timeAgo) {
        this.type = type;
        this.description = description;
        this.courseName = courseName;
        this.activityTime = activityTime;
        this.timeAgo = timeAgo;
    }

    // Getters and Setters
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public LocalDateTime getActivityTime() {
        return activityTime;
    }

    public void setActivityTime(LocalDateTime activityTime) {
        this.activityTime = activityTime;
    }

    public String getTimeAgo() {
        return timeAgo;
    }

    public void setTimeAgo(String timeAgo) {
        this.timeAgo = timeAgo;
    }
}
