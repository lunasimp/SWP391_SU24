/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */

import java.security.MessageDigest;
import java.sql.Date;


public class User {

    private int userID;
    private String fullName;
    private String email;
    private int role;
    private Date dob;
    private boolean gender;
    private String phoneNumber;
    private Date restrictUntil;
    private String restrictReason;

    public User() {
    }

    public User(int userID, String fullName, String email, int role, Date dob, boolean gender, String phoneNumber, Date restrictUntil, String restrictReason) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.role = role;
        this.dob = dob;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.restrictUntil = restrictUntil;
        this.restrictReason = restrictReason;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public Date getRestrictUntil() {
        return restrictUntil;
    }

    public void setRestrictUntil(Date restrictUntil) {
        this.restrictUntil = restrictUntil;
    }

    public String getRestrictReason() {
        return restrictReason;
    }

    public void setRestrictReason(String restrictReason) {
        this.restrictReason = restrictReason;
    }
    
}
