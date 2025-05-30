<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.EmployeeDAO" %>
<%@ page import="com.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Employee</title>
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
        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
        }
        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
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
        .error {
            color: red;
            margin-top: 5px;
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
        function validateForm() {
            var empName = document.getElementById("empName").value;
            var doj = document.getElementById("doj").value;
            var gender = document.getElementById("gender").value;
            var bsalary = document.getElementById("bsalary").value;
            
            if (empName == "" || doj == "" || gender == "" || bsalary == "") {
                alert("All fields are required!");
                return false;
            }
            
            if (isNaN(bsalary) || bsalary <= 0) {
                alert("Basic Salary must be a positive number!");
                return false;
            }
            
            return true;
        }
        
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
        <h1>Update Employee</h1>
        
        <form action="update" method="get" onsubmit="return validateSearch()">
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
        
        <form action="update" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="empno" value="<%= employee.getEmpno() %>">
            <div class="form-group">
                <label for="empName">Employee Name:</label>
                <input type="text" id="empName" name="empName" value="<%= employee.getEmpName() %>" required>
            </div>
            <div class="form-group">
                <label for="doj">Date of Joining:</label>
                <input type="date" id="doj" name="doj" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(employee.getDoj()) %>" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="Male" <%= "Male".equals(employee.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(employee.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(employee.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="bsalary">Basic Salary:</label>
                <input type="number" id="bsalary" name="bsalary" step="0.01" value="<%= employee.getBsalary() %>" required>
            </div>
            <button type="submit" class="btn">Update Employee</button>
        </form>
        
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