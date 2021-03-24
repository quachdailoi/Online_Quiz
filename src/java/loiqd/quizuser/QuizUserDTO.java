/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quizuser;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import loiqd.quizdetails.QuizDetailsDTO;
import loiqd.subjectdb.SubjectDBDAO;

/**
 *
 * @author GF65
 */
public class QuizUserDTO {
    private String subjectID;
    private String subjectName;
    private Date createDate;
    private String quizId;
    private int mark;
    private int total;
    private ArrayList<QuizDetailsDTO> listDetails;

    public QuizUserDTO(String quizId, String subjectID, Date createDate, int mark, int total) throws NamingException, SQLException {
        this.quizId = quizId;
        this.subjectID = subjectID;
        this.createDate = createDate;
        this.mark = mark;
        this.total = total;
        
        SubjectDBDAO dao = new SubjectDBDAO();
        this.subjectName = dao.getSubjectNameById(subjectID);
    }
    
    public QuizUserDTO() {
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getQuizId() {
        return quizId;
    }

    public void setQuizId(String quizId) {
        this.quizId = quizId;
    }

    public ArrayList<QuizDetailsDTO> getListDetails() {
        return listDetails;
    }

    public void setListDetails(ArrayList<QuizDetailsDTO> listDetails) {
        this.listDetails = listDetails;
    }
    
}
