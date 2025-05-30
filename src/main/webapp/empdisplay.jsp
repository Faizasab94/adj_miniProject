<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.EmployeeDAO" %>
<%@ page import="com.model.Employee" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Employees</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 15px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-search {
            background-color: #2196F3;
        }
        .btn-search:hover {
            background-color: #0b7dda;
        }
        .btn-display-all {
            background-color: #4CAF50;
            display: block;
            width: 200px;
            margin: 20px auto;
            text-align: center;
            text-decoration: none;
        }
        .btn-display-all:hover {
            background-color: #45a049;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #666;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .employee-details {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .employee-details p {
            margin: 8px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }
        .failure {
            background-color: #f2dede;
            color: #a94442;
        }
    </style>
    <script>
        function validateSearch() {
            var empno = document.getElementById("searchEmpno").value;
            
            if (empno == "") {
                alert("Employee Number is required for search!");
                return false;
            }
            
            if (isNaN(empno) || empno <= 0) {
                alert("Employee Number must be a positive number!");
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Display Employees</h1>
        
        <form action="display" method="get" onsubmit="return validateSearch()">
            <div class="form-group">
                <label for="searchEmpno">Enter Employee Number to Search:</label>
                <input type="number" id="searchEmpno" name="empno" required>
            </div>
            <button type="submit" class="btn btn-search">Search</button>
        </form>
        
        <a href="display?action=all" class="btn btn-display-all">Display All Employees</a>
        
        <% 
            String empnoParam = request.getParameter("empno");
            String action = request.getParameter("action");
            
            if (empnoParam != null && !empnoParam.isEmpty()) {
                int empno = Integer.parseInt(empnoParam);
                EmployeeDAO employeeDAO = new EmployeeDAO();
                Employee employee = employeeDAO.selectEmployee(empno);
                
                if (employee != null) {
        %>
        
        <div class="employee-details">
            <h3>Employee Details</h3>
            <p><strong>Employee Number:</strong> <%= employee.getEmpno() %></p>
            <p><strong>Name:</strong> <%= employee.getEmpName() %></p>
            <p><strong>Date of Joining:</strong> <%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(employee.getDoj()) %></p>
            <p><strong>Gender:</strong> <%= employee.getGender() %></p>
            <p><strong>Basic Salary:</strong> <%= employee.getBsalary() %></p>
        </div>
        
        <% 
                } else {
        %>
        
        <div class="message failure">No employee found with ID <%= empno %>.</div>
        
        <% 
                }
            } else if (action != null && action.equals("all")) {
                EmployeeDAO employeeDAO = new EmployeeDAO();
                List<Employee> employees = employeeDAO.selectAllEmployees();
                
                if (employees != null && !employees.isEmpty()) {
        %>
        
        <table>
            <thead>
                <tr>
                    <th>Emp No</th>
                    <th>Name</th>
                    <th>Date of Joining</th>
                    <th>Gender</th>
                    <th>Basic Salary</th>
                </tr>
            </thead>
            <tbody>
                <% for (Employee employee : employees) { %>
                <tr>
                    <td><%= employee.getEmpno() %></td>
                    <td><%= employee.getEmpName() %></td>
                    <td><%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(employee.getDoj()) %></td>
                    <td><%= employee.getGender() %></td>
                    <td><%= employee.getBsalary() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <% 
                } else {
        %>
        
        <div class="message failure">No employees found in the database.</div>
        
        <% 
                }
            }
        %>
        
        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>
</body>
</html>