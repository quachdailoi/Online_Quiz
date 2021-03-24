/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.subjectdb;

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
public class SubjectDBDAO {

    public ArrayList<SubjectDBDTO> getSubjects() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        ArrayList<SubjectDBDTO> listSubject = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT SUBJECT_ID, SUBJECT_NAME, DESCRIPTION "
                        + "FROM SUBJECTDB";
                pre = con.prepareStatement(sql);

                rs = pre.executeQuery();

                while (rs.next()) {
                    String subjectID = rs.getString("SUBJECT_ID");
                    String subjectName = rs.getNString("SUBJECT_NAME");
                    String desc = rs.getNString("DESCRIPTION");

                    SubjectDBDTO subject = new SubjectDBDTO(subjectID, subjectName, desc);
                    listSubject.add(subject);
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
        System.out.println("sizee: " + listSubject.size());
        return listSubject;
    }

    public String getSubjectNameById(String id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "SELECT SUBJECT_NAME "
                        + "FROM SUBJECTDB "
                        + "WHERE SUBJECT_ID = ?";
                pre = con.prepareStatement(sql);

                pre.setString(1, id);

                rs = pre.executeQuery();

                if (rs.next()) {
                    String subjectName = rs.getNString("SUBJECT_NAME");
                    return subjectName;
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
        return null;
    }
    
    
}
