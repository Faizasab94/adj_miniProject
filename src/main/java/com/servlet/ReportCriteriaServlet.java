/*package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;
import com.model.Employee;

@WebServlet("/report-criteria")
public class ReportCriteriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("type");
        String reportTitle = "";
        String criteria = "";
        List<Employee> employees = null;
        
        try {
            if ("name_start".equals(reportType)) {
                String startLetter = request.getParameter("startLetter");
                reportTitle = "Employees Whose Names Start With '" + startLetter + "'";
                criteria = "Names starting with: " + startLetter;
                employees = employeeDAO.selectEmployeesByNameStart(startLetter);
            } else if ("years_of_service".equals(reportType)) {
                int years = Integer.parseInt(request.getParameter("years"));
                reportTitle = "Employees With " + years + " or More Years of Service";
                criteria = "Minimum years of service: " + years;
                employees = employeeDAO.selectEmployeesByYearsOfService(years);
            } else if ("salary".equals(reportType)) {
                double salary = Double.parseDouble(request.getParameter("salary"));
                reportTitle = "Employees Earning More Than " + salary;
                criteria = "Minimum salary: " + salary;
                employees = employeeDAO.selectEmployeesBySalary(salary);
            }
            
            // Set attributes for the report result page
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("criteria", criteria);
            request.setAttribute("employees", employees);
            
            // Forward to the report result JSP
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error: Invalid number format.");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }
}*/

package com.servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;
import com.model.Employee;

/**
 * Servlet implementation class ReportCriteriaServlet
 * Handles report form submissions and processes different report types
 */
@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private EmployeeDAO employeeDAO;
    
    public void init() {
        employeeDAO = new EmployeeDAO();
    }
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportCriteriaServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String reportType = request.getParameter("reportType");
            List<Employee> employees = null;
            String reportCriteria = "";
            
            // Process based on report type
            if ("startsWith".equals(reportType)) {
                // Get employees with names starting with specified letter
                String startLetter = request.getParameter("startLetter");
                if (startLetter != null && startLetter.length() == 1) {
                    employees = employeeDAO.getEmployeesWithNameStartingWith(startLetter);
                    reportCriteria = "Employees whose names start with '" + startLetter + "'";
                } else {
                    request.setAttribute("errorMessage", "Please enter a valid single letter.");
                }
            } 
            else if ("yearsOfService".equals(reportType)) {
                // Get employees with specified years of service
                try {
                    int years = Integer.parseInt(request.getParameter("yearsOfService"));
                    if (years > 0) {
                        // Calculate the date N years ago
                        LocalDate currentDate = LocalDate.now();
                        LocalDate dateNYearsAgo = currentDate.minusYears(years);
                        
                        // Convert to SQL Date
                        Date thresholdDate = Date.valueOf(dateNYearsAgo);
                        
                        employees = employeeDAO.getEmployeesWithServiceYears(thresholdDate);
                        reportCriteria = "Employees with " + years + " or more years of service";
                    } else {
                        request.setAttribute("errorMessage", "Years of service must be a positive number.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid years of service value.");
                }
            } 
            else if ("salaryThreshold".equals(reportType)) {
                // Get employees earning more than specified salary
                try {
                    double minSalary = Double.parseDouble(request.getParameter("minSalary"));
                    if (minSalary >= 0) {
                        employees = employeeDAO.getEmployeesAboveSalary(minSalary);
                        reportCriteria = "Employees earning more than " + minSalary;
                    } else {
                        request.setAttribute("errorMessage", "Salary must be a non-negative value.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid salary value.");
                }
            } 
            else {
                request.setAttribute("errorMessage", "Invalid report type.");
            }
            
            // Set attributes for the report results
            if (employees != null) {
                request.setAttribute("employees", employees);
                request.setAttribute("reportCriteria", reportCriteria);
                
                if (employees.isEmpty()) {
                    request.setAttribute("noResults", true);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }
        
        // Forward to the reports page to display results
        RequestDispatcher dispatcher = request.getRequestDispatcher("reports.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to the reports page
        response.sendRedirect("reports.jsp");
    }
}
