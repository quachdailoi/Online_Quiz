/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quiz;

/**
 *
 * @author GF65
 */
public class QuizDTO {
    private String quizId;
    private String subjectId;

    public QuizDTO(String quizId, String subjectId) {
        this.quizId = quizId;
        this.subjectId = subjectId;
    }

    public QuizDTO() {
    }

    public String getQuizId() {
        return quizId;
    }

    public void setQuizId(String quizId) {
        this.quizId = quizId;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }
    
    
}
