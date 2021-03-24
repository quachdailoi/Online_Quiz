/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import loiqd.user.UserDAO;
import loiqd.user.UserDTO;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author GF65
 */
public class RegisterServlet extends HttpServlet {
    final String INDEX = "index.jsp";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("p_email");
        String name = request.getParameter("p_name");
        String password = request.getParameter("p_password");
        String re_password = request.getParameter("p_re_password");

        UserDAO dao = new UserDAO();

        try {
            boolean flag = false;
            if (!email.matches("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$")) {
                request.setAttribute("INVALID_EMAIL", "Invalid Email! Format (numbers or chars)@(numbers or chars).(numbers or chars)");
                flag = true;
            } else if (dao.getUserByEmail(email) != null) {
                request.setAttribute("INVALID_EMAIL", "This email have been used in the past to register!");
                flag = true;
            }
            if (name.isEmpty() || name.length() > 30) {
                request.setAttribute("INVALID_NAME", "Invalid name! Name has max length: 30chars and not empty!");
                flag = true;
            }
            if (password.isEmpty() || password.length() > 30) {
                request.setAttribute("INVALID_PASSWORD", "Invalid password! Password has max length: 30chars and not empty!");
                flag = true;
            } else if (!re_password.equals(password)) {
                request.setAttribute("INVALID_RE_PASSWORD", "Re-password does not match with Password!");
                flag = true;
            }

            if (flag) {
                request.setAttribute("EMAIL", email);
                request.setAttribute("NAME", name);
                request.setAttribute("PASSWORD", password);
                request.setAttribute("NOTIFY", "Invalid information for registering! Hover on field to see more!");
                request.setAttribute("ACTION", "register");
                request.getRequestDispatcher(INDEX).forward(request, response);
            } else {
                password = DigestUtils.sha256Hex(password);
                UserDTO user = new UserDTO(email, name, password);
                if(dao.createAccount(user)) {
                    request.setAttribute("NOTIFY", "Register Successfully! Now you can login!");
                    request.getRequestDispatcher(INDEX).forward(request, response);
                } else {
                    request.setAttribute("NOTIFY", "Register Failed! Have a problem in our system! Sorry about that!");
                    request.setAttribute("ACTION", "register");
                    request.getRequestDispatcher(INDEX).forward(request, response); 
                }
            }
        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
