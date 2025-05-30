<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Employee" %>

<%@ page import="java.time.*, java.time.temporal.ChronoUnit" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 30px;
        }
        .card {
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
            height: 100%;
        }
        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
            text-align: center;
        }
        .btn-primary {
            background-color: #007bff;
            width: 100%;
        }
        .navbar {
            background-color: #343a40;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .result-table {
            margin-top: 40px;
        }
        .table th {
            background-color: #343a40;
            color: white;
            text-align: center;
            vertical-align: middle;
        }
        .table td {
            text-align: center;
            vertical-align: middle;
        }
        .report-criteria {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .page-title {
            color: #343a40;
            font-weight: 600;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">Employee Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="empadd.jsp">Add Employee</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="empupdate.jsp">Update Employee</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="empdelete.jsp">Delete Employee</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="empdisplay.jsp">Display Employees</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="reports.jsp">Reports</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2 class="text-center page-title">Employee Reports</h2>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-search"></i> Names Starting With Letter
                    </div>
                    <div class="card-body d-flex flex-column">
                        <p class="card-text">Find employees whose names start with a specific letter.</p>
                        <form action="ReportCriteriaServlet" method="post" class="mt-auto">
                            <input type="hidden" name="reportType" value="startsWith">
                            <div class="mb-3">
                                <label for="startLetter" class="form-label">Starting Letter:</label>
                                <input type="text" class="form-control" id="startLetter" name="startLetter" 
                                       maxlength="1" required pattern="[A-Za-z]" 
                                       title="Please enter a single letter" placeholder="e.g., A">
                            </div>
                            <button type="submit" class="btn btn-primary">Generate Report</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-calendar"></i> Years of Service
                    </div>
                    <div class="card-body d-flex flex-column">
                        <p class="card-text">Find employees with N or more years of service.</p>
                        <form action="ReportCriteriaServlet" method="post" class="mt-auto">
                            <input type="hidden" name="reportType" value="yearsOfService">
                            <div class="mb-3">
                                <label for="yearsOfService" class="form-label">Minimum Years:</label>
                                <input type="number" class="form-control" id="yearsOfService" name="yearsOfService" 
                                       min="0" max="50" required placeholder="e.g., 5">
                            </div>
                            <button type="submit" class="btn btn-primary">Generate Report</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-dollar-sign"></i> Salary Threshold
                    </div>
                    <div class="card-body d-flex flex-column">
                        <p class="card-text">Find employees earning more than a specified salary.</p>
                        <form action="ReportCriteriaServlet" method="post" class="mt-auto">
                            <input type="hidden" name="reportType" value="salaryThreshold">
                            <div class="mb-3">
                                <label for="minSalary" class="form-label">Minimum Salary:</label>
                                <input type="number" class="form-control" id="minSalary" name="minSalary" 
                                       min="0" step="1000" required placeholder="e.g., 50000">
                            </div>
                            <button type="submit" class="btn btn-primary">Generate Report</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Display report results if available -->
        <% if(request.getAttribute("employees") != null) { 
            List<Employee> employees = (List<Employee>)request.getAttribute("employees");
        %>
            <div class="result-table">
                <h3 class="mb-3">Report Results</h3>
                <div class="report-criteria">
                    <strong>Criteria:</strong> <%= request.getAttribute("reportCriteria") %>
                </div>
                
                <% if(employees.size() > 0) { %>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th style="width: 15%;">Employee ID</th>
                                    <th style="width: 20%;">Name</th>
                                    <th style="width: 20%;">Date of Joining</th>
                                    <th style="width: 15%;">Gender</th>
                                    <th style="width: 20%;">Basic Salary</th>
                                    <th style="width: 10%;">Service Years</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for(Employee emp : employees) { %>
                                    <tr>
                                        <td><%= emp.getEmpno() %></td>
                                        <td><%= emp.getEmpName() %></td>
                                        <td><%= emp.getDoj() %></td>
                                        <td><%= emp.getGender() %></td>
                                        <td>$<%= String.format("%.2f", emp.getBsalary()) %></td>
                                        <td><%= emp.getYearsOfService() %> years</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="mt-3">
                        <p class="text-muted">Total Records Found: <strong><%= employees.size() %></strong></p>
                        <button class="btn btn-success" onclick="window.print()">
                            <i class="fas fa-print"></i> Print Report
                        </button>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> No employees found matching the specified criteria.
                    </div>
                <% } %>
            </div>
        <% } %>
        
        <!-- Display no results message -->
        <% if(request.getAttribute("noResults") != null && (Boolean)request.getAttribute("noResults")) { %>
            <div class="alert alert-info mt-4">
                <i class="fas fa-info-circle"></i> No employees found matching the specified criteria.
            </div>
        <% } %>
        
        <!-- Display any error messages -->
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger mt-4">
                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
</body>
</html>