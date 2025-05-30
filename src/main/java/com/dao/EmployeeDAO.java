package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.model.Employee;

public class EmployeeDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/employee_management";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";
    
    private static final String INSERT_EMPLOYEE_SQL = "INSERT INTO Employee (Empno, EmpName, DoJ, Gender, Bsalary) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_EMPLOYEE_BY_ID = "SELECT * FROM Employee WHERE Empno = ?";
    private static final String SELECT_ALL_EMPLOYEES = "SELECT * FROM Employee";
    private static final String DELETE_EMPLOYEE_SQL = "DELETE FROM Employee WHERE Empno = ?";
    private static final String UPDATE_EMPLOYEE_SQL = "UPDATE Employee SET EmpName = ?, DoJ = ?, Gender = ?, Bsalary = ? WHERE Empno = ?";
    private static final String SELECT_EMPLOYEES_BY_NAME_START = "SELECT * FROM Employee WHERE EmpName LIKE ?";
    private static final String SELECT_EMPLOYEES_BY_YEARS_OF_SERVICE = "SELECT * FROM Employee WHERE DATEDIFF(CURDATE(), DoJ)/365 >= ?";
    private static final String SELECT_EMPLOYEES_BY_SALARY = "SELECT * FROM Employee WHERE Bsalary > ?";
    
    // Constructor
    public EmployeeDAO() {
    }
    
    // Get Connection method
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
    
    // Insert Employee
    public void insertEmployee(Employee employee) throws SQLException {
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_EMPLOYEE_SQL)) {
            preparedStatement.setInt(1, employee.getEmpno());
            preparedStatement.setString(2, employee.getEmpName());
            preparedStatement.setDate(3, new java.sql.Date(employee.getDoj().getTime()));
            preparedStatement.setString(4, employee.getGender());
            preparedStatement.setDouble(5, employee.getBsalary());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }
    
    // Select Employee by ID
    public Employee selectEmployee(int empno) {
        Employee employee = null;
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEE_BY_ID)) {
            preparedStatement.setInt(1, empno);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                String empName = rs.getString("EmpName");
                Date doj = rs.getDate("DoJ");
                String gender = rs.getString("Gender");
                double bsalary = rs.getDouble("Bsalary");
                employee = new Employee(empno, empName, doj, gender, bsalary);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employee;
    }
    
    // Select All Employees
    public List<Employee> selectAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_EMPLOYEES)) {
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                int empno = rs.getInt("Empno");
                String empName = rs.getString("EmpName");
                Date doj = rs.getDate("DoJ");
                String gender = rs.getString("Gender");
                double bsalary = rs.getDouble("Bsalary");
                employees.add(new Employee(empno, empName, doj, gender, bsalary));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employees;
    }
    
    // Update Employee
    public boolean updateEmployee(Employee employee) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(UPDATE_EMPLOYEE_SQL)) {
            statement.setString(1, employee.getEmpName());
            statement.setDate(2, new java.sql.Date(employee.getDoj().getTime()));
            statement.setString(3, employee.getGender());
            statement.setDouble(4, employee.getBsalary());
            statement.setInt(5, employee.getEmpno());
            
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
    
    // Delete Employee
    public boolean deleteEmployee(int empno) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(DELETE_EMPLOYEE_SQL)) {
            statement.setInt(1, empno);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
    
    // Report: Employees whose names start with a specific letter
    public List<Employee> selectEmployeesByNameStart(String startLetter) {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEES_BY_NAME_START)) {
            preparedStatement.setString(1, startLetter + "%");
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                int empno = rs.getInt("Empno");
                String empName = rs.getString("EmpName");
                Date doj = rs.getDate("DoJ");
                String gender = rs.getString("Gender");
                double bsalary = rs.getDouble("Bsalary");
                employees.add(new Employee(empno, empName, doj, gender, bsalary));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employees;
    }
    
    // Report: Employees with N or more years of service
    public List<Employee> selectEmployeesByYearsOfService(int years) {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEES_BY_YEARS_OF_SERVICE)) {
            preparedStatement.setInt(1, years);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                int empno = rs.getInt("Empno");
                String empName = rs.getString("EmpName");
                Date doj = rs.getDate("DoJ");
                String gender = rs.getString("Gender");
                double bsalary = rs.getDouble("Bsalary");
                employees.add(new Employee(empno, empName, doj, gender, bsalary));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employees;
    }
    
    // Report: Employees earning more than a specified salary
    public List<Employee> selectEmployeesBySalary(double minSalary) {
        List<Employee> employees = new ArrayList<>();
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEES_BY_SALARY)) {
            preparedStatement.setDouble(1, minSalary);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                int empno = rs.getInt("Empno");
                String empName = rs.getString("EmpName");
                Date doj = rs.getDate("DoJ");
                String gender = rs.getString("Gender");
                double bsalary = rs.getDouble("Bsalary");
                employees.add(new Employee(empno, empName, doj, gender, bsalary));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return employees;
    }
    
 // Method to get employees whose names start with a specific letter
    public List<Employee> getEmployeesWithNameStartingWith(String letter) {
        List<Employee> employees = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Employee WHERE EmpName LIKE ? ORDER BY EmpName")) {
            stmt.setString(1, letter + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                employees.add(extractEmployeeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    // Method to get employees with service years greater than threshold date
    public List<Employee> getEmployeesWithServiceYears(java.sql.Date thresholdDate) {
        List<Employee> employees = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Employee WHERE DoJ <= ? ORDER BY DoJ")) {
            stmt.setDate(1, thresholdDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                employees.add(extractEmployeeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    // Method to get employees earning more than a specified salary
    public List<Employee> getEmployeesAboveSalary(double minSalary) {
        List<Employee> employees = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Employee WHERE Bsalary > ? ORDER BY Bsalary DESC")) {
            stmt.setDouble(1, minSalary);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                employees.add(extractEmployeeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    // Helper method to extract employee data from ResultSet
    private Employee extractEmployeeFromResultSet(ResultSet rs) throws SQLException {
        Employee employee = new Employee();
        employee.setEmpno(rs.getInt("Empno"));
        employee.setEmpName(rs.getString("EmpName"));
        employee.setDoj(rs.getDate("DoJ"));
        employee.setGender(rs.getString("Gender"));
        employee.setBsalary(rs.getDouble("Bsalary"));
        return employee;
    }
    
    // Print SQL Exception method
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}