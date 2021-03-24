/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import loiqd.file.FilterSupport;
import loiqd.question.QuestionDAO;
import loiqd.quiz.QuizDetails;
import loiqd.quizuser.QuizUserDAO;
import loiqd.subjectdb.SubjectDBDAO;
import loiqd.user.UserDTO;

/**
 *
 * @author GF65
 */
public class DoQuizServlet extends HttpServlet {

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

        String role = FilterSupport.getRole(request);
        String subjectId = request.getParameter("p_subject_id");
        SubjectDBDAO subjectDao = new SubjectDBDAO();
        QuizUserDAO quizUserDao = new QuizUserDAO();
        QuestionDAO questionDao = new QuestionDAO();
        String url = FilterSupport.getUrl(request, "prepare");
        String quizId = String.valueOf(new Date().getTime());
        String subjectName = "";
        String email = "";
        try {
            if (!role.equals("student") || subjectId == null || subjectDao.getSubjectNameById(subjectId) == null) {
                response.sendRedirect("home");
                return;
            }
            int totalOfQuestion = questionDao.getNumberQuestionOfQuiz(subjectId);
            HttpSession session = request.getSession();

            email = ((UserDTO) session.getAttribute("USER")).getEmail();

            Date finishTime = quizUserDao.getFinishTimeOfQuiz(email);
            System.out.println("->finish after now: " + finishTime.after(new Date()));
            if (finishTime != null && finishTime.after(new Date())) {
                ArrayList<QuizDetails> listQuestion = quizUserDao.retrieveQuiz(email);
                request.setAttribute("LIST_QUESTION", listQuestion);
                url = FilterSupport.getUrl(request, "quiz_page");
                System.out.println("go straight!");
                System.out.println("->" + listQuestion.size());
            } else {
                System.out.println("--> prepare");
                quizUserDao.makeQuiz(email, subjectId, quizId, totalOfQuestion);

            }
            subjectName = subjectDao.getSubjectNameById(subjectId);
            request.setAttribute("SUBJECT_NAME", subjectName);
            System.out.println("subjName: " + subjectName);

        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        }

        request.setAttribute("QUIZ_ID", quizId);
        request.setAttribute("EMAIL", email);
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
