/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.answer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import loiqd.utils.DBHelper;

/**
 *
 * @author GF65
 */
public class AnswerDAO {
    public ArrayList<AnswerDTO> getAnswersOfQuestion(String questionId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
        try{
            con = DBHelper.makeConnection();
            
            if(con != null) {
                String sql = "SELECT ANSWER_ID, ANSWER_CONTENT, IS_CORRECT "
                        + "FROM ANSWER "
                        + "WHERE QUESTION_ID = ?";
                pre = con.prepareStatement(sql);
                
                pre.setString(1, questionId);
                
                rs = pre.executeQuery();
                
                while(rs.next()) {
                    String id = rs.getString("ANSWER_ID");
                    String content = rs.getNString("ANSWER_CONTENT");
                    boolean isCorrect = rs.getBoolean("IS_CORRECT");
                    
                    AnswerDTO answer = new AnswerDTO(id, content, isCorrect, questionId);
                    listAnswer.add(answer);
                }
                
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if(pre != null) {
                pre.close();
            }
            if(con != null) {
                con.close();
            }
        }
        return listAnswer;
    }
    
    public ArrayList<AnswerDTO> getAnswersOfQuestionForQuiz(String questionId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        ArrayList<AnswerDTO> listAnswer = new ArrayList<>();
        try{
            con = DBHelper.makeConnection();
            
            if(con != null) {
                String sql = "SELECT ANSWER_ID, ANSWER_CONTENT "
                        + "FROM ANSWER "
                        + "WHERE QUESTION_ID = ?";
                pre = con.prepareStatement(sql);
                
                pre.setString(1, questionId);
                
                rs = pre.executeQuery();
                
                while(rs.next()) {
                    String id = rs.getString("ANSWER_ID");
                    String content = rs.getNString("ANSWER_CONTENT");
                    
                    AnswerDTO answer = new AnswerDTO(id, content, questionId);
                    listAnswer.add(answer);
                }
                
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if(pre != null) {
                pre.close();
            }
            if(con != null) {
                con.close();
            }
        }
        return listAnswer;
    }
    
    public void updateAnswer(String answerId, AnswerDTO newAnswer) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        int rs = 0;
        try{
            con = DBHelper.makeConnection();
            
            if(con != null) {
                String sql = "UPDATE ANSWER "
                        + "SET ANSWER_CONTENT = ?, IS_CORRECT = ? "
                        + "WHERE ANSWER_ID = ?";
                pre = con.prepareStatement(sql);
                
                pre.setString(1, newAnswer.getContent());
                pre.setBoolean(2, newAnswer.isIsCorrect());
                pre.setString(3, newAnswer.getId());
                
                rs = pre.executeUpdate();
                
                if(rs != 0) {
                    return;
                }
            }
        } finally {
            if(pre != null) {
                pre.close();
            }
            if(con != null) {
                con.close();
            }
        }
        addAnswer(answerId, newAnswer);
    }
    
    public void addAnswer(String answerId, AnswerDTO newAnswer) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        try{
            con = DBHelper.makeConnection();
            
            if(con != null) {
                String sql = "INSERT INTO ANSWER "
                        + "VALUES(?, ?, ?, ?)";
                
                pre = con.prepareStatement(sql);
                
                pre.setString(1, newAnswer.getId());
                pre.setString(2, newAnswer.getContent());
                pre.setBoolean(3, newAnswer.isIsCorrect());
                pre.setString(4, newAnswer.getQuestionId());
                
                pre.executeUpdate();
            }
        } finally {
            if(pre != null) {
                pre.close();
            }
            if(con != null) {
                con.close();
            }
        }
    }
    
    public String getCorrectAnswersOfQuestion(String questionId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        
        String correctAns = null;
        
        try{
            con = DBHelper.makeConnection();
            
            if(con != null) {
                String sql = "SELECT ANSWER_CONTENT "
                        + "FROM ANSWER "
                        + "WHERE QUESTION_ID = ? AND IS_CORRECT = ?";
                pre = con.prepareStatement(sql);
                
                pre.setString(1, questionId);
                pre.setBoolean(2, true);
                
                rs = pre.executeQuery();
                
                if(rs.next()) {
                    correctAns = rs.getNString("ANSWER_CONTENT");
                }
                
            }
        } finally {
            if(rs != null) {
                rs.close();
            }
            if(pre != null) {
                pre.close();
            }
            if(con != null) {
                con.close();
            }
        }
        return correctAns;
    }
}
