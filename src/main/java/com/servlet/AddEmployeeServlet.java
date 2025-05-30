package com.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;
import com.model.Employee;

@WebServlet("/add")
public class AddEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form data
            int empno = Integer.parseInt(request.getParameter("empno"));
            String empName = request.getParameter("empName");
            
            // Parse date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date doj = dateFormat.parse(request.getParameter("doj"));
            
            String gender = request.getParameter("gender");
            double bsalary = Double.parseDouble(request.getParameter("bsalary"));
            
            // Create new employee
            Employee newEmployee = new Employee(empno, empName, doj, gender, bsalary);
            
            try {
                // Add employee to database
                employeeDAO.insertEmployee(newEmployee);
                request.setAttribute("message", "Employee added successfully!");
            } catch (SQLException e) {
                request.setAttribute("message", "Error: Could not add employee. " + e.getMessage());
            }
            
            // Forward to result page
            request.getRequestDispatcher("empadd.jsp").forward(request, response);
            
        } catch (ParseException e) {
            request.setAttribute("message", "Error: Invalid date format.");
            request.getRequestDispatcher("empadd.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error: Invalid number format.");
            request.getRequestDispatcher("empadd.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("empadd.jsp").forward(request, response);
        }
    }
}