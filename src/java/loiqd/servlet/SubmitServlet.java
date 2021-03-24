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
import loiqd.file.FilterSupport;
import loiqd.quizdetails.QuizDetailsDAO;
import loiqd.quizuser.QuizUserDAO;

/**
 *
 * @author GF65
 */
public class SubmitServlet extends HttpServlet {

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

        String quizId = request.getParameter("p_quiz_id");
        String email = request.getParameter("p_email");
        String[] questionIds = request.getParameterValues("p_question_id");
        int mark = 0;
        try {
            QuizDetailsDAO quizDetailsDao = new QuizDetailsDAO();
            QuizUserDAO quizUserDao = new QuizUserDAO();
            for (String questionId : questionIds) {
                String choosedAns = request.getParameter("p_answer_choose_" + questionId);
                if (choosedAns != null && quizDetailsDao.checkAnswer(quizId, questionId, choosedAns)) {
                    mark++;
                }
            }
            System.out.println("mark: " + mark);
            quizUserDao.updateMark(email, quizId, mark);
        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        }
        request.setAttribute("NOTIFY", "Submit quiz successfully! Contact with your instructor for result!");
        String url = FilterSupport.getUrl(request, "home");
        request.getRequestDispatcher(url).forward(request, response);
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
