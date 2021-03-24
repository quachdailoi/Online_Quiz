/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import loiqd.answer.AnswerDAO;
import loiqd.answer.AnswerDTO;
import loiqd.question.QuestionDAO;
import loiqd.question.QuestionDTO;

/**
 *
 * @author GF65
 */
public class UpdateServlet extends HttpServlet {

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

        String subjectID = request.getParameter("p_subject_id");

        QuestionDAO questionDao = new QuestionDAO();
        AnswerDAO answerDao = new AnswerDAO();

        //support delete question
        ArrayList<String> listUpdateQuestion = new ArrayList<>();

        try {
            String[] questionIds = request.getParameterValues("p_question_id");
            if (questionIds != null) {
                for (String questionId : questionIds) {
                    String questionStatus = request.getParameter("p_question_status_" + questionId);
                    boolean qStatusBool = questionStatus != null;
                    String questionContent = request.getParameter("p_question_content_" + questionId);
                    String questionKey = request.getParameter("p_answer_correct_" + questionId);
                    String[] answerIds = request.getParameterValues("p_answer_id_" + questionId);
                    QuestionDTO uQuestion = new QuestionDTO(questionId, questionContent, null, qStatusBool, subjectID);

                    questionDao.updateQuestion(questionId, uQuestion);
                    
                    if (answerIds != null) {
                        for (String answerId : answerIds) {
                            boolean isCorrect = questionKey.equals(answerId);
                            String ansContent = request.getParameter("p_answer_content_" + answerId);
                            AnswerDTO uAns = new AnswerDTO(answerId, ansContent, isCorrect, questionId);                       
                            
                            answerDao.updateAnswer(answerId, uAns);
                        }
                        listUpdateQuestion.add(uQuestion.getId());
                        questionDao.updateQuestion(questionId, uQuestion);
                    }
                }

                questionDao.deleteQuestion(listUpdateQuestion);
            }
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());  
        }

        request.getRequestDispatcher("search").forward(request, response);
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
