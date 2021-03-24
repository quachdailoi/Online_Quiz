/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.quiz;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import loiqd.utils.DBHelper;

/**
 *
 * @author GF65
 */
public class QuizDAO {
    
    public void createQuiz(String quizId, String subjectId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                
                String sql = "INSERT INTO QUIZ "
                        + "VALUES(?, ?)";

                pre = con.prepareStatement(sql);
                pre.setString(1, quizId);
                pre.setString(2, subjectId);

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
