package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;

@WebServlet("/display")
public class DisplayEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // The JSP page directly calls the DAO methods to display employee(s)
        request.getRequestDispatcher("empdisplay.jsp").forward(request, response);
    }
}