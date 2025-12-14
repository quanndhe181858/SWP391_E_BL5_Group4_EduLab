/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

import java.sql.Date;

/**
 *
 * @author quan
 */
public class UsersStatisticDTO {

    private Date date;
    private String dayName;
    private int userCount;

    public UsersStatisticDTO() {
    }

    public UsersStatisticDTO(Date date, String dayName, int userCount) {
        this.date = date;
        this.dayName = dayName;
        this.userCount = userCount;
    }

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

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    @Override
    public String toString() {
        return "UsersStatisticDTO{" + "date=" + date + ", dayName=" + dayName + ", userCount=" + userCount + '}';
    }

}
