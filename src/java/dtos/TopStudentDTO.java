/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dtos;

/**
 *
 * @author quan
 */
public class TopStudentDTO {

    private int id;
    private String firstName;
    private String lastName;
    private int coursesCompleted;
    private float avgScore;

    public TopStudentDTO() {
    }

    public TopStudentDTO(int id, String firstName, String lastName,
            int coursesCompleted, float avgScore) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.coursesCompleted = coursesCompleted;
        this.avgScore = avgScore;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public int getCoursesCompleted() {
        return coursesCompleted;
    }

    public void setCoursesCompleted(int coursesCompleted) {
        this.coursesCompleted = coursesCompleted;
    }

    public float getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(float avgScore) {
        this.avgScore = avgScore;
    }
}
