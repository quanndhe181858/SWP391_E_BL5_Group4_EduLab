/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

import java.util.Date;

/**
 *
 * @author quan
 */
public class EngagementStatisticDTO {

    private Date date;
    private String dayName;
    private int activeStudents;

    public EngagementStatisticDTO() {
    }

    public EngagementStatisticDTO(Date date, String dayName, int activeStudents) {
        this.date = date;
        this.dayName = dayName;
        this.activeStudents = activeStudents;
    }

    // Getters and Setters
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDayName() {
        return dayName;
    }

    public void setDayName(String dayName) {
        this.dayName = dayName;
    }

    public int getActiveStudents() {
        return activeStudents;
    }

    public void setActiveStudents(int activeStudents) {
        this.activeStudents = activeStudents;
    }
}
