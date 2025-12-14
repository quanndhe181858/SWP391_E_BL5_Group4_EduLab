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
public class RecentActivityDTO {

    private String type;
    private String description;
    private LocalDateTime activityTime;
    private String timeAgo;

    public RecentActivityDTO(String type, String description, LocalDateTime activityTime, String timeAgo) {
        this.type = type;
        this.description = description;
        this.activityTime = activityTime;
        this.timeAgo = timeAgo;
    }

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

    @Override
    public String toString() {
        return "RecentActivityDTO{" + "type=" + type + ", description=" + description + ", activityTime=" + activityTime + ", timeAgo=" + timeAgo + '}';
    }

}
