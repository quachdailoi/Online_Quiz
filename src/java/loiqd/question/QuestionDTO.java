/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.question;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Objects;
import loiqd.answer.AnswerDTO;
import loiqd.subjectdb.SubjectDBDTO;

/**
 *
 * @author GF65
 */
public class QuestionDTO implements Serializable {

    private String id;
    private String content;
    private ArrayList<AnswerDTO> listAnswer;
    private Date createDate;
    private boolean status;
    private String subjectId;

    public QuestionDTO(String id, String content, Date createDate, boolean status, String subjectId) {
        this.id = id;
        this.content = content;
        this.createDate = createDate;
        this.status = status;
        this.subjectId = subjectId;
    }

    public AnswerDTO getCorrectAnswer() {
        for (AnswerDTO answer : listAnswer) {
            if (answer.isIsCorrect()) {
                return answer;
            }
        }
        return null;
    }

    public QuestionDTO() {
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

    public ArrayList<AnswerDTO> getListAnswer() {
        Collections.shuffle(listAnswer);
        return listAnswer;
    }

    public void setListAnswer(ArrayList<AnswerDTO> listAnswer) {
        this.listAnswer = listAnswer;
    }

    public void addAnswer(AnswerDTO answer) {
        if (listAnswer == null) {
            listAnswer = new ArrayList<>();
        }
        this.listAnswer.add(answer);
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final QuestionDTO other = (QuestionDTO) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

}
