/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.subjectdb;

import java.util.ArrayList;
import java.util.Objects;
import loiqd.question.QuestionDTO;

/**
 *
 * @author GF65
 */
public class SubjectDBDTO {

    private String subjectID;
    private String subjectName;
    private ArrayList<QuestionDTO> listQuestion;
    private String desc;
    
    

    public SubjectDBDTO(String subjectID, String subjectName, String desc) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
        this.desc = desc;
    }
    public SubjectDBDTO(String subjectID, String subjectName) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
    }

    public SubjectDBDTO(String subjectID) {
        this.subjectID = subjectID;
    }

    public SubjectDBDTO() {
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public ArrayList<QuestionDTO> getListQuestion() {
        return listQuestion;
    }

    public void setListQuestion(ArrayList<QuestionDTO> listQuestion) {
        this.listQuestion = listQuestion;
    }

    public void addQuestion(QuestionDTO question) {
        if (listQuestion == null) {
            listQuestion = new ArrayList<>();
        }
        this.listQuestion.add(question);
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 67 * hash + Objects.hashCode(this.subjectID);
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
        final SubjectDBDTO other = (SubjectDBDTO) obj;
        if (!Objects.equals(this.subjectID, other.subjectID)) {
            return false;
        }
        return true;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

}
