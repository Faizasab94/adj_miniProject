<%@ page import="java.util.*, com.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            max-width: 900px;
            margin-top: 60px;
            margin-bottom: 40px;
            background: #fff;
            padding: 30px 35px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        h2 {
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
        }
        .btn-secondary, .btn-print {
            margin-bottom: 20px;
            margin-right: 10px;
        }
        table {
            font-size: 0.95rem;
        }
        thead.thead-dark {
            background-color: #343a40;
            color: #fff;
        }
        .alert-warning {
            font-weight: 500;
            font-size: 1rem;
            text-align: center;
            margin-top: 30px;
        }
    </style>
    <script>
        function printReport() {
            window.print();
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Report Results</h2>
    <a href="report_form.jsp" class="btn btn-secondary">Back</a>
    <button class="btn btn-info btn-print" onclick="printReport()">Print</button>

    <%
        List<Employee> reportData = (List<Employee>) request.getAttribute("reportData");
        if (reportData != null && !reportData.isEmpty()) {
    %>
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Empno</th>
                    <th>Name</th>
                    <th>Date of Joining</th>
                    <th>Gender</th>
                    <th>Basic Salary</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Employee emp : reportData) {
                %>
                <tr>
                    <td><%= emp.getEmpno() %></td>
                    <td><%= emp.getEmpName() %></td>
                    <td><%= emp.getDoj() %></td>
                    <td><%= emp.getGender() %></td>
                    <td><%= emp.getBsalary() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <div class="alert alert-warning">No records found for the selected criteria.</div>
    <%
        }
    %>
</div>
</body>
</html>
