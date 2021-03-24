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
import loiqd.file.FilterSupport;
import loiqd.question.QuestionDAO;
import loiqd.subjectdb.SubjectDBDTO;

/**
 *
 * @author GF65
 */
public class SearchServlet extends HttpServlet {

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

        String goTo = request.getParameter("goto");
        
        String curPageStr = request.getParameter("p_cur_page");

        int curPage = 1;
        if (curPageStr != null) {
            try {
                curPage = Integer.parseInt(curPageStr);
            } catch (NumberFormatException ex) {
                curPage = 1;
            }
            if (curPage < 1) {
                curPage = 1;
            }
        }

        String searchContent = request.getParameter("p_search_content");

        String searchSubject = request.getParameter("p_search_subject");

        String searchStatus = request.getParameter("p_search_status");
               
        try {

            QuestionDAO questionDao = new QuestionDAO();
            
            //get all or paging
            int rowsInAPage = 1;
            if(goTo != null) { //get all rows
                rowsInAPage = 0;
            }

            ArrayList<SubjectDBDTO> listSubQuestion = questionDao.searchQuestions(rowsInAPage, curPage, searchContent, searchSubject, searchStatus);
            

            int maxPage = questionDao.getPaging();
            if (curPage > maxPage) {
                curPage = maxPage;
            }

            request.setAttribute("LIST_QUESTION", listSubQuestion);
            request.setAttribute("CUR_PAGE", curPage);
            request.setAttribute("MAX_PAGE", maxPage);

        } catch (NamingException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error at " + this.getServletName() + ": " + ex.getMessage());
        }

        String url = FilterSupport.getUrl(request, "home");
        if(goTo != null && !goTo.isEmpty()) {
            if(goTo.equals("details")) {
                url = FilterSupport.getUrl(request, "subject_details");
            } else if(goTo.equals("do_quiz")) {
                url = FilterSupport.getUrl(request, "quiz_page");
            }
        }

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
