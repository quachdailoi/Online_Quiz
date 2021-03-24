/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quizdetails;

/**
 *
 * @author GF65
 */
public class QuizDetailsDTO {
    private String questionId;
    private String questionContent;
    private boolean isRight;
    private String choosed_ans;
    private String correct_ans;
    private String quizId;
    private String ansA;
    private String ansB;
    private String ansC;
    private String ansD;

    public QuizDetailsDTO(String questionId, String questionContent, String correct_ans, String quizId, String ansB, String ansC, String ansD) {
        this.questionId = questionId;
        this.questionContent = questionContent;
        this.correct_ans = correct_ans;
        this.quizId = quizId;
        this.ansB = ansB;
        this.ansC = ansC;
        this.ansD = ansD;
    }

    public QuizDetailsDTO(String questionId, String questionContent, boolean isRight, String choosed_ans, String correct_ans, String quizId, String ansA, String ansB, String ansC, String ansD) {
        this.questionId = questionId;
        this.questionContent = questionContent;
        this.isRight = isRight;
        this.choosed_ans = choosed_ans;
        this.correct_ans = correct_ans;
        this.quizId = quizId;
        this.ansA = ansA;
        this.ansB = ansB;
        this.ansC = ansC;
        this.ansD = ansD;
    }

    
    
    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public boolean isIsRight() {
        return isRight;
    }

    public void setIsRight(boolean isRight) {
        this.isRight = isRight;
    }

    public String getChoosed_ans() {
        return choosed_ans;
    }

    public void setChoosed_ans(String choosed_ans) {
        this.choosed_ans = choosed_ans;
    }

    public String getCorrect_ans() {
        return correct_ans;
    }

    public void setCorrect_ans(String correct_ans) {
        this.correct_ans = correct_ans;
    }

    public String getQuizId() {
        return quizId;
    }

    public void setQuizId(String quizId) {
        this.quizId = quizId;
    }

    public String getAnsA() {
        return ansA;
    }

    public void setAnsA(String ansA) {
        this.ansA = ansA;
    }

    public String getAnsB() {
        return ansB;
    }

    public void setAnsB(String ansB) {
        this.ansB = ansB;
    }

    public String getAnsC() {
        return ansC;
    }

    public void setAnsC(String ansC) {
        this.ansC = ansC;
    }

    public String getAnsD() {
        return ansD;
    }

    public void setAnsD(String ansD) {
        this.ansD = ansD;
    }
    
    
}
