/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.file;

import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import loiqd.user.UserDTO;

/**
 *
 * @author GF65
 */
public class FilterSupport {

    private static String getAdminUrl(HttpServletRequest req, String resource) {
        ServletContext context = req.getServletContext();
        HashMap<String, String> urls = (HashMap<String, String>) context.getAttribute("ADMIN_MAP_URL");
        return urls.get(resource);
    }

    private static String getStudentUrl(HttpServletRequest req, String resource) {
        ServletContext context = req.getServletContext();
        HashMap<String, String> authenUrls = (HashMap<String, String>) context.getAttribute("STUDENT_MAP_URL");
        return authenUrls.get(resource);
    }

    public static String getUrl(HttpServletRequest request, String resource) {
        String url = "index.jsp";
        HttpSession session = request.getSession();

        UserDTO user = (UserDTO) session.getAttribute("USER");
        if (user != null) { //when user loged in
            if (user.isRole()) {
                if (!resource.isEmpty()) { 
                    url = getAdminUrl(request, resource);
                    if(url == null) {
                        return getAdminUrl(request, "home");
                    } else {
                        return url;
                    }
                } else { //when the first time open web and loged in
                    return getAdminUrl(request, "home");
                }
            } else {
                if (!resource.isEmpty()) {
                    url = getStudentUrl(request, resource);
                    if(url == null) {
                        return getStudentUrl(request, "home");
                    } else {
                        return url;
                    }
                } else { //when the first time open web and loged in
                    return getStudentUrl(request, "home");
                }
            }
        }
        //when user didn't log in
        return url;
    }

    public static String getResource(ServletRequest req) {
        HttpServletRequest request = (HttpServletRequest) req;
        String uri = request.getRequestURI();
        int lastIndex = uri.lastIndexOf("/");
        String resource = uri.substring(lastIndex + 1);
        return resource;
    }
    
    public static String getRole(HttpServletRequest request) {
        String role = null;
        HttpSession session = request.getSession();
        if (session != null) {
            UserDTO user = (UserDTO) session.getAttribute("USER");
            if(user != null) {
                boolean isRole = user.isRole();
                if(isRole) {
                    role = "teacher";
                } else {
                    role = "student";
                }
            }
        }
        return role;
    }
}
