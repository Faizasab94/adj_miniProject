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

@WebServlet("/update")
public class UpdateEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the JSP page with the form
        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NumberFormatException {
        try {
            // Get form data
            int empno = Integer.parseInt(request.getParameter("empno"));
            String empName = request.getParameter("empName");
            
            // Parse date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date doj = dateFormat.parse(request.getParameter("doj"));
            
            String gender = request.getParameter("gender");
            double bsalary = Double.parseDouble(request.getParameter("bsalary"));
            
            // Create employee with updated data
            Employee updatedEmployee = new Employee(empno, empName, doj, gender, bsalary);
            
            try {
                // Update employee in database
                boolean updated = employeeDAO.updateEmployee(updatedEmployee);
                
                if (updated) {
                    request.setAttribute("message", "Employee updated successfully!");
                } else {
                    request.setAttribute("message", "Error: Could not update employee.");
                }
            } catch (SQLException e) {
                request.setAttribute("message", "Error: Could not update employee. " + e.getMessage());
            }
            
            // Forward to result page
            request.getRequestDispatcher("empupdate.jsp").forward(request, response);
            
        } catch (ParseException e) {
            request.setAttribute("message", "Error: Invalid date format.");
            request.getRequestDispatcher("empupdate.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error: Invalid number format.");
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("empupdate.jsp").forward(request, response);
        }
    }
}