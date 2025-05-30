<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.dao.EmployeeDAO" %>
<%@ page import="com.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
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
        .btn-delete {
            background-color: #f44336;
        }
        .btn-delete:hover {
            background-color: #d32f2f;
        }
        .btn-search {
            background-color: #2196F3;
        }
        .btn-search:hover {
            background-color: #0b7dda;
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
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }
        .success {
            background-color: #dff0d8;
            color: #3c763d;
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
        
        function confirmDelete() {
            return confirm("Are you sure you want to delete this employee?");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Delete Employee</h1>
        
        <form action="delete" method="get" onsubmit="return validateSearch()">
            <div class="form-group">
                <label for="searchEmpno">Enter Employee Number to Search:</label>
                <input type="number" id="searchEmpno" name="empno" required>
            </div>
            <button type="submit" class="btn btn-search">Search</button>
        </form>
        
        <% 
            String empnoParam = request.getParameter("empno");
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
            
            <form action="delete" method="post" onsubmit="return confirmDelete()">
                <input type="hidden" name="empno" value="<%= employee.getEmpno() %>">
                <button type="submit" class="btn btn-delete">Delete Employee</button>
            </form>
        </div>
        
        <% 
                } else {
        %>
        
        <div class="message failure">No employee found with ID <%= empno %>.</div>
        
        <% 
                }
            }
            
            String message = (String) request.getAttribute("message");
            if (message != null) {
                String messageClass = message.startsWith("Error") ? "failure" : "success";
        %>
        
        <div class="message <%= messageClass %>"><%= message %></div>
        
        <% } %>
        
        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>
</body>
</html>