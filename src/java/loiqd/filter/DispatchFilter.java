/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.naming.NamingException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import loiqd.file.AdminRoleDAO;
import loiqd.file.FilterSupport;
import loiqd.file.StudentRoleDAO;
import loiqd.subjectdb.SubjectDBDAO;
import loiqd.subjectdb.SubjectDBDTO;

/**
 *
 * @author GF65
 */
public class DispatchFilter implements Filter {

    private static final boolean debug = true;
    final String SIGN_PAGE = "index.jsp";

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public DispatchFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("DispatchFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("DispatchFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        SubjectDBDAO subjectDao = new SubjectDBDAO();

        String resource = FilterSupport.getResource(request);

        if (resource.contains(".css") || resource.contains(".png") || resource.contains(".js") || resource.contains(".jpg") || resource.contains(".woff") || resource.contains(".tff") || resource.contains(".ico") || resource.contains(".svg")) {
            chain.doFilter(request, response);
            return;
        }

        String url = null;

        if (resource.equals("login") || resource.equals("logout")) {
            url = resource;
        } else if (resource.equals("register")) {
            url = "register";
        } else {
            try {
                ArrayList<SubjectDBDTO> listSubject = subjectDao.getSubjects();
                req.getServletContext().setAttribute("LIST_SUBJECT", listSubject);
            } catch (NamingException ex) {
                log("Error at " + this.getFilterConfig().getFilterName() + ": " + ex.getMessage());
            } catch (SQLException ex) {
                log("Error at " + this.getFilterConfig().getFilterName() + ": " + ex.getMessage());
            }

            url = FilterSupport.getUrl(req, resource);
        }

        
        req.getRequestDispatcher(url).forward(request, response);
        
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        HashMap<String, String> studentUrls = null;
        StudentRoleDAO studentDao = new StudentRoleDAO();
        SubjectDBDAO subjectDao = new SubjectDBDAO();

        try {
            ArrayList<SubjectDBDTO> listSubject = subjectDao.getSubjects();
            filterConfig.getServletContext().setAttribute("LIST_SUBJECT", listSubject);
            studentUrls = studentDao.loadStudentURLs();
        } catch (IOException ex) {
            log("Error at FilterDispatcher(init): " + ex.getMessage());
        } catch (NamingException ex) {
            log("Error at FilterDispatcher(init): " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error at FilterDispatcher(init): " + ex.getMessage());
        }

        this.filterConfig.getServletContext().setAttribute("STUDENT_MAP_URL", studentUrls);

        HashMap<String, String> adminUrls = null;
        AdminRoleDAO adminDao = new AdminRoleDAO();
        try {
            adminUrls = adminDao.loadAdminURLs();
        } catch (IOException ex) {
            log("Error at FilterDispatcher(init): " + ex.getMessage());
        }
        this.getFilterConfig().getServletContext().setAttribute("ADMIN_MAP_URL", adminUrls);
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("DispatchFilter()");
        }
        StringBuffer sb = new StringBuffer("DispatchFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg + "a");
    }

}
