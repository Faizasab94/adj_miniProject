package com.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;

@WebServlet("/delete")
public class DeleteEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the JSP page with the form
        request.getRequestDispatcher("empdelete.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get employee ID to delete
            int empno = Integer.parseInt(request.getParameter("empno"));
            
            try {
                // Delete employee from database
                boolean deleted = employeeDAO.deleteEmployee(empno);
                
                if (deleted) {
                    request.setAttribute("message", "Employee deleted successfully!");
                } else {
                    request.setAttribute("message", "Error: Could not delete employee.");
                }
            } catch (SQLException e) {
                request.setAttribute("message", "Error: Could not delete employee. " + e.getMessage());
            }
            
            // Forward to result page
            request.getRequestDispatcher("empdelete.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error: Invalid employee number.");
            request.getRequestDispatcher("empdelete.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("empdelete.jsp").forward(request, response);
        }
    }
}