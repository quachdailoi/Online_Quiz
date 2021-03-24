/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quiz;

import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author GF65
 */
public class QuizDetails {

    private String questionId;
    private String quizId;
    private String questionContent;
    private String correctAnswer;
    private ArrayList<String> listAns;
    private String ansA;
    private String ansB;
    private String ansC;
    private String ansD;

    public QuizDetails(String questionId, String quizId, String questionContent, String correctAnswer, String ansA, String ansB, String ansC, String ansD) {
        this.questionId = questionId;
        this.quizId = quizId;
        this.questionContent = questionContent;
        this.correctAnswer = correctAnswer;
        this.ansA = ansA;
        this.ansB = ansB;
        this.ansC = ansC;
        this.ansD = ansD;
        listAns = new ArrayList<>();
        listAns.add(ansA);
        listAns.add(ansB);
        listAns.add(ansC);
        listAns.add(ansD);
    }

    
    
    public String getAnsD() {
        return ansD;
    }

    public void setAnsD(String ansD) {
        this.ansD = ansD;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public String getQuizId() {
        return quizId;
    }

    public void setQuizId(String quizId) {
        this.quizId = quizId;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
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

    public ArrayList<String> getListAns() {
        Collections.shuffle(listAns);
        return listAns;
    }

}
