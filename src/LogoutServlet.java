import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
        
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        
        //expire the session to log out
        request.getSession().invalidate();
        
        
        Cookie loginCookie = null;
        Cookie loginCookie1=null;
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("user")){
                loginCookie = cookie;
                break;
            }
        }
        }
        if(loginCookie != null){
            loginCookie.setMaxAge(0);
            response.addCookie(loginCookie);
        }
        //logout the cookies
        //it actually sets the cookies time to 0, to finish the cookies
        
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("user")){
                    loginCookie1 = cookie;
                    break;
                }
            }
            }
            if(loginCookie1 != null){
                loginCookie1.setMaxAge(0);
                response.addCookie(loginCookie1);
            }
          //logout the cookies
          //it actually sets the cookies time to 0, to finish the cookies  
          
            
        response.sendRedirect("login.jsp");
    }
 
}
