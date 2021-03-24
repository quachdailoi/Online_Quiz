/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quizuser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.naming.NamingException;
import loiqd.question.QuestionDAO;
import loiqd.quiz.QuizDAO;
import loiqd.quiz.QuizDetails;
import loiqd.quizdetails.QuizDetailsDAO;
import loiqd.quizdetails.QuizDetailsDTO;
import loiqd.utils.DBHelper;

/**
 *
 * @author GF65
 */
public class QuizUserDAO {

    public void makeQuiz(String email, String subjectId, String quizId, int totalQ) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;

        QuestionDAO questionDao = new QuestionDAO();
        int numOfQuestion = questionDao.getNumberQuestionOfQuiz(subjectId);
        System.out.println("numQuestion: " + numOfQuestion);

        try {
            
            //create quiz
            QuizDAO quizDao = new QuizDAO();
            quizDao.createQuiz(quizId, subjectId);
            
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "INSERT INTO QUIZUSER "
                        + "VALUES(?, ?, ?, ?, 0, ?, 0, ?)";
                pre = con.prepareStatement(sql);

                pre.setString(1, email);
                pre.setString(2, quizId);
                Date curTime = new Date();
                pre.setTimestamp(3, new Timestamp(curTime.getTime()));
                Calendar c = Calendar.getInstance();
                c.setTime(curTime);

                c.add(Calendar.MINUTE, numOfQuestion);

                pre.setTimestamp(4, new Timestamp(c.getTime().getTime()));
                pre.setString(5, subjectId);
                pre.setInt(6, totalQ);
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

    public ArrayList<QuizDetails> retrieveQuiz(String email) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;

        ArrayList<QuizDetails> listQuestion = new ArrayList<>();
        QuizDetailsDAO quizDetailsDao = new QuizDetailsDAO();
        String quizId = quizDetailsDao.getNearestQuizIdOfEmail(email);
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT QUESTION_ID, QUESTION_CONTENT, CORRECT_ANSWER, ANSA, ANSB, ANSC, ANSD "
                        + "FROM QUIZDETAILS "
                        + "WHERE QUIZ_ID = ?";
                pre = con.prepareStatement(sql);

                pre.setString(1, quizId);

                rs = pre.executeQuery();

                while (rs.next()) {
                    String questionId = rs.getString("QUESTION_ID");
                    String questionContent = rs.getNString("QUESTION_CONTENT");
                    String correctAnswer = rs.getNString("CORRECT_ANSWER");
                    String ansA = rs.getNString("ANSA");
                    String ansB = rs.getNString("ANSB");
                    String ansC = rs.getNString("ANSC");
                    String ansD = rs.getNString("ANSD");

                    QuizDetails question = new QuizDetails(questionId, quizId, questionContent, correctAnswer, ansA, ansB, ansC, ansD);
                    listQuestion.add(question);
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

        return listQuestion;
    }

    public boolean isSubmit(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        boolean isSubmit = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT TOP 1 ISSUBMIT "
                        + "FROM QUIZUSER "
                        + "WHERE EMAIL = ? "
                        + "ORDER BY CREATE_TIME DESC";
                pre = con.prepareStatement(sql);

                pre.setString(1, email);

                rs = pre.executeQuery();

                if (rs.next()) {
                    isSubmit = rs.getBoolean("ISSUBMIT");
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
        return isSubmit;
    }

    public Date getFinishTimeOfQuiz(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        Date date = new Date();
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT TOP 1 FINISH_TIME "
                        + "FROM QUIZUSER "
                        + "WHERE EMAIL = ? "
                        + "ORDER BY CREATE_TIME DESC";
                pre = con.prepareStatement(sql);

                pre.setString(1, email);

                rs = pre.executeQuery();

                if (rs.next()) {
                    date = rs.getTimestamp("FINISH_TIME");
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
        return date;
    }

    public boolean isValidQuiz(String email) throws SQLException, NamingException {
        Date finishTime = getFinishTimeOfQuiz(email);

        Date curTime = new Date();

        return curTime.before(finishTime);
    }

    public void updateMark(String email, String quizId, int mark) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "UPDATE QUIZUSER "
                        + "SET MARK = ?, ISSUBMIT = ? "
                        + "WHERE EMAIL = ? AND QUIZ_ID = ?";
                pre = con.prepareStatement(sql);

                pre.setInt(1, mark);
                pre.setBoolean(2, true);
                pre.setString(3, email);
                pre.setString(4, quizId);

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
    
    public ArrayList<QuizUserDTO> getHistory(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        ArrayList<QuizUserDTO> listHistory = new ArrayList<>();
        
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT SUBJECT_ID, CREATE_TIME, MARK, TOTAL "
                        + "FROM QUIZUSER "
                        + "WHERE EMAIL = ?";
                pre = con.prepareStatement(sql);

                pre.setString(1, email);

                
                rs = pre.executeQuery();
                while(rs.next()) {
                    String subjectId = rs.getString("SUBJECT_ID");
                    Date createTime = rs.getDate("CREATE_TIME");
                    int mark = rs.getInt("MARK");
                    int total = rs.getInt("TOTAL");
                    
                    listHistory.add(new QuizUserDTO(email, subjectId, createTime, mark, total));
                }
                
                QuizDetailsDAO dao = new QuizDetailsDAO();
                
                for (QuizUserDTO quizUserDTO : listHistory) {
                    String quizId = quizUserDTO.getQuizId();
                    
                    quizUserDTO.setListDetails(dao.getDetailsOfQuiz(quizId));
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
        return listHistory;
    }
}
