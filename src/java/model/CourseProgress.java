package model;

import java.sql.Timestamp;

public class CourseProgress {

    private int id;
    private int userId;
    private int courseId;
    private int sectionId;
    private int progressPercent;
    private String status;
    private Timestamp lastAccessedAt;
    private Timestamp completedAt;

    public CourseProgress() {
    }

    public CourseProgress(int id, int userId, int courseId, int sectionId, int progressPercent, String status, Timestamp lastAccessedAt, Timestamp completedAt) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.sectionId = sectionId;
        this.progressPercent = progressPercent;
        this.status = status;
        this.lastAccessedAt = lastAccessedAt;
        this.completedAt = completedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getSectionId() {
        return sectionId;
    }

    public void setSectionId(int sectionId) {
        this.sectionId = sectionId;
    }

    public int getProgressPercent() {
        return progressPercent;
    }

    public void setProgressPercent(int progressPercent) {
        this.progressPercent = progressPercent;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getLastAccessedAt() {
        return lastAccessedAt;
    }

    public void setLastAccessedAt(Timestamp lastAccessedAt) {
        this.lastAccessedAt = lastAccessedAt;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("CourseProgress{");
        sb.append("id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", courseId=").append(courseId);
        sb.append(", sectionId=").append(sectionId);
        sb.append(", progressPercent=").append(progressPercent);
        sb.append(", status=").append(status);
        sb.append(", lastAccessedAt=").append(lastAccessedAt);
        sb.append(", completedAt=").append(completedAt);
        sb.append('}');
        return sb.toString();
    }

}
