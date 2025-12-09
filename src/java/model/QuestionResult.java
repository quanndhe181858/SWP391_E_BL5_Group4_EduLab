package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author vomin
 */
import java.util.List;

public class QuestionResult {

    private int questionId;
    private String content;
    private String type;

    private List<QuizAnswer> answers;
    private List<Integer> selectedAnswerIds;
    private List<Integer> correctAnswerIds;

    public boolean isCorrect() {
        if (selectedAnswerIds == null || correctAnswerIds == null) return false;
        return selectedAnswerIds.size() == correctAnswerIds.size()
                && selectedAnswerIds.containsAll(correctAnswerIds);
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<QuizAnswer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<QuizAnswer> answers) {
        this.answers = answers;
    }

   

    public List<Integer> getSelectedAnswerIds() {
        return selectedAnswerIds;
    }

    public void setSelectedAnswerIds(List<Integer> selectedAnswerIds) {
        this.selectedAnswerIds = selectedAnswerIds;
    }

    public List<Integer> getCorrectAnswerIds() {
        return correctAnswerIds;
    }

    public void setCorrectAnswerIds(List<Integer> correctAnswerIds) {
        this.correctAnswerIds = correctAnswerIds;
    }

    
}
