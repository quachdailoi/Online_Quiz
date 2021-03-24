/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import loiqd.utils.DBHelper;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author GF65
 */
public class UserDAO {

    private String name;
    private boolean role;
    private boolean status;

    public boolean checkLogin(String email, String password) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT NAME, ROLE, STATUS "
                        + "FROM USERDB "
                        + "WHERE EMAIL = ? AND PASSWORD = ?";

                pre = con.prepareStatement(sql);

                pre.setString(1, email);
                pre.setString(2, DigestUtils.sha256Hex(password));

                rs = pre.executeQuery();

                if (rs.next()) {
                    name = rs.getString("NAME");
                    role = rs.getBoolean("ROLE");
                    status = rs.getBoolean("STATUS");
                    return true;
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
        return false;
    }

    public String getName() {
        return name;
    }

    public boolean isRole() {
        return role;
    }

    public boolean isStatus() {
        return status;
    }

    public boolean createAccount(UserDTO user) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO USERDB(EMAIL, NAME, PASSWORD, ROLE, STATUS) "
                        + "VALUES(?, ?, ?, ?, ?)";

                pre = con.prepareStatement(sql);

                pre.setString(1, user.getEmail());
                pre.setString(2, user.getName());
                pre.setString(3, user.getPassword());
                pre.setBoolean(4, false);
                pre.setBoolean(5, true);

                int rs = pre.executeUpdate();

                if (rs != 0) {
                    return true;
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
        return false;
    }

    public UserDTO getUserByEmail(String email) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT NAME, PASSWORD, ROLE, STATUS "
                        + "FROM USERDB "
                        + "WHERE EMAIL = ?";

                pre = con.prepareStatement(sql);

                pre.setString(1, email);

                rs = pre.executeQuery();

                if (rs.next()) {
                    String password = rs.getString("PASSWORD");
                    String name = rs.getString("NAME");
                    Boolean role = rs.getBoolean("ROLE");
                    Boolean status = rs.getBoolean("STATUS");
                    return new UserDTO(email, name, password, role, status);
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
