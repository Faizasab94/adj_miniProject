<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
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
        }
        .btn:hover {
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
        .error {
            color: red;
            margin-top: 5px;
        }
    </style>
    <script>
        function validateForm() {
            var empno = document.getElementById("empno").value;
            var empName = document.getElementById("empName").value;
            var doj = document.getElementById("doj").value;
            var gender = document.getElementById("gender").value;
            var bsalary = document.getElementById("bsalary").value;
            
            if (empno == "" || empName == "" || doj == "" || gender == "" || bsalary == "") {
                alert("All fields are required!");
                return false;
            }
            
            if (isNaN(empno) || empno <= 0) {
                alert("Employee Number must be a positive number!");
                return false;
            }
            
            if (isNaN(bsalary) || bsalary <= 0) {
                alert("Basic Salary must be a positive number!");
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Add New Employee</h1>
        <form action="add" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="empno">Employee Number:</label>
                <input type="number" id="empno" name="empno" required>
            </div>
            <div class="form-group">
                <label for="empName">Employee Name:</label>
                <input type="text" id="empName" name="empName" required>
            </div>
            <div class="form-group">
                <label for="doj">Date of Joining:</label>
                <input type="date" id="doj" name="doj" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="">Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="bsalary">Basic Salary:</label>
                <input type="number" id="bsalary" name="bsalary" step="0.01" required>
            </div>
            <button type="submit" class="btn">Add Employee</button>
        </form>
        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>
</body>
</html>