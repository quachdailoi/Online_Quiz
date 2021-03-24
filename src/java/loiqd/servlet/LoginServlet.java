/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.servlet;

import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import loiqd.file.FilterSupport;
import loiqd.user.UserDAO;
import loiqd.user.UserDTO;

/**
 *
 * @author GF65
 */
public class LoginServlet extends HttpServlet {

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
        String password = request.getParameter("p_password");
        String last_resource = request.getParameter("p_last_resource");

        System.out.println("p_email: " + email);
        System.out.println("p_password: " + password);

        HttpSession session = request.getSession();

        String resource = "index";
        UserDAO dao = new UserDAO();
        try {
            UserDTO user = (UserDTO) session.getAttribute("USER");
            if (user != null) { // is loged in -> goto home
                response.sendRedirect("home");
                return;
            } else if (dao.checkLogin(email, password)) { // is right account
                user = new UserDTO(email, dao.getName(), password, dao.isRole(), dao.isStatus());
                session.setAttribute("USER", user);
                resource = "home";
            } else { // wrong account -> goto index
                request.setAttribute("NOTIFY", "Wrong email or password!");
            }
        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        }

        if (last_resource != null) {
            resource = last_resource;
        }

        String url = FilterSupport.getUrl(request, resource);
        
        if(email == null || password == null) {
            response.sendRedirect("index.jsp");
        } else {
            request.getRequestDispatcher(url).forward(request, response);
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
