/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.answer;

import java.io.Serializable;

/**
 *
 * @author GF65
 */
public class AnswerDTO implements Serializable{
    private String id;
    private String content;
    private boolean isCorrect;
    private String questionId;

    public AnswerDTO(String id, String content, boolean isCorrect, String questionId) {
        this.id = id;
        this.content = content;
        this.isCorrect = isCorrect;
        this.questionId = questionId;
    }
    
    public AnswerDTO(String id, String content, String questionId) {
        this.id = id;
        this.content = content;
        this.questionId = questionId;
    }

    public AnswerDTO() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }
    
}
