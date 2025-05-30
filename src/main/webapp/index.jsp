<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management System</title>
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
        .btn-container {
            display: flex;
                        justify-content: space-around;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            width: 150px;
        }
        .btn:hover {
            background-color: #45a049;
        
.footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #666;
            font-size: 14px;
            
text-align: center;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 20px;
            }

            .header h1 {
                font-size: 2em;
            }

            .button-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Employee Management System</h1>
        <div class="btn-container">
            <a href="empadd.jsp" class="btn">Add Employee</a>
            <a href="empupdate.jsp" class="btn">Update Employee</a>
            <a href="empdelete.jsp" class="btn">Delete Employee</a>
            <a href="empdisplay.jsp" class="btn">Display Employee</a>
        </div>
        <div class="btn-container" style="margin-top: 20px;">
            <a href="reports.jsp" class="btn">Generate Reports</a>
        </div>
         
 
<div class="text-center">© 2025 Employee Salary Management System | Developed by Faiza</div>
    </div>

    <script>
        // Add some interactive functionality
        document.addEventListener('DOMContentLoaded', function() {
            const buttons = document.querySelectorAll('.btn');
            
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    // Add click animation
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
        });
    </script>
</body>
</html>