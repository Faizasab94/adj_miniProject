package com.model;

import java.util.Date;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.Period;
import java.time.temporal.ChronoUnit; // ADD THIS IMPORT

public class Employee implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int empno;
    private String empName;
    private Date doj;
    private String gender;
    private double bsalary;
    
    // Default constructor
    public Employee() {
    }
    
    // Parameterized constructor
    public Employee(int empno, String empName, Date doj, String gender, double bsalary) {
        this.empno = empno;
        this.empName = empName;
        this.doj = doj;
        this.gender = gender;
        this.bsalary = bsalary;
    }
    
    // Getters and Setters
    public int getEmpno() {
        return empno;
    }
    
    public void setEmpno(int empno) {
        this.empno = empno;
    }
    
    public String getEmpName() {
        return empName;
    }
    
    public void setEmpName(String empName) {
        this.empName = empName;
    }
    
    public Date getDoj() {
        return doj;
    }
    
    public void setDoj(Date doj) {
        this.doj = doj;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public double getBsalary() {
        return bsalary;
    }
    
    public void setBsalary(double bsalary) {
        this.bsalary = bsalary;
    }
    
    // Helper methods for reports
    
    /**
     * Check if employee name starts with the given letter
     * @param letter the letter to check
     * @return true if the name starts with the letter, false otherwise
     */
    public boolean nameStartsWith(String letter) {
        return empName != null && empName.toUpperCase().startsWith(letter.toUpperCase());
    }
    
    /**
     * Get years of service of the employee
     * @return number of years the employee has been working
     */
    public int getYearsOfService() {
        if (this.doj == null) { // FIXED: Use this.doj instead of dateOfJoining
            return 0;
        }
        
        // Get current date
        java.util.Date currentDate = new java.util.Date();
        
        // Calculate difference in milliseconds
        long diffInMillies = currentDate.getTime() - this.doj.getTime();
        
        // Convert to years (approximate)
        return (int)(diffInMillies / (1000L * 60 * 60 * 24 * 365));
    }
    
    /**
     * Get service years using LocalDate (more accurate)
     * @return number of service years
     */
    public long getServiceYears() {
        if (this.doj != null) {
            // Convert Date to LocalDate
            LocalDate joinDate = this.doj.toInstant()
                                        .atZone(ZoneId.systemDefault())
                                        .toLocalDate();
            LocalDate currentDate = LocalDate.now();
            return ChronoUnit.YEARS.between(joinDate, currentDate);
        }
        return 0;
    }
    
    /**
     * Check if employee has more than or equal to specified years of service
     * @param years the number of years to check
     * @return true if employee has specified or more years of service
     */
    public boolean hasMinimumYearsOfService(int years) {
        return getYearsOfService() >= years;
    }
    
    /**
     * Check if employee salary is above the specified threshold
     * @param threshold the salary threshold
     * @return true if salary is above threshold, false otherwise
     */
    public boolean salaryAboveThreshold(double threshold) {
        return bsalary > threshold;
    }
    
    /**
     * Format date of joining as string
     * @return formatted date string
     */
    public String getFormattedDoj() {
        if (doj == null) {
            return "N/A";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(doj);
    }
    
    /**
     * Format salary as string with currency symbol
     * @return formatted salary string
     */
    public String getFormattedSalary() {
        return String.format("$%.2f", bsalary);
    }
    
    @Override
    public String toString() {
        return "Employee [ID=" + empno + 
               ", Name=" + empName + 
               ", DOJ=" + getFormattedDoj() + 
               ", Gender=" + gender + 
               ", Salary=" + getFormattedSalary() + 
               ", Service=" + getYearsOfService() + " years]";
    }
}