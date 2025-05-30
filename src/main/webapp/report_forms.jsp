<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Reports</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .form-container {
            max-width: 550px;
            margin: 60px auto 30px;
            padding: 30px 35px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        h2 {
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
        }
        .btn-group {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-container">
        <h2>📊 Employee Reports</h2>
        <form action="ReportCriteriaServlet" method="post" class="mt-3">
            <div class="form-group">
                <label>Select Report Type:</label>
                <select name="reportType" class="form-control" required>
                    <option value="">--Select--</option>
                    <option value="nameStart">Employees whose names start with a letter</option>
                    <option value="yearsOfService">Employees with N or more years of service</option>
                    <option value="highSalary">Employees earning more than a specified salary</option>
                </select>
            </div>
            <div class="form-group">
                <label>Enter Value (Letter / Years / Salary):</label>
                <input type="text" name="value" class="form-control" required>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Generate Report</button>
                <a href="index.jsp" class="btn btn-secondary ml-2">Back</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
