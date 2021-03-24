/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import javax.naming.NamingException;
import loiqd.answer.AnswerDAO;
import loiqd.answer.AnswerDTO;
import loiqd.subjectdb.SubjectDBDAO;
import loiqd.subjectdb.SubjectDBDTO;
import loiqd.utils.DBHelper;

/**
 *
 * @author GF65
 */
public class QuestionDAO {

    private int paging;
    private int maxQuestionFound;
    
    public ArrayList<SubjectDBDTO> searchQuestions(int rowsInAPage, int page, String searchContent, String subjectId, String status) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;

        ArrayList<SubjectDBDTO> listSubjects = new ArrayList<>();

        if (subjectId == null || subjectId.equals("none")) {
            subjectId = "";
        }

        String statusSQL = "AND STATUS = ";

        if (status == null || status.equals("none")) {
            statusSQL = "";
        } else if (status.equals("active")) {
            statusSQL += "1 ";
        } else {
            statusSQL += "0 ";
        }

        if (searchContent == null || searchContent.isEmpty()) {
            searchContent = "";
        }

        int row = 0;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                //get max question search
                String sqlTolal = "SELECT COUNT(QUESTION_ID) as ROWS "
                        + "FROM QUESTION "
                        + "WHERE QUESTION_CONTENT LIKE ? AND SUBJECT_ID LIKE ? " + statusSQL;

                pre = con.prepareStatement(sqlTolal);
                pre.setNString(1, "%" + searchContent + "%");
                pre.setString(2, "%" + subjectId + "%");

                rs = pre.executeQuery();

                if (rs.next()) {
                    row = rs.getInt("ROWS");
                    maxQuestionFound = row;
                }
                /// get all or paging
                String sqlFetch = "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                if (rowsInAPage == 0) {
                    sqlFetch = "";
                }

                String sql = "SELECT QUESTION_ID, QUESTION_CONTENT, CREATE_DATE, SUBJECT_ID, STATUS "
                        + "FROM QUESTION "
                        + "WHERE QUESTION_CONTENT LIKE ? AND SUBJECT_ID LIKE ? " + statusSQL
                        + "ORDER BY STATUS DESC, SUBJECT_ID DESC, QUESTION_CONTENT DESC "
                        + sqlFetch;
                int offset = rowsInAPage * (page - 1);
                int next = rowsInAPage;

                pre = con.prepareStatement(sql);
                pre.setNString(1, "%" + searchContent + "%");
                pre.setString(2, "%" + subjectId + "%");
                if (rowsInAPage != 0) {
                    pre.setInt(3, offset);
                    pre.setInt(4, next);
                }

                rs = pre.executeQuery();

                while (rs.next()) {
                    String id = rs.getString("QUESTION_ID");
                    String content = rs.getNString("QUESTION_CONTENT");
                    Date createDate = rs.getTimestamp("CREATE_DATE");
                    String subjectID = rs.getString("SUBJECT_ID");
                    boolean isActive = rs.getBoolean("STATUS");

                    SubjectDBDTO subject = new SubjectDBDTO(subjectID);
                    QuestionDTO question = new QuestionDTO(id, content, createDate, isActive, subjectID);

                    if (!listSubjects.contains(subject)) {
                        subject.addQuestion(question);
                        listSubjects.add(subject);
                    } else {
                        int index = listSubjects.indexOf(subject);
                        listSubjects.get(index).addQuestion(question);
                    }

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pre != null) {
                pre.close();
            }
            if (con != null) {
                con.close();
            }
        }
        if (rowsInAPage != 0) {
            paging = row % rowsInAPage == 0 ? row / rowsInAPage : row / rowsInAPage + 1;
        }

        //add name and list answers of questions for subjects
        SubjectDBDAO subjectDao = new SubjectDBDAO();
        AnswerDAO answerDao = new AnswerDAO();

        for (SubjectDBDTO subject : listSubjects) {
            subject.setSubjectName(subjectDao.getSubjectNameById(subject.getSubjectID()));
            for (QuestionDTO question : subject.getListQuestion()) {
                question.setListAnswer(answerDao.getAnswersOfQuestion(question.getId()));
                for (AnswerDTO answer : answerDao.getAnswersOfQuestion(question.getId())) {
                    System.out.println(": " + answer.isIsCorrect());
                }
            }
        }
        
        if(listSubjects.isEmpty() && !subjectId.isEmpty()) {
            String subjectName = subjectDao.getSubjectNameById(subjectId);
            SubjectDBDTO emptySubject = new SubjectDBDTO(subjectId, subjectName);
            listSubjects.add(emptySubject);
        }

        return listSubjects;
    }
    
    public ArrayList<SubjectDBDTO> getQuestionsForQuiz(String subjectId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;

        ArrayList<SubjectDBDTO> listSubjects = new ArrayList<>();

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                
                String sql = "SELECT QUESTION_ID, QUESTION_CONTENT, CREATE_DATE, SUBJECT_ID, STATUS "
                        + "FROM QUESTION "
                        + "WHERE SUBJECT_ID = ? AND STATUS = ? ";

                pre = con.prepareStatement(sql);
                pre.setString(1, subjectId);
                pre.setBoolean(2, true);

                rs = pre.executeQuery();

                while (rs.next()) {
                    String id = rs.getString("QUESTION_ID");
                    String content = rs.getNString("QUESTION_CONTENT");
                    Date createDate = rs.getTimestamp("CREATE_DATE");
                    String subjectID = rs.getString("SUBJECT_ID");
                    boolean isActive = rs.getBoolean("STATUS");

                    SubjectDBDTO subject = new SubjectDBDTO(subjectID);
                    QuestionDTO question = new QuestionDTO(id, content, createDate, isActive, subjectID);

                    if (!listSubjects.contains(subject)) {
                        subject.addQuestion(question);
                        listSubjects.add(subject);
                    } else {
                        int index = listSubjects.indexOf(subject);
                        listSubjects.get(index).addQuestion(question);
                    }
                    
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pre != null) {
                pre.close();
            }
            if (con != null) {
                con.close();
            }
        }

        //add name and list answers of questions for subjects
        SubjectDBDAO subjectDao = new SubjectDBDAO();
        AnswerDAO answerDao = new AnswerDAO();

        for (SubjectDBDTO subject : listSubjects) {
            subject.setSubjectName(subjectDao.getSubjectNameById(subject.getSubjectID()));
            for (QuestionDTO question : subject.getListQuestion()) {
                question.setListAnswer(answerDao.getAnswersOfQuestionForQuiz(question.getId()));
            }
        }
        
        if(listSubjects.isEmpty() && !subjectId.isEmpty()) {
            String subjectName = subjectDao.getSubjectNameById(subjectId);
            SubjectDBDTO emptySubject = new SubjectDBDTO(subjectId, subjectName);
            listSubjects.add(emptySubject);
        }

        return listSubjects;
    }
    
    public int getNumberQuestionOfQuiz(String subjectId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;


        int numOfQuestion = 0;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                
                String sql = "SELECT QUESTION_ID "
                        + "FROM QUESTION "
                        + "WHERE SUBJECT_ID = ? AND STATUS = ? ";

                pre = con.prepareStatement(sql);
                pre.setString(1, subjectId);
                pre.setBoolean(2, true);

                rs = pre.executeQuery();

                while (rs.next()) {
                   numOfQuestion++;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pre != null) {
                pre.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return numOfQuestion;
    }

    public int getPaging() {
        return paging;
    }

    public int getMaxQuestionFound() {
        return maxQuestionFound;
    }

    public void setMaxQuestionFound(int maxQuestionFound) {
        this.maxQuestionFound = maxQuestionFound;
    }

    
    public ArrayList<SubjectDBDTO> getAllQuestionOfSubject(String subjectID) throws SQLException, NamingException {
        return searchQuestions(0, 1, null, subjectID, null);
    }
    
    public void updateQuestion(String questionId, QuestionDTO newQuestion) throws SQLException, NamingException {
        System.out.println("question_id: " + questionId);
        Connection con = null;
        PreparedStatement pre = null;
        int rs = 0;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "UPDATE QUESTION "
                        + "SET QUESTION_CONTENT = ?, STATUS = ? "
                        + "WHERE QUESTION_ID = ?";
                pre = con.prepareStatement(sql);

                pre.setNString(1, newQuestion.getContent());
                pre.setBoolean(2, newQuestion.isStatus());
                pre.setString(3, newQuestion.getId());
                
                rs = pre.executeUpdate();
                if(rs != 0) {
                    return;
                }
            }
        } finally {
            
            if (pre != null) {
                pre.close();
            }
            if (con != null) {
                con.close();
            }
        }
        addNewQuestion(questionId, newQuestion);
    }
    
    public void deleteQuestion(ArrayList<String> notDeleteList) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sqlGetAllId = "SELECT QUESTION_ID "
                        + "FROM QUESTION";
                String sqlDelete = "UPDATE QUESTION "
                        + "SET STATUS = ? "
                        + "WHERE QUESTION_ID = ?";
                
                pre = con.prepareStatement(sqlGetAllId);
                
                rs = pre.executeQuery();
                
                while(rs.next()) {
                    String qId = rs.getString("QUESTION_ID");
                    if(!notDeleteList.contains(qId)) {
                        pre = con.prepareStatement(sqlDelete);
                        pre.setBoolean(1, false);
                        pre.setString(2, qId);
                        
                        pre.executeUpdate();
                    }
                }
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if (pre != null) {
                pre.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public void addNewQuestion(String questionId, QuestionDTO newQuestion) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "INSERT INTO QUESTION "
                        + "VALUES(?, ?, GETDATE(), ?, ?)";
                pre = con.prepareStatement(sql);

                pre.setString(1, questionId);
                pre.setNString(2, newQuestion.getContent());
                pre.setString(3, newQuestion.getSubjectId());
                pre.setBoolean(4, true);
                
                pre.executeUpdate();
                
            }
        } finally {
            if (pre != null) {
                pre.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
