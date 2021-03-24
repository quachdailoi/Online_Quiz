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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.Filter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import loiqd.answer.AnswerDAO;
import loiqd.answer.AnswerDTO;
import loiqd.file.FilterSupport;
import loiqd.question.QuestionDAO;
import loiqd.question.QuestionDTO;
import loiqd.quiz.QuizDetails;
import loiqd.quizdetails.QuizDetailsDAO;
import loiqd.subjectdb.SubjectDBDAO;
import loiqd.subjectdb.SubjectDBDTO;

/**
 *
 * @author GF65
 */
public class PrepareForQuiz extends HttpServlet {

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
        
        String subjectId = request.getParameter("p_subject_id");
        String quizId = (String) request.getAttribute("QUIZ_ID");
        
        QuestionDAO questionDao = new QuestionDAO();
        SubjectDBDAO subjectDao = new SubjectDBDAO();
       
        ArrayList<SubjectDBDTO> listQuestionForQuiz = new ArrayList<>();
        ArrayList<QuizDetails> listQuestionShow = new ArrayList<>();
        
        String subjectName = null;
        try {
            subjectName = subjectDao.getSubjectNameById(subjectId);
            listQuestionForQuiz = questionDao.getQuestionsForQuiz(subjectId);
            System.out.println("listQ size: " + listQuestionForQuiz.get(0).getListQuestion().size());
            
            QuizDetailsDAO quizDetailsDao = new QuizDetailsDAO();
            AnswerDAO ansDao = new AnswerDAO();
            
            for (SubjectDBDTO subject : listQuestionForQuiz) {
                for (QuestionDTO question : subject.getListQuestion()) {
                    String questionId = question.getId();
                    String content = question.getContent();
                    String correctAns = null;
                    ArrayList<AnswerDTO> listAns = ansDao.getAnswersOfQuestion(questionId);
                    String ansA = listAns.get(0).getContent();
                    String ansB = listAns.get(1).getContent();
                    String ansC = listAns.get(2).getContent();
                    String ansD = listAns.get(3).getContent();
                    
                    for (AnswerDTO ans : listAns) {
                        if(ans.isIsCorrect()) {
                            correctAns = ans.getContent();
                        }
                    }
                    QuizDetails questionShow = new QuizDetails(questionId, quizId, content, correctAns, ansA, ansB, ansC, ansD);
                    listQuestionShow.add(questionShow);
                    
                    quizDetailsDao.createDetails(questionId, content, correctAns, quizId, ansA, ansB, ansC, ansD);
                }
            }
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        }
        
        
        request.setAttribute("LIST_QUESTION", listQuestionShow);
        request.setAttribute("SUBJECT_NAME", subjectName);
        
        System.out.println("-prepare--> " + listQuestionShow.size());
        for (QuizDetails questionQuiz : listQuestionShow) {
            System.out.println("quesID " + questionQuiz.getQuestionId());
        }
        
        String url = FilterSupport.getUrl(request, "quiz_page");
        request.setAttribute("QUIZ_ID", quizId);
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
