/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quizdetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import loiqd.question.QuestionDTO;
import loiqd.utils.DBHelper;

/**
 *
 * @author GF65
 */
public class QuizDetailsDAO {
    
    public void createDetails(String questionId, String questionContent, String correctAns, String quizId, String ansA, String ansB, String ansC, String ansD) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "INSERT INTO QUIZDETAILS(QUESTION_ID, QUESTION_CONTENT, CORRECT_ANSWER, QUIZ_ID, ANSA, ANSB, ANSC, ANSD) "
                        + "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
                pre = con.prepareStatement(sql);

                pre.setString(1, questionId);
                pre.setString(2, questionContent);
                pre.setString(3, correctAns);
                pre.setString(4, quizId);
                pre.setString(5, ansA);
                pre.setString(6, ansB);
                pre.setString(7, ansC);
                pre.setString(8, ansD);
                
                System.out.println("-->there: " + pre.executeUpdate());
                
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
    
    public String getNearestQuizIdOfEmail(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String quizId = null;
        
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT TOP 1 QUIZ_ID "
                        + "FROM QUIZUSER "
                        + "WHERE EMAIL = ? "
                        + "ORDER BY CREATE_TIME DESC";
                pre = con.prepareStatement(sql);

                pre.setString(1, email);
                
                rs = pre.executeQuery();
                if(rs.next()) {
                    quizId = rs.getString("QUIZ_ID");
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
        return quizId;
    }
    
    public boolean checkAnswer(String quizId, String questionId, String ansChoosedContent) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        boolean check = false;
        System.out.println("quizId: " + quizId);
        System.out.println("ansChoosed: " + ansChoosedContent);
        System.out.println("quesId: " + questionId);
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                
                                
                String sqlGetCorrectAns = "SELECT CORRECT_ANSWER "
                        + "FROM QUIZDETAILS "
                        + "WHERE QUIZ_ID = ? AND QUESTION_ID = ?";
                pre = con.prepareStatement(sqlGetCorrectAns);

                pre.setString(1, quizId);
                pre.setString(2, questionId);
                
                rs = pre.executeQuery();
                System.out.println("f1");
                if(rs.next()) {
                    String correctAns = rs.getNString("CORRECT_ANSWER");
                    System.out.println("corrAns: " + correctAns);
                    check = correctAns.equals(ansChoosedContent);
                }
                System.out.println("f2");
                String sqlUpdateIsRight = "UPDATE QUIZDETAILS "
                        + "SET IS_RIGHT = ?, CHOOSED_ANSWER = ? "
                        + "WHERE QUIZ_ID = ? AND QUESTION_ID = ?";
                pre = con.prepareStatement(sqlUpdateIsRight);
                
                pre.setBoolean(1, check);
                pre.setString(2, ansChoosedContent);
                pre.setString(3, quizId);
                pre.setString(4, questionId);
                
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
        return check;
    }
    
    public ArrayList<QuizDetailsDTO> getDetailsOfQuiz(String quizId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        ArrayList<QuizDetailsDTO> listDetails = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                
                                
                String sqlGetCorrectAns = "SELECT QUESTION_ID, QUESTION_CONTENT, IS_RIGHT, CHOOSED_ANSWER, CORRECT_ANSWER, ANSA, ANSB, ANSC, ANSD "
                        + "FROM QUIZDETAILS "
                        + "WHERE QUIZ_ID = ?";
                pre = con.prepareStatement(sqlGetCorrectAns);

                pre.setString(1, quizId);
                
                rs = pre.executeQuery();
                while(rs.next()) {
                    String questionId = rs.getString("QUESTION_ID");
                    String questionContent = rs.getString("QUESTION_CONTENT");
                    boolean isRight = rs.getBoolean("IS_RIGHT");
                    String choosedAnswer = rs.getString("CHOOSED_ANSWER");
                    String correctAns = rs.getNString("CORRECT_ANSWER");
                    String ansA = rs.getNString("ANSA");
                    String ansB = rs.getNString("ANSB");
                    String ansC = rs.getNString("ANSC");
                    String ansD = rs.getNString("ANSD");
                    
                    listDetails.add(new QuizDetailsDTO(questionId, questionContent, isRight, choosedAnswer, correctAns, quizId, ansA, ansB, ansC, ansD));
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
        return listDetails;
    }
}
